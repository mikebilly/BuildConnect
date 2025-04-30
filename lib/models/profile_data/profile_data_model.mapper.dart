// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'profile_data_model.dart';

class ProfileDataMapper extends ClassMapperBase<ProfileData> {
  ProfileDataMapper._();

  static ProfileDataMapper? _instance;
  static ProfileDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProfileDataMapper._());
      ProfileMapper.ensureInitialized();
      ArchitectProfileMapper.ensureInitialized();
      ContractorProfileMapper.ensureInitialized();
      SupplierProfileMapper.ensureInitialized();
      ConstructionTeamProfileMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ProfileData';

  static Profile _$profile(ProfileData v) => v.profile;
  static const Field<ProfileData, Profile> _f$profile =
      Field('profile', _$profile);
  static ArchitectProfile? _$architectProfile(ProfileData v) =>
      v.architectProfile;
  static const Field<ProfileData, ArchitectProfile> _f$architectProfile =
      Field('architectProfile', _$architectProfile, opt: true);
  static ContractorProfile? _$contractorProfile(ProfileData v) =>
      v.contractorProfile;
  static const Field<ProfileData, ContractorProfile> _f$contractorProfile =
      Field('contractorProfile', _$contractorProfile, opt: true);
  static SupplierProfile? _$supplierProfile(ProfileData v) => v.supplierProfile;
  static const Field<ProfileData, SupplierProfile> _f$supplierProfile =
      Field('supplierProfile', _$supplierProfile, opt: true);
  static ConstructionTeamProfile? _$constructionTeamProfile(ProfileData v) =>
      v.constructionTeamProfile;
  static const Field<ProfileData, ConstructionTeamProfile>
      _f$constructionTeamProfile =
      Field('constructionTeamProfile', _$constructionTeamProfile, opt: true);

  @override
  final MappableFields<ProfileData> fields = const {
    #profile: _f$profile,
    #architectProfile: _f$architectProfile,
    #contractorProfile: _f$contractorProfile,
    #supplierProfile: _f$supplierProfile,
    #constructionTeamProfile: _f$constructionTeamProfile,
  };

  static ProfileData _instantiate(DecodingData data) {
    return ProfileData(
        profile: data.dec(_f$profile),
        architectProfile: data.dec(_f$architectProfile),
        contractorProfile: data.dec(_f$contractorProfile),
        supplierProfile: data.dec(_f$supplierProfile),
        constructionTeamProfile: data.dec(_f$constructionTeamProfile));
  }

  @override
  final Function instantiate = _instantiate;

  static ProfileData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProfileData>(map);
  }

  static ProfileData fromJson(String json) {
    return ensureInitialized().decodeJson<ProfileData>(json);
  }
}

mixin ProfileDataMappable {
  String toJson() {
    return ProfileDataMapper.ensureInitialized()
        .encodeJson<ProfileData>(this as ProfileData);
  }

  Map<String, dynamic> toMap() {
    return ProfileDataMapper.ensureInitialized()
        .encodeMap<ProfileData>(this as ProfileData);
  }

  ProfileDataCopyWith<ProfileData, ProfileData, ProfileData> get copyWith =>
      _ProfileDataCopyWithImpl<ProfileData, ProfileData>(
          this as ProfileData, $identity, $identity);
  @override
  String toString() {
    return ProfileDataMapper.ensureInitialized()
        .stringifyValue(this as ProfileData);
  }

  @override
  bool operator ==(Object other) {
    return ProfileDataMapper.ensureInitialized()
        .equalsValue(this as ProfileData, other);
  }

  @override
  int get hashCode {
    return ProfileDataMapper.ensureInitialized().hashValue(this as ProfileData);
  }
}

extension ProfileDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProfileData, $Out> {
  ProfileDataCopyWith<$R, ProfileData, $Out> get $asProfileData =>
      $base.as((v, t, t2) => _ProfileDataCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProfileDataCopyWith<$R, $In extends ProfileData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ProfileCopyWith<$R, Profile, Profile> get profile;
  ArchitectProfileCopyWith<$R, ArchitectProfile, ArchitectProfile>?
      get architectProfile;
  ContractorProfileCopyWith<$R, ContractorProfile, ContractorProfile>?
      get contractorProfile;
  SupplierProfileCopyWith<$R, SupplierProfile, SupplierProfile>?
      get supplierProfile;
  ConstructionTeamProfileCopyWith<$R, ConstructionTeamProfile,
      ConstructionTeamProfile>? get constructionTeamProfile;
  $R call(
      {Profile? profile,
      ArchitectProfile? architectProfile,
      ContractorProfile? contractorProfile,
      SupplierProfile? supplierProfile,
      ConstructionTeamProfile? constructionTeamProfile});
  ProfileDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProfileDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProfileData, $Out>
    implements ProfileDataCopyWith<$R, ProfileData, $Out> {
  _ProfileDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProfileData> $mapper =
      ProfileDataMapper.ensureInitialized();
  @override
  ProfileCopyWith<$R, Profile, Profile> get profile =>
      $value.profile.copyWith.$chain((v) => call(profile: v));
  @override
  ArchitectProfileCopyWith<$R, ArchitectProfile, ArchitectProfile>?
      get architectProfile => $value.architectProfile?.copyWith
          .$chain((v) => call(architectProfile: v));
  @override
  ContractorProfileCopyWith<$R, ContractorProfile, ContractorProfile>?
      get contractorProfile => $value.contractorProfile?.copyWith
          .$chain((v) => call(contractorProfile: v));
  @override
  SupplierProfileCopyWith<$R, SupplierProfile, SupplierProfile>?
      get supplierProfile => $value.supplierProfile?.copyWith
          .$chain((v) => call(supplierProfile: v));
  @override
  ConstructionTeamProfileCopyWith<$R, ConstructionTeamProfile,
          ConstructionTeamProfile>?
      get constructionTeamProfile => $value.constructionTeamProfile?.copyWith
          .$chain((v) => call(constructionTeamProfile: v));
  @override
  $R call(
          {Profile? profile,
          Object? architectProfile = $none,
          Object? contractorProfile = $none,
          Object? supplierProfile = $none,
          Object? constructionTeamProfile = $none}) =>
      $apply(FieldCopyWithData({
        if (profile != null) #profile: profile,
        if (architectProfile != $none) #architectProfile: architectProfile,
        if (contractorProfile != $none) #contractorProfile: contractorProfile,
        if (supplierProfile != $none) #supplierProfile: supplierProfile,
        if (constructionTeamProfile != $none)
          #constructionTeamProfile: constructionTeamProfile
      }));
  @override
  ProfileData $make(CopyWithData data) => ProfileData(
      profile: data.get(#profile, or: $value.profile),
      architectProfile:
          data.get(#architectProfile, or: $value.architectProfile),
      contractorProfile:
          data.get(#contractorProfile, or: $value.contractorProfile),
      supplierProfile: data.get(#supplierProfile, or: $value.supplierProfile),
      constructionTeamProfile: data.get(#constructionTeamProfile,
          or: $value.constructionTeamProfile));

  @override
  ProfileDataCopyWith<$R2, ProfileData, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ProfileDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
