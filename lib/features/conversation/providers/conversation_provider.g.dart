// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$totalUnreadMessagesCountHash() =>
    r'2593d79c86c9874adb4eb821f963d7171585f280';

/// See also [totalUnreadMessagesCount].
@ProviderFor(totalUnreadMessagesCount)
final totalUnreadMessagesCountProvider =
    AutoDisposeFutureProvider<int>.internal(
      totalUnreadMessagesCount,
      name: r'totalUnreadMessagesCountProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$totalUnreadMessagesCountHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TotalUnreadMessagesCountRef = AutoDisposeFutureProviderRef<int>;
String _$conversationNotifierHash() =>
    r'88ccfd01618402d2e84649ec7c73e24ad804a3f3';

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
