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
      ProfileTypeMapper.ensureInitialized();
      DesignStyleMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ProfileData';

  static String _$displayName(ProfileData v) => v.displayName;
  static const Field<ProfileData, String> _f$displayName =
      Field('displayName', _$displayName);
  static ProfileType _$profileType(ProfileData v) => v.profileType;
  static const Field<ProfileData, ProfileType> _f$profileType =
      Field('profileType', _$profileType);
  static List<String> _$portfolioLinks(ProfileData v) => v.portfolioLinks;
  static const Field<ProfileData, List<String>> _f$portfolioLinks =
      Field('portfolioLinks', _$portfolioLinks);
  static List<DesignStyle> _$designStyles(ProfileData v) => v.designStyles;
  static const Field<ProfileData, List<DesignStyle>> _f$designStyles =
      Field('designStyles', _$designStyles);

  @override
  final MappableFields<ProfileData> fields = const {
    #displayName: _f$displayName,
    #profileType: _f$profileType,
    #portfolioLinks: _f$portfolioLinks,
    #designStyles: _f$designStyles,
  };

  static ProfileData _instantiate(DecodingData data) {
    return ProfileData(
        displayName: data.dec(_f$displayName),
        profileType: data.dec(_f$profileType),
        portfolioLinks: data.dec(_f$portfolioLinks),
        designStyles: data.dec(_f$designStyles));
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
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get portfolioLinks;
  ListCopyWith<$R, DesignStyle, ObjectCopyWith<$R, DesignStyle, DesignStyle>>
      get designStyles;
  $R call(
      {String? displayName,
      ProfileType? profileType,
      List<String>? portfolioLinks,
      List<DesignStyle>? designStyles});
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
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get portfolioLinks => ListCopyWith(
          $value.portfolioLinks,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(portfolioLinks: v));
  @override
  ListCopyWith<$R, DesignStyle, ObjectCopyWith<$R, DesignStyle, DesignStyle>>
      get designStyles => ListCopyWith(
          $value.designStyles,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(designStyles: v));
  @override
  $R call(
          {String? displayName,
          ProfileType? profileType,
          List<String>? portfolioLinks,
          List<DesignStyle>? designStyles}) =>
      $apply(FieldCopyWithData({
        if (displayName != null) #displayName: displayName,
        if (profileType != null) #profileType: profileType,
        if (portfolioLinks != null) #portfolioLinks: portfolioLinks,
        if (designStyles != null) #designStyles: designStyles
      }));
  @override
  ProfileData $make(CopyWithData data) => ProfileData(
      displayName: data.get(#displayName, or: $value.displayName),
      profileType: data.get(#profileType, or: $value.profileType),
      portfolioLinks: data.get(#portfolioLinks, or: $value.portfolioLinks),
      designStyles: data.get(#designStyles, or: $value.designStyles));

  @override
  ProfileDataCopyWith<$R2, ProfileData, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ProfileDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
