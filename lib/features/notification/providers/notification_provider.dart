import 'dart:async';
import 'package:buildconnect/features/auth/providers/auth_provider.dart';
import 'package:buildconnect/features/notification/providers/notification_service_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/notification/notification_model.dart';
import '../services/notification_service.dart';

part 'notification_provider.g.dart';

// AsyncNotifier quản lý danh sách thông báo và số thông báo chưa đọc
@Riverpod(keepAlive: true) // KeepAlive để giữ thông báo khi điều hướng
class Notification extends _$Notification {
  NotificationService get _notificationService =>
      ref.read(notificationServiceProvider);
  StreamSubscription<NotificationModel>? _notificationSubscription;

  @override
  Future<List<NotificationModel>> build() async {
    final currentUserId =
        ref
            .watch(authProvider)
            .value
            ?.id; // Watch authProvider để re-fetch khi user thay đổi
    if (currentUserId == null) {
      debugPrint(
        'NotificationNotifier: User not logged in, returning empty list.',
      );
      _notificationSubscription?.cancel(); // Hủy sub cũ nếu có
      _notificationSubscription = null;
      return []; // Trả về danh sách rỗng nếu chưa đăng nhập
    }

    debugPrint('NotificationNotifier: Building for user $currentUserId');

    // Hủy subscription cũ trước khi tạo mới
    await _notificationSubscription?.cancel();
    _notificationSubscription = null;

    // Đăng ký lắng nghe thông báo mới
    _notificationSubscription = _notificationService
        .subscribeToNewNotifications(currentUserId)
        .listen(
          (newNotification) {
            debugPrint(
              'NotificationNotifier: Received new notification from stream: ${newNotification.body}',
            );
            final currentNotifications = state.valueOrNull ?? [];
            if (!currentNotifications.any((n) => n.id == newNotification.id)) {
              // Thêm vào đầu danh sách và sắp xếp lại (hoặc để server sắp xếp)
              final updatedNotifications = [
                newNotification,
                ...currentNotifications,
              ];
              // Sắp xếp lại theo thời gian nếu cần (stream chỉ emit 1 item)
              // updatedNotifications.sort((a, b) => b.createdAt.compareTo(a.createdAt));
              state = AsyncData(updatedNotifications);
            }
          },
          onError: (error, stackTrace) {
            debugPrint(
              'NotificationNotifier: Error in notification stream: $error',
            );
            // Có thể giữ lại state cũ hoặc cập nhật state lỗi
            // state = AsyncError(error, stackTrace)..setPrevious(state); // Giữ state cũ khi lỗi
          },
        );

    ref.onDispose(() async {
      debugPrint(
        'NotificationNotifier for user $currentUserId disposed, cancelling subscription.',
      );
      await _notificationSubscription?.cancel();
    });

    // Fetch danh sách thông báo ban đầu
    debugPrint('NotificationNotifier: Fetching initial notifications...');
    return _notificationService.fetchNotifications(userId: currentUserId);
  }

  // Phương thức đánh dấu thông báo đã đọc
  Future<void> markAsRead(String notificationId) async {
    // Optional: Cập nhật UI tức thì (optimistic update)
    // final currentNotifications = state.valueOrNull;
    // if (currentNotifications != null) {
    //    state = AsyncData(currentNotifications.map((n) {
    //       return n.id == notificationId ? n.copyWith(isRead: true) : n; // Cần copyWith trong model
    //    }).toList());
    // }

    try {
      await _notificationService.markNotificationAsRead(notificationId);
      // Sau khi service thành công, có thể invalidate để fetch lại hoặc cập nhật state như trên
      // Nếu đã optimistic update, không cần làm gì thêm hoặc fetch lại để xác nhận.
      // Nếu không optimistic update, cần cập nhật state ở đây:
      if (state.hasValue) {
        final currentNotifications = state.value!;
        state = AsyncData(
          currentNotifications.map((n) {
            return n.id == notificationId ? n.copyWith(isRead: true) : n;
          }).toList(),
        );
      }
    } catch (e) {
      debugPrint(
        'NotificationNotifier: Error marking notification as read: $e',
      );
      // TODO: Rollback optimistic update nếu có lỗi
    }
  }

  // Phương thức đánh dấu tất cả đã đọc
  Future<void> markAllAsRead() async {
    final currentUserId = ref.read(authProvider).value?.id;
    if (currentUserId == null) return;

    // Optional: Optimistic update
    // if (state.hasValue) {
    //    state = AsyncData(state.value!.map((n) => n.copyWith(isRead: true)).toList());
    // }

    try {
      await _notificationService.markAllNotificationsAsRead(currentUserId);
      // Cập nhật state sau khi service thành công
      if (state.hasValue) {
        state = AsyncData(
          state.value!.map((n) => n.copyWith(isRead: true)).toList(),
        );
      }
    } catch (e) {
      debugPrint(
        'NotificationNotifier: Error marking all notifications as read: $e',
      );
      // TODO: Rollback optimistic update
    }
  }

  // Getter cho số lượng thông báo chưa đọc (tính toán từ state)
  int get unreadNotificationCount {
    return state.valueOrNull?.where((n) => !n.isRead).length ?? 0;
  }

  // TODO: Thêm phương thức loadMoreNotifications cho pagination
}

// Provider cho số lượng thông báo chưa đọc (để dễ dàng watch ở những nơi khác như badge)
@Riverpod(keepAlive: true)
int unreadNotificationCount(UnreadNotificationCountRef ref) {
  // Watch NotificationNotifier provider và lấy count từ nó
  return ref.watch(
    notificationProvider.select(
      (state) => state.valueOrNull?.where((n) => !n.isRead).length ?? 0,
    ),
  );
  // Hoặc: return ref.watch(notificationProvider.notifier).unreadNotificationCount;
}
