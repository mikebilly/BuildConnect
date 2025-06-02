import 'dart:async';
import 'dart:io';

import 'package:buildconnect/features/auth/providers/auth_provider.dart';
import 'package:buildconnect/features/conversation/providers/conversation_provider.dart';
import 'package:buildconnect/features/message/providers/message_service_provider.dart';
import 'package:buildconnect/features/message/services/message_service.dart';
import 'package:buildconnect/models/message/message_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message_provider.g.dart';

@Riverpod()
class MessageNotifier extends _$MessageNotifier {
  MessageService get _messageService => ref.read(messageServiceProvider);
  StreamSubscription<Message>? _messageSubscription;
  String? _currentConversationPartnerId;

  @override
  Future<List<Message>> build(String conversationPartnerId) async {
    _currentConversationPartnerId = conversationPartnerId;
    final currentUserId = ref.read(authProvider).value?.id;

    if (currentUserId == null) {
      throw Exception('User not logged in.');
    }

    // Cancel old stream if exists
    await _messageSubscription?.cancel();

    // Listen for new messages in realtime
    _messageSubscription = _messageService
        .subscribeToNewMessages(
          userId1: currentUserId,
          userId2: conversationPartnerId,
        )
        .listen(
          (newMessage) {
            if (state.hasValue) {
              final currentMessages = state.value!;
              final alreadyExists = currentMessages.any(
                (m) => m.id == newMessage.id,
              );
              if (!alreadyExists) {
                state = AsyncData([...currentMessages, newMessage]);
              }
            }
          },
          onError: (error, stack) {
            state = AsyncError(error, stack);
          },
        );

    // Clean up when disposed
    ref.onDispose(() async {
      print('MessageNotifier for $conversationPartnerId disposed.');
      await _messageSubscription?.cancel();
    });

    // Load initial messages
    return await _messageService.fetchMessages(
      userReceive: currentUserId,
      userSend: conversationPartnerId,
    );
  }

  Future<void> sendMessage(String? content, {File? attachmentFile}) async {
    final currentUserId = ref.read(authProvider).value?.id;
    if (currentUserId == null || _currentConversationPartnerId == null) return;

    try {
      await _messageService.sendMessage(
        content: content?.trim(),
        userFromId: currentUserId,
        userToId: _currentConversationPartnerId!,
        attachmentFile: attachmentFile,
      );
    } catch (e) {
      debugPrint('Error sending message: $e');
      // Optionally show error to user via snackbar or state = AsyncError(...)
    }
  }

  Future<void> markMessagesAsRead() async {
    final currentUserId = ref.read(authProvider).value?.id;
    if (currentUserId == null || _currentConversationPartnerId == null) return;

    try {
      await _messageService.markMessagesAsRead(
        userReceive: currentUserId,
        userSend: _currentConversationPartnerId!,
      );
    } catch (e) {
      debugPrint('Error marking messages as read: $e');
    }
  }

  Future<String> getUserName(String userId) {
    return ref.read(messageServiceProvider).getUserName(userId);
  }

  String currentUserId() {
    return ref.read(authProvider).value?.id ?? '';
  }
}

final unreadMessageCountProvider = Provider.family<int, String>((
  ref,
  conversationPartnerId,
) {
  final messagesAsync = ref.watch(
    messageNotifierProvider(conversationPartnerId),
  );
  return messagesAsync.when(
    data: (messages) => messages.where((n) => !n.markAsRead).length,
    loading: () => 0,
    error: (_, __) => 0,
  );
});
