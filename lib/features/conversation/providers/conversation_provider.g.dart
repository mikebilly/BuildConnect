// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$conversationNotifierHash() =>
    r'7e094de27bd0ae3f199604c0420e5406f3365d9a';

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

abstract class _$ConversationNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<ConversationModel>> {
  late final String conversationPartnerId;

  FutureOr<List<ConversationModel>> build(String conversationPartnerId);
}

/// See also [ConversationNotifier].
@ProviderFor(ConversationNotifier)
const conversationNotifierProvider = ConversationNotifierFamily();

/// See also [ConversationNotifier].
class ConversationNotifierFamily
    extends Family<AsyncValue<List<ConversationModel>>> {
  /// See also [ConversationNotifier].
  const ConversationNotifierFamily();

  /// See also [ConversationNotifier].
  ConversationNotifierProvider call(String conversationPartnerId) {
    return ConversationNotifierProvider(conversationPartnerId);
  }

  @override
  ConversationNotifierProvider getProviderOverride(
    covariant ConversationNotifierProvider provider,
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
  String? get name => r'conversationNotifierProvider';
}

/// See also [ConversationNotifier].
class ConversationNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          ConversationNotifier,
          List<ConversationModel>
        > {
  /// See also [ConversationNotifier].
  ConversationNotifierProvider(String conversationPartnerId)
    : this._internal(
        () =>
            ConversationNotifier()
              ..conversationPartnerId = conversationPartnerId,
        from: conversationNotifierProvider,
        name: r'conversationNotifierProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$conversationNotifierHash,
        dependencies: ConversationNotifierFamily._dependencies,
        allTransitiveDependencies:
            ConversationNotifierFamily._allTransitiveDependencies,
        conversationPartnerId: conversationPartnerId,
      );

  ConversationNotifierProvider._internal(
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
  FutureOr<List<ConversationModel>> runNotifierBuild(
    covariant ConversationNotifier notifier,
  ) {
    return notifier.build(conversationPartnerId);
  }

  @override
  Override overrideWith(ConversationNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ConversationNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<
    ConversationNotifier,
    List<ConversationModel>
  >
  createElement() {
    return _ConversationNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ConversationNotifierProvider &&
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
mixin ConversationNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<List<ConversationModel>> {
  /// The parameter `conversationPartnerId` of this provider.
  String get conversationPartnerId;
}

class _ConversationNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          ConversationNotifier,
          List<ConversationModel>
        >
    with ConversationNotifierRef {
  _ConversationNotifierProviderElement(super.provider);

  @override
  String get conversationPartnerId =>
      (origin as ConversationNotifierProvider).conversationPartnerId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
