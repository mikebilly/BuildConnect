import 'dart:async';
import 'package:buildconnect/models/conversation/conversation_model.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/constants/supabase_constants.dart';
import '../../../models/message/message_model.dart';
import '../../../models/profile/profile_model.dart'; // Giả định có Profile model để lấy tên/avatar

class MessageService {
  final SupabaseClient _supabaseClient;

  MessageService(this._supabaseClient);

  // --- Các hàm sendMessage, fetchMessages, markMessagesAsRead, subscribeToNewMessages giữ nguyên như bạn đã code ---
  // ... (code các hàm đó ở đây) ...

  Future<Message> sendMessage({
    // ... (giữ nguyên) ...
    required String content,
    required String userFromId,
    required String userToId,
  }) async {
    try {
      final response =
          await _supabaseClient
              .from(SupabaseConstants.messagesTable)
              .insert({
                'content': content,
                'user_from': userFromId,
                'user_to': userToId,
              })
              .select()
              .single();

      final currentUser = _supabaseClient.auth.currentUser;
      final bool isMine = currentUser?.id == userFromId;

      return Message(
        id: response['id'] as String,
        content: response['content'] as String,
        markAsRead: response['mark_as_read'] as bool,
        userFrom_id: response['user_from'] as String,
        userTo_id: response['user_to'] as String,
        createAt: DateTime.parse(response['created_at'] as String),
        isMine: isMine,
      );
    } on PostgrestException catch (error) {
      debugPrint('Supabase Error (sendMessage): ${error.message}');
      throw Exception('Failed to send message: ${error.message}');
    } catch (e) {
      debugPrint('Unexpected error (sendMessage): $e');
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  Future<List<Message>> fetchMessages({
    // ... (giữ nguyên) ...
    required String userId1,
    required String userId2,
    int limit = 100,
  }) async {
    try {
      final currentUser = _supabaseClient.auth.currentUser;
      if (currentUser == null) {
        throw Exception("User not logged in");
      }

      final response = await _supabaseClient
          .from(SupabaseConstants.messagesTable)
          .select()
          .or(
            'and(user_from.eq.$userId1,user_to.eq.$userId2),' +
                'and(user_from.eq.$userId2,user_to.eq.$userId1)',
          )
          .order('created_at', ascending: true)
          .limit(limit);
      markMessagesAsRead(userToId: userId2, userFromId: userId1);
      return (response as List)
          .map(
            (item) => Message(
              id: item['id'],
              content: item['content'],
              markAsRead: item['mark_as_read'],
              userFrom_id: item['user_from'],
              userTo_id: item['user_to'],
              createAt: DateTime.parse(item['created_at']),
              isMine: item['user_from'] == currentUser.id,
            ),
          )
          .toList();
    } on PostgrestException catch (error) {
      debugPrint('Supabase Error (fetchMessages): ${error.message}');
      throw Exception('Failed to fetch messages: ${error.message}');
    } catch (e) {
      debugPrint('Unexpected error (fetchMessages): $e');
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  Future<void> markMessagesAsRead({
    // ... (giữ nguyên) ...
    required String userToId,
    required String userFromId,
  }) async {
    try {
      await _supabaseClient
          .from(SupabaseConstants.messagesTable)
          .update({'mark_as_read': true})
          .eq('user_to', userToId)
          .eq('user_from', userFromId)
          .eq('mark_as_read', false);

      debugPrint('Marked messages as read from $userFromId to $userToId');
    } catch (e) {
      debugPrint('Error marking messages as read: $e');
      throw Exception('Failed to mark messages as read.');
    }
  }

  Stream<Message> subscribeToNewMessages({
    // ... (giữ nguyên) ...
    required String userId1,
    required String userId2,
  }) {
    final currentUser = _supabaseClient.auth.currentUser;
    if (currentUser == null) {
      return Stream.error(Exception("User not logged in"));
    }

    final ids = [userId1, userId2]..sort();
    final channelName = 'chat:${ids[0]}-${ids[1]}';
    final controller = StreamController<Message>();

    final channel =
        _supabaseClient
            .channel(channelName)
            .onPostgresChanges(
              event: PostgresChangeEvent.insert,
              schema: 'public',
              table: SupabaseConstants.messagesTable,
              callback: (payload) {
                final newMessageMap = payload.newRecord;

                if (newMessageMap != null) {
                  // Lọc thêm một lần nữa ở client để chắc chắn tin nhắn thuộc về cuộc hội thoại này
                  final msgUserFrom = newMessageMap['user_from'] as String;
                  final msgUserTo = newMessageMap['user_to'] as String;
                  if ((msgUserFrom == userId1 && msgUserTo == userId2) ||
                      (msgUserFrom == userId2 && msgUserTo == userId1)) {
                    final message = Message(
                      id: newMessageMap['id'] as String,
                      content: newMessageMap['content'] as String,
                      markAsRead: newMessageMap['mark_as_read'] as bool,
                      userFrom_id: msgUserFrom,
                      userTo_id: msgUserTo,
                      createAt: DateTime.parse(
                        newMessageMap['created_at'] as String,
                      ),
                      isMine: msgUserFrom == currentUser.id,
                    );
                    if (!controller.isClosed) {
                      controller.add(message);
                    }
                  }
                }
              },
            )
            .subscribe();

    controller.onCancel = () {
      debugPrint('Cancelling message subscription for channel: $channelName');
      _supabaseClient.removeChannel(channel);
      controller.close();
    };

    return controller.stream;
  }

  // Phương thức mới để lấy danh sách các cuộc hội thoại
  Future<List<ConversationModel>> fetchConversations() async {
    final currentUser = _supabaseClient.auth.currentUser;
    if (currentUser == null) {
      throw Exception("User not logged in");
    }
    final currentUserId = currentUser.id;
    debugPrint('userID is scanning for message list: ${currentUserId}');
    try {
      final sentMessagesPartners = await _supabaseClient
          .from(SupabaseConstants.messagesTable)
          .select('user_to')
          .eq('user_from', currentUserId);

      final receivedMessagesPartners = await _supabaseClient
          .from(SupabaseConstants.messagesTable)
          .select('user_from')
          .eq('user_to', currentUserId);

      final Set<String> partnerIds = {};
      (sentMessagesPartners as List).forEach(
        (row) => partnerIds.add(row['user_to'] as String),
      );
      (receivedMessagesPartners as List).forEach(
        (row) => partnerIds.add(row['user_from'] as String),
      );

      // Bước 2: Với mỗi partnerId, lấy tin nhắn cuối cùng, thông tin user và số tin nhắn chưa đọc
      List<ConversationModel> conversations = [];
      for (String partnerId in partnerIds) {
        if (partnerId == currentUserId) continue; // Bỏ qua chat với chính mình

        // Lấy tin nhắn cuối cùng
        final lastMessageResponse =
            await _supabaseClient
                .from(SupabaseConstants.messagesTable)
                .select()
                .or(
                  'and(user_from.eq.$currentUserId,user_to.eq.$partnerId),and(user_from.eq.$partnerId,user_to.eq.$currentUserId)',
                )
                .order('created_at', ascending: false)
                .limit(1)
                .maybeSingle(); // Dùng maybeSingle để tránh lỗi nếu không có tin nhắn

        if (lastMessageResponse == null)
          continue; // Bỏ qua nếu không có tin nhắn

        final lastMessageData = lastMessageResponse as Map<String, dynamic>;
        final lastMessage = Message(
          id: lastMessageData['id'],
          content: lastMessageData['content'],
          markAsRead: lastMessageData['mark_as_read'],
          userFrom_id: lastMessageData['user_from'],
          userTo_id: lastMessageData['user_to'],
          createAt: DateTime.parse(lastMessageData['created_at']),
          isMine: lastMessageData['user_from'] == currentUserId,
        );

        // Lấy thông tin profile của partner
        // Giả định bạn có hàm getUserName hoặc hàm fetchProfile trong ProfileService
        // Hoặc query trực tiếp bảng profiles
        final partnerProfileResponse =
            await _supabaseClient
                .from(
                  SupabaseConstants.profilesTable,
                ) // profilesTable = 'profiles'
                .select('display_name')
                .eq('user_id', partnerId)
                .maybeSingle();

        final partnerDisplayName =
            partnerProfileResponse?['display_name'] as String? ??
            'Unknown User';
        debugPrint('--------------------$partnerDisplayName---------------');
        // Đếm số tin nhắn chưa đọc từ partner này
        final unreadCountResponse = await _supabaseClient
            .from(SupabaseConstants.messagesTable)
            .select('id')
            .eq('user_to', currentUserId)
            .eq('user_from', partnerId)
            .eq('mark_as_read', false);

        var unreadCount = unreadCountResponse.length;
        conversations.add(
          ConversationModel(
            partnerId: partnerId,
            partnerDisplayName: partnerDisplayName,
            partnerAvatarUrl: null,
            lastMessage: lastMessage,
            unreadCount: unreadCount,
          ),
        );
      }

      // Sắp xếp các cuộc hội thoại theo thời gian tin nhắn cuối cùng
      conversations.sort(
        (a, b) => b.lastMessage.createAt.compareTo(a.lastMessage.createAt),
      );

      debugPrint('Fetched ${conversations.length} conversations.');
      return conversations;
    } catch (e) {
      debugPrint('Error fetching conversations: $e');
      rethrow;
    }
  }

  Future<String> getUserName(String id) async {
    // Giữ nguyên hàm này nếu cần
    try {
      final response =
          await _supabaseClient
              .from(SupabaseConstants.profilesTable)
              .select('display_name')
              .eq('user_id', id)
              .single();
      debugPrint('--------------- display name in message screen');
      debugPrint(response['display_name']);
      return response['display_name'] as String? ?? 'Unknown User';
    } on PostgrestException catch (e) {
      debugPrint('Error fetching user name: ${e.message}');
      return 'Unknown User';
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return 'Unknown User';
    }
  }
}
