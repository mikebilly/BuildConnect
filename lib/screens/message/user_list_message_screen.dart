import 'package:buildconnect/core/theme/theme.dart';
import 'package:buildconnect/features/conversation/providers/conversation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UserListMessagesScreen extends ConsumerWidget {
  final String userId;

  const UserListMessagesScreen({super.key, required this.userId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('build userlist message screen -----------------');
    // Watch conversationsProvider để lấy danh sách cuộc hội thoại
    final conversationsAsync = ref.watch(conversationNotifierProvider(userId));

    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: conversationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, stackTrace) => Center(
              child: Text('Error loading conversations: ${error.toString()}'),
            ),
        data: (conversations) {
          if (conversations.isEmpty) {
            return const Center(
              child: Text('No messages yet. Start a new conversation!'),
            );
          }
          return ListView.separated(
            itemCount: conversations.length,
            separatorBuilder:
                (context, index) =>
                    const Divider(height: 1, indent: 70, endIndent: 16),
            itemBuilder: (context, index) {
              final conversation = conversations[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                leading: CircleAvatar(
                  backgroundColor: AppTheme.lightTheme.primaryColor,
                  radius: 28,
                  child:
                      conversation.partnerAvatarUrl == null ||
                              conversation.partnerAvatarUrl!.isEmpty
                          ? Text(
                            conversation.partnerDisplayName.isNotEmpty
                                ? conversation.partnerDisplayName[0]
                                    .toUpperCase()
                                : '?',
                            style: AppTextStyles.caption,
                          )
                          : null,
                ),
                title: Text(
                  conversation.partnerDisplayName,
                  style: AppTextStyles.subheading,
                ),
                subtitle: Text(
                  conversation.lastMessage.content,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _formatDateTime(conversation.lastMessage.createAt),
                      style: TextStyle(fontSize: 11, color: AppColors.grey),
                    ),
                    const SizedBox(height: 19), // Để giữ chiều cao tương đối
                  ],
                ),
                onTap: () {
                  // context.pop();
                  context.push(
                    '/message/detail_view/${conversation.partnerId}',
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  // Helper function để format DateTime
  String _formatDateTime(DateTime dateTime) {
    // ... (code _formatDateTime như cũ) ...
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (messageDate == today) {
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else if (now.difference(messageDate).inDays < 7) {
      // Hiển thị tên thứ trong tuần
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return days[dateTime.weekday - 1];
    } else {
      return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year.toString().substring(2)}';
    }
  }
}
