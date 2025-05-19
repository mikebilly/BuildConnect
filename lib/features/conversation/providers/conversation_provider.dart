import 'dart:async';

import 'package:buildconnect/features/auth/providers/auth_provider.dart';
import 'package:buildconnect/features/conversation/providers/conversation_service_provider.dart';
import 'package:buildconnect/features/conversation/services/conversation_service.dart';
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
  ConversationService get _conversationService =>
      ref.read(conversationServiceProvider);
  StreamSubscription<Message>? _messageSubscription;
  String? _currentConversationPartnerId;

  @override
  Future<List<ConversationModel>> build(String conversationPartnerId) async {
    _currentConversationPartnerId = conversationPartnerId;
    final currentUserId = ref.read(authProvider).value?.id;

    if (currentUserId == null) {
      throw Exception('User not logged in.');
    }
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
}
