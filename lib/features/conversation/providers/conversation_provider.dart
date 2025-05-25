import 'dart:async';

import 'package:buildconnect/features/auth/providers/auth_provider.dart';
import 'package:buildconnect/features/auth/providers/auth_service_provider.dart';
import 'package:buildconnect/features/auth/services/auth_service.dart';
import 'package:buildconnect/features/conversation/providers/conversation_service_provider.dart';
import 'package:buildconnect/features/conversation/services/conversation_service.dart';
import 'package:buildconnect/features/message/providers/message_provider.dart';
import 'package:buildconnect/features/message/providers/message_service_provider.dart';
import 'package:buildconnect/features/message/services/message_service.dart';
import 'package:buildconnect/models/conversation/conversation_model.dart';
import 'package:buildconnect/models/message/message_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversation_provider.g.dart';

@Riverpod()
class ConversationNotifier extends _$ConversationNotifier {
  MessageService get _messageService => ref.read(messageServiceProvider);
  ConversationService get _conversationService =>
      ref.read(conversationServiceProvider);
  StreamSubscription<void>? _messageSubscription;
  AuthService get _authService => ref.watch(authServiceProvider);
  String? get _userId => _authService.currentUserId;

  @override
  Future<List<ConversationModel>> build() async {
    final currentUserId = ref.read(authProvider).value?.id;

    if (currentUserId == null) {
      throw Exception('User not logged in.');
    }
    _messageSubscription = _messageService.onMessagesChanged().listen(
      (_) => refreshConversations(),
    );
    List<ConversationModel> result = [];
    final dataFetched = _conversationService.fetchConversations();
    if (dataFetched != null) {
      result = await dataFetched;
    }
    return result;
    // TODO: Implement loadMoreMessages with pagination if needed
  }

  Future<void> refreshConversations() async {
    state = const AsyncLoading();
    try {
      final conversations = await _conversationService.fetchConversations();
      state = AsyncData(conversations ?? []);
    } catch (error, stack) {
      state = AsyncError(error, stack);
    }
  }

  Future<void> markAsRead(String partnerId) async {
    try {
      await _messageService.markMessagesAsRead(
        userReceive: _userId!,
        userSend: partnerId,
      );
    } catch (e) {
      debugPrint('Error marking messages as read: $e');
    }
  }
}

@Riverpod()
Future<int> totalUnreadMessagesCount(TotalUnreadMessagesCountRef ref) async {
  final authState = ref.watch(authProvider);
  if (authState.valueOrNull == null) {
    return 0; // Trả về 0 nếu chưa đăng nhập
  }

  final conversationService = ref.watch(conversationServiceProvider);

  return conversationService.countAllUnreadMessages();
}
