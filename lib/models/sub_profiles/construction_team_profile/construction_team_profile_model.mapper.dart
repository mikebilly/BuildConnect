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

  static InvalidType _$representative(ConstructionTeamProfile v) =>
      v.representative;
  static const Field<ConstructionTeamProfile, InvalidType> _f$representative =
      Field('representative', _$representative);
  static int _$teamSize(ConstructionTeamProfile v) => v.teamSize;
  static const Field<ConstructionTeamProfile, int> _f$teamSize =
      Field('teamSize', _$teamSize);
  static List<ServiceType> _$services(ConstructionTeamProfile v) => v.services;
  static const Field<ConstructionTeamProfile, List<ServiceType>> _f$services =
      Field('services', _$services);
  static List<InvalidType> _$equipments(ConstructionTeamProfile v) =>
      v.equipments;
  static const Field<ConstructionTeamProfile, List<InvalidType>> _f$equipments =
      Field('equipments', _$equipments);

  @override
  final MappableFields<ConstructionTeamProfile> fields = const {
    #representative: _f$representative,
    #teamSize: _f$teamSize,
    #services: _f$services,
    #equipments: _f$equipments,
  };

  static ConstructionTeamProfile _instantiate(DecodingData data) {
    return ConstructionTeamProfile(
        representative: data.dec(_f$representative),
        teamSize: data.dec(_f$teamSize),
        services: data.dec(_f$services),
        equipments: data.dec(_f$equipments));
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
  ListCopyWith<$R, InvalidType, ObjectCopyWith<$R, InvalidType, InvalidType>>
      get equipments;
  $R call(
      {InvalidType? representative,
      int? teamSize,
      List<ServiceType>? services,
      List<InvalidType>? equipments});
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
  ListCopyWith<$R, InvalidType, ObjectCopyWith<$R, InvalidType, InvalidType>>
      get equipments => ListCopyWith(
          $value.equipments,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(equipments: v));
  @override
  $R call(
          {InvalidType? representative,
          int? teamSize,
          List<ServiceType>? services,
          List<InvalidType>? equipments}) =>
      $apply(FieldCopyWithData({
        if (representative != null) #representative: representative,
        if (teamSize != null) #teamSize: teamSize,
        if (services != null) #services: services,
        if (equipments != null) #equipments: equipments
      }));
  @override
  ConstructionTeamProfile $make(CopyWithData data) => ConstructionTeamProfile(
      representative: data.get(#representative, or: $value.representative),
      teamSize: data.get(#teamSize, or: $value.teamSize),
      services: data.get(#services, or: $value.services),
      equipments: data.get(#equipments, or: $value.equipments));

  @override
  ConstructionTeamProfileCopyWith<$R2, ConstructionTeamProfile, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _ConstructionTeamProfileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
