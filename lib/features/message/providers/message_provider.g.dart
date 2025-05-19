// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$messageNotifierHash() => r'7130ff6bae25fd035bc9195f00524baec2184a6e';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$MessageNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<Message>> {
  late final String conversationPartnerId;

  FutureOr<List<Message>> build(String conversationPartnerId);
}

/// See also [MessageNotifier].
@ProviderFor(MessageNotifier)
const messageNotifierProvider = MessageNotifierFamily();

/// See also [MessageNotifier].
class MessageNotifierFamily extends Family<AsyncValue<List<Message>>> {
  /// See also [MessageNotifier].
  const MessageNotifierFamily();

  /// See also [MessageNotifier].
  MessageNotifierProvider call(String conversationPartnerId) {
    return MessageNotifierProvider(conversationPartnerId);
  }

  @override
  MessageNotifierProvider getProviderOverride(
    covariant MessageNotifierProvider provider,
  ) {
    return call(provider.conversationPartnerId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'messageNotifierProvider';
}

/// See also [MessageNotifier].
class MessageNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<MessageNotifier, List<Message>> {
  /// See also [MessageNotifier].
  MessageNotifierProvider(String conversationPartnerId)
    : this._internal(
        () => MessageNotifier()..conversationPartnerId = conversationPartnerId,
        from: messageNotifierProvider,
        name: r'messageNotifierProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$messageNotifierHash,
        dependencies: MessageNotifierFamily._dependencies,
        allTransitiveDependencies:
            MessageNotifierFamily._allTransitiveDependencies,
        conversationPartnerId: conversationPartnerId,
      );

  MessageNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.conversationPartnerId,
  }) : super.internal();

  final String conversationPartnerId;

  @override
  FutureOr<List<Message>> runNotifierBuild(covariant MessageNotifier notifier) {
    return notifier.build(conversationPartnerId);
  }

  @override
  Override overrideWith(MessageNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: MessageNotifierProvider._internal(
        () => create()..conversationPartnerId = conversationPartnerId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        conversationPartnerId: conversationPartnerId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<MessageNotifier, List<Message>>
  createElement() {
    return _MessageNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MessageNotifierProvider &&
        other.conversationPartnerId == conversationPartnerId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, conversationPartnerId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MessageNotifierRef on AutoDisposeAsyncNotifierProviderRef<List<Message>> {
  /// The parameter `conversationPartnerId` of this provider.
  String get conversationPartnerId;
}

class _MessageNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<MessageNotifier, List<Message>>
    with MessageNotifierRef {
  _MessageNotifierProviderElement(super.provider);

  @override
  String get conversationPartnerId =>
      (origin as MessageNotifierProvider).conversationPartnerId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
