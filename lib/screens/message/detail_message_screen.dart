// lib/screens/chat/chat_detail_screen.dart
import 'package:buildconnect/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../features/message/providers/message_provider.dart';

class DetailMessageScreen extends ConsumerWidget {
  final String conversationPartnerId;
  // final String partnerName;
  const DetailMessageScreen({
    super.key,
    required this.conversationPartnerId,
    // required this.partnerName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesAsync = ref.watch(
      messageNotifierProvider(conversationPartnerId),
    );
    final userName = ref
        .read(messageNotifierProvider(conversationPartnerId).notifier)
        .getUserName(conversationPartnerId);
    final messageController = TextEditingController();
    final scrollController = ScrollController();
    return FutureBuilder<String>(
      future: userName,
      builder: (context, snapshot) {
        final title = snapshot.data ?? '...';
        return Scaffold(
          appBar: AppBar(title: Text(title)),
          body: Column(
            children: [
              Expanded(
                child: messagesAsync.when(
                  data: (messages) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (scrollController.hasClients) {
                        scrollController.jumpTo(
                          scrollController.position.maxScrollExtent,
                        );
                        // Hoặc animateTo nếu bạn muốn cuộn mượt:
                        scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      }
                    });
                    return ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.all(8),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final msg = messages[index];
                        return _buildMessageBubble(
                          text: msg.content,
                          timestamp: DateFormat.Hm().format(msg.createAt), //
                          isMine: msg.isMine,
                        );
                      },
                    );
                  },
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Error: $e')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: const InputDecoration(
                          hintText: 'Type your message...',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        final text = messageController.text.trim();
                        if (text.isNotEmpty) {
                          ref
                              .read(
                                messageNotifierProvider(
                                  conversationPartnerId,
                                ).notifier,
                              )
                              .sendMessage(text);
                          messageController.clear();
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (scrollController.hasClients) {
                              scrollController.animateTo(
                                scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                            }
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildMessageBubble({
  required String text,
  required String timestamp,
  required bool isMine,
}) {
  return Align(
    alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      padding: ChatTheme.messagePadding,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color:
            isMine
                ? AppColors.myMessageBackground
                : AppColors.otherMessageBackground,
        borderRadius:
            isMine
                ? ChatTheme.myMessageBorderRadius
                : ChatTheme.otherMessageBorderRadius,
      ),
      child: Column(
        crossAxisAlignment:
            isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              color:
                  isMine ? AppColors.myMessageText : AppColors.otherMessageText,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(timestamp, style: ChatTheme.timestampStyle),
        ],
      ),
    ),
  );
}
