// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchAppUserByEmailHash() =>
    r'd13b9513bbcf9b5ba117a29600e389858c165f0d';

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

/// See also [searchAppUserByEmail].
@ProviderFor(searchAppUserByEmail)
const searchAppUserByEmailProvider = SearchAppUserByEmailFamily();

/// See also [searchAppUserByEmail].
class SearchAppUserByEmailFamily extends Family<AsyncValue<List<AppUser>>> {
  /// See also [searchAppUserByEmail].
  const SearchAppUserByEmailFamily();

  /// See also [searchAppUserByEmail].
  SearchAppUserByEmailProvider call(String email) {
    return SearchAppUserByEmailProvider(email);
  }

  @override
  SearchAppUserByEmailProvider getProviderOverride(
    covariant SearchAppUserByEmailProvider provider,
  ) {
    return call(provider.email);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchAppUserByEmailProvider';
}

/// See also [searchAppUserByEmail].
class SearchAppUserByEmailProvider
    extends AutoDisposeFutureProvider<List<AppUser>> {
  /// See also [searchAppUserByEmail].
  SearchAppUserByEmailProvider(String email)
    : this._internal(
        (ref) => searchAppUserByEmail(ref as SearchAppUserByEmailRef, email),
        from: searchAppUserByEmailProvider,
        name: r'searchAppUserByEmailProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$searchAppUserByEmailHash,
        dependencies: SearchAppUserByEmailFamily._dependencies,
        allTransitiveDependencies:
            SearchAppUserByEmailFamily._allTransitiveDependencies,
        email: email,
      );

  SearchAppUserByEmailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.email,
  }) : super.internal();

  final String email;

  @override
  Override overrideWith(
    FutureOr<List<AppUser>> Function(SearchAppUserByEmailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchAppUserByEmailProvider._internal(
        (ref) => create(ref as SearchAppUserByEmailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        email: email,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<AppUser>> createElement() {
    return _SearchAppUserByEmailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchAppUserByEmailProvider && other.email == email;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, email.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SearchAppUserByEmailRef on AutoDisposeFutureProviderRef<List<AppUser>> {
  /// The parameter `email` of this provider.
  String get email;
}

class _SearchAppUserByEmailProviderElement
    extends AutoDisposeFutureProviderElement<List<AppUser>>
    with SearchAppUserByEmailRef {
  _SearchAppUserByEmailProviderElement(super.provider);

  @override
  String get email => (origin as SearchAppUserByEmailProvider).email;
}

String _$createAppUserHash() => r'39019deac5c8c25ef00fbab824d2821b5cc6350c';

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
