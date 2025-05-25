import 'dart:async';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';
import '../../../core/constants/supabase_constants.dart';
import '../../../models/notification/notification_model.dart';

class NotificationService {
  final SupabaseClient _supabaseClient;

  NotificationService(this._supabaseClient);

  // Fetch notifications cho user hiện tại, sắp xếp theo thời gian, có pagination
  Future<List<NotificationModel>> fetchNotifications({
    required String userId,
    int limit = 20,
    DateTime? beforeTimestamp, // Dùng cho "load more"
  }) async {
    try {
      var query = _supabaseClient
          .from(
            SupabaseConstants.notificationsTable,
          ) // Giả định hằng số này là 'notifications'
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false) // Mới nhất lên đầu
          .limit(limit);

      // if (beforeTimestamp != null) {
      //   query = query.lt('created_at', beforeTimestamp.toIso8601String());
      // }

      final List<dynamic> responseData = await query;

      final notifications =
          responseData
              .map(
                (data) => NotificationModelMapper.fromMap(
                  data as Map<String, dynamic>,
                ),
              ) // Sử dụng mapper
              .toList();
      debugPrint(
        'Fetched ${notifications.length} notifications for user $userId',
      );
      return notifications;
    } on PostgrestException catch (error) {
      debugPrint('Supabase Error (fetchNotifications): ${error.message}');
      throw Exception('Failed to fetch notifications: ${error.message}');
    } catch (e) {
      debugPrint('Unexpected error (fetchNotifications): $e');
      throw Exception(
        'Unexpected error fetching notifications: ${e.toString()}',
      );
    }
  }

  // Đánh dấu một thông báo cụ thể là đã đọc
  Future<void> markNotificationAsRead(String notificationId) async {
    try {
      await _supabaseClient
          .from(SupabaseConstants.notificationsTable)
          .update({'is_read': true})
          .eq('id', notificationId);
      debugPrint('Notification $notificationId marked as read.');
    } catch (e) {
      debugPrint('Error marking notification as read: $e');
      throw Exception('Failed to mark notification as read.');
    }
  }

  // Đánh dấu tất cả thông báo của user là đã đọc
  Future<void> markAllNotificationsAsRead(String userId) async {
    try {
      await _supabaseClient
          .from(SupabaseConstants.notificationsTable)
          .update({'is_read': true})
          .eq('user_id', userId)
          .eq('is_read', false); // Chỉ cập nhật những cái chưa đọc
      debugPrint('All notifications for user $userId marked as read.');
    } catch (e) {
      debugPrint('Error marking all notifications as read: $e');
      throw Exception('Failed to mark all notifications as read.');
    }
  }

  // Lắng nghe thông báo mới theo thời gian thực cho user hiện tại
  Stream<NotificationModel> subscribeToNewNotifications(String userId) {
    debugPrint('Subscribing to new notifications for user $userId');
    // Tên kênh có thể là duy nhất cho mỗi user hoặc một kênh chung (nếu RLS xử lý tốt)
    final controller = StreamController<NotificationModel>();

    _supabaseClient
        .channel('public:${SupabaseConstants.notificationsTable}')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: SupabaseConstants.notificationsTable,
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user_id',
            value: userId,
          ),
          callback: (payload) {
            final newData = payload.newRecord;
            if (newData != null) {
              controller.add(NotificationModelMapper.fromMap(newData));
            }
          },
        )
        .subscribe();

    return controller.stream;
  }

  // Hàm tạo thông báo (thường được gọi từ backend/trigger, hoặc từ các service khác)
  // Đây là ví dụ nếu bạn muốn service này có khả năng tạo thông báo
  // Trong thực tế, việc tạo thông báo "new_post_match" sẽ phức tạp hơn
  Future<void> createNotification({
    required String userId, // Người nhận
    required NotificationType type,
    required String body,
    String? title,
    RelatedEntityType? relatedEntityType,
    String? relatedEntityId,
    String? actorId,
    String? actorDisplayName,
    String? actorAvatarUrl,
  }) async {
    try {
      await _supabaseClient.from(SupabaseConstants.notificationsTable).insert({
        'user_id': userId,
        'type': type.name, // Lưu tên enum
        'title': title,
        'body': body,
        'related_entity_type': relatedEntityType?.name,
        'related_entity_id': relatedEntityId,
        'actor_id': actorId,
        'actor_display_name': actorDisplayName,
        'actor_avatar_url': actorAvatarUrl,
        // is_read và created_at sẽ dùng default
      });
      debugPrint('Notification created for user $userId of type ${type.name}');
    } catch (e) {
      debugPrint('Error creating notification: $e');
      throw Exception('Failed to create notification.');
    }
  }
}
