// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchAppUserByUsernameHash() =>
    r'4cdc7fb048f06c314d28c646a1caad44ad46323f';

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

/// See also [searchAppUserByUsername].
@ProviderFor(searchAppUserByUsername)
const searchAppUserByUsernameProvider = SearchAppUserByUsernameFamily();

/// See also [searchAppUserByUsername].
class SearchAppUserByUsernameFamily extends Family<AsyncValue<List<AppUser>>> {
  /// See also [searchAppUserByUsername].
  const SearchAppUserByUsernameFamily();

  /// See also [searchAppUserByUsername].
  SearchAppUserByUsernameProvider call(String username) {
    return SearchAppUserByUsernameProvider(username);
  }

  @override
  SearchAppUserByUsernameProvider getProviderOverride(
    covariant SearchAppUserByUsernameProvider provider,
  ) {
    return call(provider.username);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchAppUserByUsernameProvider';
}

/// See also [searchAppUserByUsername].
class SearchAppUserByUsernameProvider
    extends AutoDisposeFutureProvider<List<AppUser>> {
  /// See also [searchAppUserByUsername].
  SearchAppUserByUsernameProvider(String username)
    : this._internal(
        (ref) => searchAppUserByUsername(
          ref as SearchAppUserByUsernameRef,
          username,
        ),
        from: searchAppUserByUsernameProvider,
        name: r'searchAppUserByUsernameProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$searchAppUserByUsernameHash,
        dependencies: SearchAppUserByUsernameFamily._dependencies,
        allTransitiveDependencies:
            SearchAppUserByUsernameFamily._allTransitiveDependencies,
        username: username,
      );

  SearchAppUserByUsernameProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.username,
  }) : super.internal();

  final String username;

  @override
  Override overrideWith(
    FutureOr<List<AppUser>> Function(SearchAppUserByUsernameRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchAppUserByUsernameProvider._internal(
        (ref) => create(ref as SearchAppUserByUsernameRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        username: username,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<AppUser>> createElement() {
    return _SearchAppUserByUsernameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchAppUserByUsernameProvider &&
        other.username == username;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, username.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SearchAppUserByUsernameRef
    on AutoDisposeFutureProviderRef<List<AppUser>> {
  /// The parameter `username` of this provider.
  String get username;
}

class _SearchAppUserByUsernameProviderElement
    extends AutoDisposeFutureProviderElement<List<AppUser>>
    with SearchAppUserByUsernameRef {
  _SearchAppUserByUsernameProviderElement(super.provider);

  @override
  String get username => (origin as SearchAppUserByUsernameProvider).username;
}

String _$createAppUserHash() => r'9ac9bba826e93dc93f243e3bb15c79c9ba008dc4';

/// See also [createAppUser].
@ProviderFor(createAppUser)
const createAppUserProvider = CreateAppUserFamily();

/// See also [createAppUser].
class CreateAppUserFamily extends Family<AsyncValue<AppUser>> {
  /// See also [createAppUser].
  const CreateAppUserFamily();

  /// See also [createAppUser].
  CreateAppUserProvider call(AppUser appUser) {
    return CreateAppUserProvider(appUser);
  }

  @override
  CreateAppUserProvider getProviderOverride(
    covariant CreateAppUserProvider provider,
  ) {
    return call(provider.appUser);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'createAppUserProvider';
}

/// See also [createAppUser].
class CreateAppUserProvider extends AutoDisposeFutureProvider<AppUser> {
  /// See also [createAppUser].
  CreateAppUserProvider(AppUser appUser)
    : this._internal(
        (ref) => createAppUser(ref as CreateAppUserRef, appUser),
        from: createAppUserProvider,
        name: r'createAppUserProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$createAppUserHash,
        dependencies: CreateAppUserFamily._dependencies,
        allTransitiveDependencies:
            CreateAppUserFamily._allTransitiveDependencies,
        appUser: appUser,
      );

  CreateAppUserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.appUser,
  }) : super.internal();

  final AppUser appUser;

  @override
  Override overrideWith(
    FutureOr<AppUser> Function(CreateAppUserRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreateAppUserProvider._internal(
        (ref) => create(ref as CreateAppUserRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        appUser: appUser,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<AppUser> createElement() {
    return _CreateAppUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateAppUserProvider && other.appUser == appUser;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, appUser.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CreateAppUserRef on AutoDisposeFutureProviderRef<AppUser> {
  /// The parameter `appUser` of this provider.
  AppUser get appUser;
}

class _CreateAppUserProviderElement
    extends AutoDisposeFutureProviderElement<AppUser>
    with CreateAppUserRef {
  _CreateAppUserProviderElement(super.provider);

  @override
  AppUser get appUser => (origin as CreateAppUserProvider).appUser;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
