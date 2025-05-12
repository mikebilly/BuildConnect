// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$profileDataByUserIdHash() =>
    r'802be8933e8c2b13797db7d906875bbb7d571925';

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

/// See also [profileDataByUserId].
@ProviderFor(profileDataByUserId)
const profileDataByUserIdProvider = ProfileDataByUserIdFamily();

/// See also [profileDataByUserId].
class ProfileDataByUserIdFamily extends Family<AsyncValue<ProfileData?>> {
  /// See also [profileDataByUserId].
  const ProfileDataByUserIdFamily();

  /// See also [profileDataByUserId].
  ProfileDataByUserIdProvider call(String userId) {
    return ProfileDataByUserIdProvider(userId);
  }

  @override
  ProfileDataByUserIdProvider getProviderOverride(
    covariant ProfileDataByUserIdProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'profileDataByUserIdProvider';
}

/// See also [profileDataByUserId].
class ProfileDataByUserIdProvider extends FutureProvider<ProfileData?> {
  /// See also [profileDataByUserId].
  ProfileDataByUserIdProvider(String userId)
    : this._internal(
        (ref) => profileDataByUserId(ref as ProfileDataByUserIdRef, userId),
        from: profileDataByUserIdProvider,
        name: r'profileDataByUserIdProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$profileDataByUserIdHash,
        dependencies: ProfileDataByUserIdFamily._dependencies,
        allTransitiveDependencies:
            ProfileDataByUserIdFamily._allTransitiveDependencies,
        userId: userId,
      );

  ProfileDataByUserIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<ProfileData?> Function(ProfileDataByUserIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProfileDataByUserIdProvider._internal(
        (ref) => create(ref as ProfileDataByUserIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  FutureProviderElement<ProfileData?> createElement() {
    return _ProfileDataByUserIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProfileDataByUserIdProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProfileDataByUserIdRef on FutureProviderRef<ProfileData?> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _ProfileDataByUserIdProviderElement
    extends FutureProviderElement<ProfileData?>
    with ProfileDataByUserIdRef {
  _ProfileDataByUserIdProviderElement(super.provider);

  @override
  String get userId => (origin as ProfileDataByUserIdProvider).userId;
}

String _$profileDataNotifierHash() =>
    r'23d3e206707b9d491411f4e4bfb757485ee3cdec';

/// See also [ProfileDataNotifier].
@ProviderFor(ProfileDataNotifier)
final profileDataNotifierProvider =
    AsyncNotifierProvider<ProfileDataNotifier, ProfileData?>.internal(
      ProfileDataNotifier.new,
      name: r'profileDataNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$profileDataNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ProfileDataNotifier = AsyncNotifier<ProfileData?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
