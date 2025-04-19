// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'architect_profile_model.dart';

class ArchitectProfileMapper extends ClassMapperBase<ArchitectProfile> {
  ArchitectProfileMapper._();

  static ArchitectProfileMapper? _instance;
  static ArchitectProfileMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ArchitectProfileMapper._());
      ArchitectRoleMapper.ensureInitialized();
      DesignStyleMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ArchitectProfile';

  static ArchitectRole _$architectRole(ArchitectProfile v) => v.architectRole;
  static const Field<ArchitectProfile, ArchitectRole> _f$architectRole =
      Field('architectRole', _$architectRole);
  static List<InvalidType> _$education(ArchitectProfile v) => v.education;
  static const Field<ArchitectProfile, List<InvalidType>> _f$education =
      Field('education', _$education);
  static String _$designPhilosophy(ArchitectProfile v) => v.designPhilosophy;
  static const Field<ArchitectProfile, String> _f$designPhilosophy =
      Field('designPhilosophy', _$designPhilosophy);
  static List<DesignStyle> _$designStyles(ArchitectProfile v) => v.designStyles;
  static const Field<ArchitectProfile, List<DesignStyle>> _f$designStyles =
      Field('designStyles', _$designStyles);
  static List<String> _$portfolioLinks(ArchitectProfile v) => v.portfolioLinks;
  static const Field<ArchitectProfile, List<String>> _f$portfolioLinks =
      Field('portfolioLinks', _$portfolioLinks);

  @override
  final MappableFields<ArchitectProfile> fields = const {
    #architectRole: _f$architectRole,
    #education: _f$education,
    #designPhilosophy: _f$designPhilosophy,
    #designStyles: _f$designStyles,
    #portfolioLinks: _f$portfolioLinks,
  };

  static ArchitectProfile _instantiate(DecodingData data) {
    return ArchitectProfile(
        architectRole: data.dec(_f$architectRole),
        education: data.dec(_f$education),
        designPhilosophy: data.dec(_f$designPhilosophy),
        designStyles: data.dec(_f$designStyles),
        portfolioLinks: data.dec(_f$portfolioLinks));
  }

  @override
  final Function instantiate = _instantiate;

  static ArchitectProfile fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ArchitectProfile>(map);
  }

  static ArchitectProfile fromJson(String json) {
    return ensureInitialized().decodeJson<ArchitectProfile>(json);
  }
}

mixin ArchitectProfileMappable {
  String toJson() {
    return ArchitectProfileMapper.ensureInitialized()
        .encodeJson<ArchitectProfile>(this as ArchitectProfile);
  }

  Map<String, dynamic> toMap() {
    return ArchitectProfileMapper.ensureInitialized()
        .encodeMap<ArchitectProfile>(this as ArchitectProfile);
  }

  ArchitectProfileCopyWith<ArchitectProfile, ArchitectProfile, ArchitectProfile>
      get copyWith =>
          _ArchitectProfileCopyWithImpl<ArchitectProfile, ArchitectProfile>(
              this as ArchitectProfile, $identity, $identity);
  @override
  String toString() {
    return ArchitectProfileMapper.ensureInitialized()
        .stringifyValue(this as ArchitectProfile);
  }

  @override
  bool operator ==(Object other) {
    return ArchitectProfileMapper.ensureInitialized()
        .equalsValue(this as ArchitectProfile, other);
  }

  @override
  int get hashCode {
    return ArchitectProfileMapper.ensureInitialized()
        .hashValue(this as ArchitectProfile);
  }
}

extension ArchitectProfileValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ArchitectProfile, $Out> {
  ArchitectProfileCopyWith<$R, ArchitectProfile, $Out>
      get $asArchitectProfile => $base
          .as((v, t, t2) => _ArchitectProfileCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ArchitectProfileCopyWith<$R, $In extends ArchitectProfile, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, InvalidType, ObjectCopyWith<$R, InvalidType, InvalidType>>
      get education;
  ListCopyWith<$R, DesignStyle, ObjectCopyWith<$R, DesignStyle, DesignStyle>>
      get designStyles;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get portfolioLinks;
  $R call(
      {ArchitectRole? architectRole,
      List<InvalidType>? education,
      String? designPhilosophy,
      List<DesignStyle>? designStyles,
      List<String>? portfolioLinks});
  ArchitectProfileCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ArchitectProfileCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ArchitectProfile, $Out>
    implements ArchitectProfileCopyWith<$R, ArchitectProfile, $Out> {
  _ArchitectProfileCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ArchitectProfile> $mapper =
      ArchitectProfileMapper.ensureInitialized();
  @override
  ListCopyWith<$R, InvalidType, ObjectCopyWith<$R, InvalidType, InvalidType>>
      get education => ListCopyWith($value.education,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(education: v));
  @override
  ListCopyWith<$R, DesignStyle, ObjectCopyWith<$R, DesignStyle, DesignStyle>>
      get designStyles => ListCopyWith(
          $value.designStyles,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(designStyles: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get portfolioLinks => ListCopyWith(
          $value.portfolioLinks,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(portfolioLinks: v));
  @override
  $R call(
          {ArchitectRole? architectRole,
          List<InvalidType>? education,
          String? designPhilosophy,
          List<DesignStyle>? designStyles,
          List<String>? portfolioLinks}) =>
      $apply(FieldCopyWithData({
        if (architectRole != null) #architectRole: architectRole,
        if (education != null) #education: education,
        if (designPhilosophy != null) #designPhilosophy: designPhilosophy,
        if (designStyles != null) #designStyles: designStyles,
        if (portfolioLinks != null) #portfolioLinks: portfolioLinks
      }));
  @override
  ArchitectProfile $make(CopyWithData data) => ArchitectProfile(
      architectRole: data.get(#architectRole, or: $value.architectRole),
      education: data.get(#education, or: $value.education),
      designPhilosophy:
          data.get(#designPhilosophy, or: $value.designPhilosophy),
      designStyles: data.get(#designStyles, or: $value.designStyles),
      portfolioLinks: data.get(#portfolioLinks, or: $value.portfolioLinks));

  @override
  ArchitectProfileCopyWith<$R2, ArchitectProfile, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ArchitectProfileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
