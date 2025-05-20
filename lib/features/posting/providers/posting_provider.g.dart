// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posting_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allPostsHash() => r'855cc74130841e6e4e980a2cee1051ea7944a5c4';

/// See also [allPosts].
@ProviderFor(allPosts)
final allPostsProvider = AutoDisposeFutureProvider<List<PostModel>>.internal(
  allPosts,
  name: r'allPostsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allPostsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllPostsRef = AutoDisposeFutureProviderRef<List<PostModel>>;
String _$postByIdHash() => r'178fda1b2dcc95f2364e6b57f6bc7be65651c7d4';

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

/// See also [postById].
@ProviderFor(postById)
const postByIdProvider = PostByIdFamily();

/// See also [postById].
class PostByIdFamily extends Family<AsyncValue<PostModel?>> {
  /// See also [postById].
  const PostByIdFamily();

  /// See also [postById].
  PostByIdProvider call(String id) {
    return PostByIdProvider(id);
  }

  @override
  PostByIdProvider getProviderOverride(covariant PostByIdProvider provider) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'postByIdProvider';
}

/// See also [postById].
class PostByIdProvider extends AutoDisposeFutureProvider<PostModel?> {
  /// See also [postById].
  PostByIdProvider(String id)
    : this._internal(
        (ref) => postById(ref as PostByIdRef, id),
        from: postByIdProvider,
        name: r'postByIdProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$postByIdHash,
        dependencies: PostByIdFamily._dependencies,
        allTransitiveDependencies: PostByIdFamily._allTransitiveDependencies,
        id: id,
      );

  PostByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<PostModel?> Function(PostByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PostByIdProvider._internal(
        (ref) => create(ref as PostByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<PostModel?> createElement() {
    return _PostByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PostByIdRef on AutoDisposeFutureProviderRef<PostModel?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _PostByIdProviderElement
    extends AutoDisposeFutureProviderElement<PostModel?>
    with PostByIdRef {
  _PostByIdProviderElement(super.provider);

  @override
  String get id => (origin as PostByIdProvider).id;
}

String _$postingNotifierHash() => r'71d5601b762b1e70c835eca0798afda04f7e6e76';

/// See also [PostingNotifier].
@ProviderFor(PostingNotifier)
final postingNotifierProvider =
    AsyncNotifierProvider<PostingNotifier, void>.internal(
      PostingNotifier.new,
      name: r'postingNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$postingNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PostingNotifier = AsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
