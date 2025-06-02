import 'dart:async';

import 'package:buildconnect/core/constants/supabase_constants.dart';
import 'package:buildconnect/models/conversation/conversation_model.dart';
import 'package:buildconnect/models/message/message_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ConversationService {
  final SupabaseClient _supabaseClient;

  ConversationService(this._supabaseClient);
  Future<List<ConversationModel>> fetchConversations() async {
    final uid = _supabaseClient.auth.currentUser?.id;
    if (uid == null) throw Exception('User not logged in');

    final List<dynamic> rows = await _supabaseClient.rpc(
      'get_conversations',
      params: {'p_uid': uid},
    );

    return rows
        .map(
          (r) => ConversationModel(
            partnerId: r['partner_id'] as String,
            partnerDisplayName: r['partner_name'] as String,
            unreadCount: r['unread_count'] as int,
            lastMessage: Message(
              id: r['last_msg_id'] as String,
              content: r['last_content'] ?? '',
              userFrom_id: r['last_sender'] as String,
              userTo_id: uid,
              createAt: DateTime.parse(r['last_ts'] as String),
              markAsRead: true, // bạn có thể không cần trường này ở preview
            ),
          ),
        )
        .toList();
  }

  Future<int> countAllUnreadMessages() async {
    final currentUser = _supabaseClient.auth.currentUser;
    if (currentUser == null) {
      throw Exception("User not logged in");
    }
    final currentUserId = currentUser.id;

    try {
      final unreadMessagesResponse = await _supabaseClient
          .from(SupabaseConstants.messagesTable)
          .select('id')
          .eq('user_to', currentUserId)
          .eq('mark_as_read', false);

      return unreadMessagesResponse.length ?? 0;
    } catch (e) {
      debugPrint('Error counting unread messages: $e');
      rethrow;
    }
  }

  Stream<void> subscribeToNewMessageRead(String userId) {
    debugPrint('Subscribing to new notifications for user $userId');
    // Tên kênh có thể là duy nhất cho mỗi user hoặc một kênh chung (nếu RLS xử lý tốt)
    final controller = StreamController<void>();

    _supabaseClient
        .channel('public:${SupabaseConstants.messagesTable}')
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: SupabaseConstants.messagesTable,
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user_to',
            value: userId,
          ),
          callback: (payload) {
            final newData = payload.newRecord;
            if (newData != null) {
              controller.add(null);
            }
          },
        )
        .subscribe();

    return controller.stream;
  }

  Stream<int> streamTotalUnreadMessagesCount() {
    final currentUser = _supabaseClient.auth.currentUser;
    if (currentUser == null) {
      debugPrint(
        "User not logged in for unread count stream, returning stream of 0.",
      );
      return Stream.value(0); // Trả về stream chỉ có giá trị 0 nếu chưa login
    }
    final currentUserId = currentUser.id;

    late final StreamController<int> controller;
    controller = StreamController<int>(
      onListen: () async {
        debugPrint(
          'StreamTotalUnread: Listener added, fetching initial count for $currentUserId',
        );
        // Fetch count ban đầu và emit
        try {
          final initialCount = await countAllUnreadMessages();
          if (!controller.isClosed) controller.add(initialCount);
        } catch (e) {
          if (!controller.isClosed) controller.addError(e);
        }
      },
    );

    final String channelName =
        'public:${SupabaseConstants.messagesTable}:all_unread_count_updates';

    final RealtimeChannel realtimeChannel = _supabaseClient
        .channel(channelName)
        .onPostgresChanges(
          event: PostgresChangeEvent.all, // Lắng nghe INSERT, UPDATE, DELETE
          schema: 'public',
          table: SupabaseConstants.messagesTable,

          callback: (payload) async {
            debugPrint(
              'StreamTotalUnread: Change detected on messages table - ${payload.eventType}',
            );
            if (!controller.isClosed) {
              try {
                final newCount = await countAllUnreadMessages();
                if (!controller.isClosed) controller.add(newCount);
              } catch (e) {
                if (!controller.isClosed) controller.addError(e);
              }
            }
          },
        )
        .subscribe((status, [error]) async {
          if (status == RealtimeSubscribeStatus.subscribed) {
            debugPrint(
              'StreamTotalUnread: Successfully subscribed to $channelName',
            );
            if (!controller.isClosed) {
              try {
                final currentCount = await countAllUnreadMessages();
                if (!controller.isClosed) controller.add(currentCount);
              } catch (e) {
                if (!controller.isClosed) controller.addError(e);
              }
            }
          } else if (status == RealtimeSubscribeStatus.channelError ||
              status == RealtimeSubscribeStatus.closed) {
            debugPrint(
              'StreamTotalUnread: Subscription error/closed on $channelName - status: $status, error: $error',
            );
            if (!controller.isClosed) {
              controller.addError(
                error ??
                    Exception(
                      'Realtime subscription failed with status: $status',
                    ),
              );
            }
          }
        });

    controller.onCancel = () {
      debugPrint(
        'StreamTotalUnread: Listener removed, unsubscribing from Supabase channel $channelName',
      );
      _supabaseClient.removeChannel(realtimeChannel);
    };

    return controller.stream;
  }
}
