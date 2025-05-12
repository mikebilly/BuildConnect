// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'construction_team_profile_model.dart';

class ConstructionTeamProfileMapper
    extends ClassMapperBase<ConstructionTeamProfile> {
  ConstructionTeamProfileMapper._();

  static ConstructionTeamProfileMapper? _instance;
  static ConstructionTeamProfileMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = ConstructionTeamProfileMapper._());
      ServiceTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ConstructionTeamProfile';

  static String? _$profileId(ConstructionTeamProfile v) => v.profileId;
  static const Field<ConstructionTeamProfile, String> _f$profileId =
      Field('profileId', _$profileId, key: r'profile_id', opt: true);
  static String _$representativeName(ConstructionTeamProfile v) =>
      v.representativeName;
  static const Field<ConstructionTeamProfile, String> _f$representativeName =
      Field('representativeName', _$representativeName,
          key: r'representative_name');
  static String _$representativePhone(ConstructionTeamProfile v) =>
      v.representativePhone;
  static const Field<ConstructionTeamProfile, String> _f$representativePhone =
      Field('representativePhone', _$representativePhone,
          key: r'representative_phone');
  static int _$teamSize(ConstructionTeamProfile v) => v.teamSize;
  static const Field<ConstructionTeamProfile, int> _f$teamSize =
      Field('teamSize', _$teamSize, key: r'team_size');
  static List<ServiceType> _$services(ConstructionTeamProfile v) => v.services;
  static const Field<ConstructionTeamProfile, List<ServiceType>> _f$services =
      Field('services', _$services);

  @override
  final MappableFields<ConstructionTeamProfile> fields = const {
    #profileId: _f$profileId,
    #representativeName: _f$representativeName,
    #representativePhone: _f$representativePhone,
    #teamSize: _f$teamSize,
    #services: _f$services,
  };

  static ConstructionTeamProfile _instantiate(DecodingData data) {
    return ConstructionTeamProfile(
        profileId: data.dec(_f$profileId),
        representativeName: data.dec(_f$representativeName),
        representativePhone: data.dec(_f$representativePhone),
        teamSize: data.dec(_f$teamSize),
        services: data.dec(_f$services));
  }

  @override
  final Function instantiate = _instantiate;

  static ConstructionTeamProfile fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ConstructionTeamProfile>(map);
  }

  static ConstructionTeamProfile fromJson(String json) {
    return ensureInitialized().decodeJson<ConstructionTeamProfile>(json);
  }
}

mixin ConstructionTeamProfileMappable {
  String toJson() {
    return ConstructionTeamProfileMapper.ensureInitialized()
        .encodeJson<ConstructionTeamProfile>(this as ConstructionTeamProfile);
  }

  Map<String, dynamic> toMap() {
    return ConstructionTeamProfileMapper.ensureInitialized()
        .encodeMap<ConstructionTeamProfile>(this as ConstructionTeamProfile);
  }

  ConstructionTeamProfileCopyWith<ConstructionTeamProfile,
          ConstructionTeamProfile, ConstructionTeamProfile>
      get copyWith => _ConstructionTeamProfileCopyWithImpl<
              ConstructionTeamProfile, ConstructionTeamProfile>(
          this as ConstructionTeamProfile, $identity, $identity);
  @override
  String toString() {
    return ConstructionTeamProfileMapper.ensureInitialized()
        .stringifyValue(this as ConstructionTeamProfile);
  }

  @override
  bool operator ==(Object other) {
    return ConstructionTeamProfileMapper.ensureInitialized()
        .equalsValue(this as ConstructionTeamProfile, other);
  }

  @override
  int get hashCode {
    return ConstructionTeamProfileMapper.ensureInitialized()
        .hashValue(this as ConstructionTeamProfile);
  }
}

extension ConstructionTeamProfileValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ConstructionTeamProfile, $Out> {
  ConstructionTeamProfileCopyWith<$R, ConstructionTeamProfile, $Out>
      get $asConstructionTeamProfile => $base.as((v, t, t2) =>
          _ConstructionTeamProfileCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ConstructionTeamProfileCopyWith<
    $R,
    $In extends ConstructionTeamProfile,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, ServiceType, ObjectCopyWith<$R, ServiceType, ServiceType>>
      get services;
  $R call(
      {String? profileId,
      String? representativeName,
      String? representativePhone,
      int? teamSize,
      List<ServiceType>? services});
  ConstructionTeamProfileCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ConstructionTeamProfileCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ConstructionTeamProfile, $Out>
    implements
        ConstructionTeamProfileCopyWith<$R, ConstructionTeamProfile, $Out> {
  _ConstructionTeamProfileCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ConstructionTeamProfile> $mapper =
      ConstructionTeamProfileMapper.ensureInitialized();
  @override
  ListCopyWith<$R, ServiceType, ObjectCopyWith<$R, ServiceType, ServiceType>>
      get services => ListCopyWith($value.services,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(services: v));
  @override
  $R call(
          {Object? profileId = $none,
          String? representativeName,
          String? representativePhone,
          int? teamSize,
          List<ServiceType>? services}) =>
      $apply(FieldCopyWithData({
        if (profileId != $none) #profileId: profileId,
        if (representativeName != null) #representativeName: representativeName,
        if (representativePhone != null)
          #representativePhone: representativePhone,
        if (teamSize != null) #teamSize: teamSize,
        if (services != null) #services: services
      }));
  @override
  ConstructionTeamProfile $make(CopyWithData data) => ConstructionTeamProfile(
      profileId: data.get(#profileId, or: $value.profileId),
      representativeName:
          data.get(#representativeName, or: $value.representativeName),
      representativePhone:
          data.get(#representativePhone, or: $value.representativePhone),
      teamSize: data.get(#teamSize, or: $value.teamSize),
      services: data.get(#services, or: $value.services));

  @override
  ConstructionTeamProfileCopyWith<$R2, ConstructionTeamProfile, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _ConstructionTeamProfileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
