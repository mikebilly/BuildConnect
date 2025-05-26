// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$totalUnreadMessagesCountStreamHash() =>
    r'81fc5587c633ba0189b2b8ccc2f8327759b463f8';

/// See also [totalUnreadMessagesCountStream].
@ProviderFor(totalUnreadMessagesCountStream)
final totalUnreadMessagesCountStreamProvider = StreamProvider<int>.internal(
  totalUnreadMessagesCountStream,
  name: r'totalUnreadMessagesCountStreamProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$totalUnreadMessagesCountStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TotalUnreadMessagesCountStreamRef = StreamProviderRef<int>;
String _$conversationNotifierHash() =>
    r'379961ccacea88972fbd26adf975b0e959873c2f';

/// See also [ConversationNotifier].
@ProviderFor(ConversationNotifier)
final conversationNotifierProvider = AutoDisposeAsyncNotifierProvider<
  ConversationNotifier,
  List<ConversationModel>
>.internal(
  ConversationNotifier.new,
  name: r'conversationNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$conversationNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ConversationNotifier =
    AutoDisposeAsyncNotifier<List<ConversationModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
