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
              content: r['last_content'] as String,
              userFrom_id: r['last_sender'] as String,
              userTo_id: uid,
              createAt: DateTime.parse(r['last_ts'] as String),
              isMine: r['last_sender'] == uid,
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

  // count all messages that unread
}
