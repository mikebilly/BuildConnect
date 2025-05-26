// import 'package:buildconnect/core/theme/theme.dart';
// import 'package:buildconnect/features/conversation/providers/conversation_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

// class UserListMessagesScreen extends ConsumerWidget {
//   final String userId;

//   const UserListMessagesScreen({super.key, required this.userId});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     debugPrint('build userlist message screen -----------------');
//     // Watch conversationsProvider để lấy danh sách cuộc hội thoại
//     final conversationsAsync = ref.watch(conversationNotifierProvider(userId));

//     return Scaffold(
//       appBar: AppBar(title: const Text('Messages')),
//       body: conversationsAsync.when(
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error:
//             (error, stackTrace) => Center(
//               child: Text('Error loading conversations: ${error.toString()}'),
//             ),
//         data: (conversations) {
//           if (conversations.isEmpty) {
//             return const Center(
//               child: Text('No messages yet. Start a new conversation!'),
//             );
//           }
//           return ListView.separated(
//             itemCount: conversations.length,
//             separatorBuilder:
//                 (context, index) =>
//                     const Divider(height: 1, indent: 70, endIndent: 16),
//             itemBuilder: (context, index) {
//               final conversation = conversations[index];
//               return ListTile(
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 16.0,
//                   vertical: 8.0,
//                 ),
//                 leading: CircleAvatar(
//                   backgroundColor: AppTheme.lightTheme.primaryColor,
//                   radius: 28,
//                   child:
//                       conversation.partnerAvatarUrl == null ||
//                               conversation.partnerAvatarUrl!.isEmpty
//                           ? Text(
//                             conversation.partnerDisplayName.isNotEmpty
//                                 ? conversation.partnerDisplayName[0]
//                                     .toUpperCase()
//                                 : '?',
//                             style: AppTextStyles.caption,
//                           )
//                           : null,
//                 ),
//                 title: Text(
//                   conversation.partnerDisplayName,
//                   style: AppTextStyles.subheading,
//                 ),
//                 subtitle: Text(
//                   conversation.lastMessage.content,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(fontSize: 13),
//                 ),
//                 trailing: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text(
//                       _formatDateTime(conversation.lastMessage.createAt),
//                       style: TextStyle(fontSize: 11, color: AppColors.grey),
//                     ),
//                     const SizedBox(height: 19), // Để giữ chiều cao tương đối
//                   ],
//                 ),
//                 onTap: () {
//                   // context.pop();
//                   context.push(
//                     '/message/detail_view/${conversation.partnerId}',
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   // Helper function để format DateTime
//   String _formatDateTime(DateTime dateTime) {
//     // ... (code _formatDateTime như cũ) ...
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//     final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

//     if (messageDate == today) {
//       return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
//     } else if (messageDate == today.subtract(const Duration(days: 1))) {
//       return 'Yesterday';
//     } else if (now.difference(messageDate).inDays < 7) {
//       // Hiển thị tên thứ trong tuần
//       const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//       return days[dateTime.weekday - 1];
//     } else {
//       return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year.toString().substring(2)}';
//     }
//   }
// }
import 'package:buildconnect/core/theme/theme.dart'; // Giả định bạn có AppTheme và AppTextStyles// Import conversationNotifierProvider
import 'package:buildconnect/features/auth/providers/auth_service_provider.dart';
import 'package:buildconnect/features/conversation/providers/conversation_provider.dart';
import 'package:buildconnect/features/message/providers/message_provider.dart';
import 'package:buildconnect/models/conversation/conversation_model.dart'; // Import ConversationModel
// import 'package:buildconnect/models/message/message_model.dart'; // Không cần MessageModel ở đây trừ khi ConversationModel cần
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserListMessagesScreen extends ConsumerStatefulWidget {
  const UserListMessagesScreen({super.key});

  @override
  ConsumerState<UserListMessagesScreen> createState() =>
      _UserListMessagesScreenState();
}

class _UserListMessagesScreenState
    extends ConsumerState<UserListMessagesScreen> {
  @override
  void initState() {
    super.initState();
    debugPrint('InitState .....................');
  }

  @override
  Widget build(BuildContext context) {
    ref.invalidate(conversationNotifierProvider);
    var conversationsAsync = ref.watch(conversationNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        // TODO: Thêm nút tạo tin nhắn mới nếu cần
      ),
      body: conversationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          debugPrint('Error loading conversations: $error\n$stackTrace');
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error loading conversations: ${error.toString()}'),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => ref.invalidate(conversationNotifierProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        },
        data: (conversations) {
          if (conversations.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat_bubble_outline, size: 60, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No messages yet.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Text(
                    'Start a new conversation!',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
            // Cho phép kéo xuống để làm mới
            onRefresh: () async {
              // Invalidate provider để trigger fetch lại
              ref.invalidate(conversationNotifierProvider);
              // Đợi provider hoàn thành (optional, nhưng tốt cho UX của RefreshIndicator)
              await ref.read(conversationNotifierProvider);
            },
            child: ListView.separated(
              itemCount: conversations.length,
              separatorBuilder:
                  (context, index) => const Divider(
                    height: 1,
                    indent: 80,
                    endIndent: 16,
                    color: AppColors.primary,
                  ), // Tăng indent
              itemBuilder: (context, index) {
                final conversation = conversations[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 10.0,
                  ), // Tăng vertical padding
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundImage:
                        conversation.partnerAvatarUrl != null &&
                                conversation.partnerAvatarUrl!.isNotEmpty
                            ? NetworkImage(conversation.partnerAvatarUrl!)
                            : null,
                    child:
                        conversation.partnerAvatarUrl == null ||
                                conversation.partnerAvatarUrl!.isEmpty
                            ? Text(
                              conversation.partnerDisplayName.isNotEmpty
                                  ? conversation.partnerDisplayName[0]
                                      .toUpperCase()
                                  : '?',
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ), // Style cho chữ cái
                            )
                            : null,
                    backgroundColor:
                        conversation.partnerAvatarUrl == null ||
                                conversation.partnerAvatarUrl!.isEmpty
                            ? _getAvatarColor(
                              conversation.partnerDisplayName,
                            ) // Hàm tạo màu avatar
                            : Colors.transparent, // Nền trong suốt nếu có ảnh
                  ),
                  title: Text(
                    conversation.partnerDisplayName,
                    style: ChatTextStyles.nameSender,
                  ),
                  subtitle: Text(
                    conversation.lastMessage.content!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        conversation.unreadCount > 0
                            ? ChatTextStyles.unreadMessage
                            : ChatTextStyles.readMessage,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _formatDateTime(conversation.lastMessage.createAt),
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.grey,
                        ), // Dùng AppTextStyles
                      ),
                      if (conversation.unreadCount > 0) ...[
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color:
                                AppTheme
                                    .lightTheme
                                    .primaryColor, // Dùng theme color
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            conversation.unreadCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ] else
                        const SizedBox(height: 19), // Giữ chiều cao tương đối
                    ],
                  ),
                  onTap:
                      () => _onNotificationTap(
                        context,
                        ref,
                        conversation.partnerId,
                      ),

                  // Hoặc nếu dùng path trực tiếp
                  // context.push('${AppRoutes.messages}/${conversation.partnerId}');
                );
              },
            ),
          );
        },
      ),
    );
  }

  // Helper function để format DateTime (giữ nguyên)
  String _formatDateTime(DateTime dateTime) {
    // ... (code _formatDateTime của bạn) ...
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

  // Helper function để tạo màu cho avatar dựa trên tên
  Color _getAvatarColor(String name) {
    final hash = name.hashCode;
    // Tạo màu dựa trên hash, đảm bảo độ tương phản với chữ trắng
    return Color((hash & 0x00FFFFFF) | 0xFF404040).withAlpha(255);
  }

  void _onNotificationTap(
    BuildContext context,
    WidgetRef ref,
    String partnerId,
  ) {
    ref.read(messageNotifierProvider(partnerId).notifier).markMessagesAsRead();
    context.push('/message/detail_view/${partnerId}');
  }
}
