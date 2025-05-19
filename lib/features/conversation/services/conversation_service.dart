import 'package:buildconnect/core/constants/supabase_constants.dart';
import 'package:buildconnect/models/conversation/conversation_model.dart';
import 'package:buildconnect/models/message/message_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ConversationService {
  final SupabaseClient _supabaseClient;

  ConversationService(this._supabaseClient);
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

        // Đếm số tin nhắn chưa đọc từ partner này
        final unreadCountResponse = await _supabaseClient
            .from(SupabaseConstants.messagesTable)
            .select('id')
            .eq('user_to', currentUserId)
            .eq('user_from', partnerId)
            .eq('mark_as_read', false);

        final unreadCount = unreadCountResponse.length ?? 0;

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
}
