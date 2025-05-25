import 'package:buildconnect/core/theme/theme.dart';
import 'package:buildconnect/features/notification/providers/notification_provider.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../models/notification/notification_model.dart'; // Import NotificationModel

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});
  Widget _getNotificationIcon(NotificationType type, BuildContext context) {
    switch (type) {
      case NotificationType.newPostMatch:
        return Icon(Icons.article_outlined, color: AppColors.primary);
      case NotificationType.newMessage:
        return Icon(Icons.message_outlined, color: Colors.green);
      case NotificationType.applicationUpdate:
        return Icon(Icons.work_history_outlined, color: Colors.orange);
      case NotificationType.profileUpdate:
        return Icon(Icons.person_search_outlined, color: Colors.purple);
      case NotificationType.system:
        return Icon(Icons.settings_outlined, color: Colors.blueGrey);
      default:
        return Icon(Icons.notifications_outlined, color: Colors.grey);
    }
  }

  void _onNotificationTap(
    BuildContext context,
    WidgetRef ref,
    NotificationModel notification,
  ) {
    ref.read(notificationProvider.notifier).markAsRead(notification.id);

    if (notification.relatedEntityType != null &&
        notification.relatedEntityId != null) {
      switch (notification.relatedEntityType!) {
        case RelatedEntityType.post:
          context.push('/job-posting/view/${notification.relatedEntityId}');
          break;
        case RelatedEntityType.profile:
          context.push('/profile/view/${notification.relatedEntityId}');
          break;
        case RelatedEntityType.messageThread:
          print(
            'Navigate to message thread with partner: ${notification.relatedEntityId}',
          );
          break;
        default:
          print(
            'No navigation defined for entity type: ${notification.relatedEntityType}',
          );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsyncValue = ref.watch(notificationProvider);
    final notificationNotifier = ref.read(notificationProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          notificationsAsyncValue.maybeWhen(
            data:
                (notifications) =>
                    notifications.any((n) => !n.isRead)
                        ? IconButton(
                          icon: const Icon(Icons.done_all),
                          tooltip: 'Mark all as read',
                          onPressed: () => notificationNotifier.markAllAsRead(),
                        )
                        : const SizedBox.shrink(),
            orElse: () => const SizedBox.shrink(),
          ),
          //hêm nút Filter hoặc Settings cho Notification
        ],
      ),
      body: notificationsAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, stackTrace) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error loading notifications: ${error.toString()}'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => ref.invalidate(notificationProvider),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
        data: (notifications) {
          if (notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.notifications_off_outlined,
                    size: 60,
                    color: AppColors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No notifications yet.',
                    style: NotificationTextStyle.title,
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            // Cho phép kéo xuống để làm mới
            onRefresh: () async {
              ref.invalidate(notificationProvider); // Invalidate để fetch lại
            },
            child: ListView.separated(
              itemCount: notifications.length,
              separatorBuilder:
                  (context, index) =>
                      const Divider(height: 1, indent: 16, endIndent: 16),
              itemBuilder: (context, index) {
                final notification = notifications[index];
                final bool isUnread = !notification.isRead;

                return ListTile(
                  tileColor:
                      isUnread ? AppColors.primary.withOpacity(0.05) : null,
                  leading: CircleAvatar(
                    backgroundColor:
                        _getNotificationIcon(notification.type, context) is Icon
                            ? ((_getNotificationIcon(notification.type, context)
                                        as Icon)
                                    .color
                                    ?.withOpacity(0.1) ??
                                Theme.of(
                                  context,
                                ).primaryColorLight.withOpacity(0.1))
                            : Theme.of(
                              context,
                            ).primaryColorLight.withOpacity(0.1),
                    child: _getNotificationIcon(notification.type, context),
                  ),
                  title: Text(
                    notification.title ??
                        notification.type.name
                            .replaceAllMapped(
                              RegExp(r'[A-Z]'),
                              (match) => ' ${match.group(0)}',
                            )
                            .trim(), // Tạo title từ type nếu null
                    style: NotificationTextStyle.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.body,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: NotificationTextStyle.body,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        // Format thời gian (ví dụ: 5m ago, 1h ago, Yesterday, 20/04)
                        _formatDateTime(
                          notification.createdAt,
                        ), // Bạn cần hàm này
                        style: NotificationTextStyle.time,
                      ),
                    ],
                  ),
                  trailing:
                      isUnread
                          ? Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          )
                          : null,
                  onTap: () => _onNotificationTap(context, ref, notification),
                );
              },
            ),
          );
        },
      ),
    );
  }

  // Helper function để format DateTime (tương tự như trong UserMessagesScreen)
  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (messageDate == today) {
      final difference = now.difference(dateTime);
      if (difference.inSeconds < 60) return '${difference.inSeconds}s ago';
      if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
      return '${difference.inHours}h ago';
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else if (now.difference(messageDate).inDays < 7) {
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return days[dateTime.weekday - 1];
    } else {
      return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year.toString().substring(2)}';
    }
  }
}
