// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'contractor_profile_model.dart';

class ContractorProfileMapper extends ClassMapperBase<ContractorProfile> {
  ContractorProfileMapper._();

  static ContractorProfileMapper? _instance;
  static ContractorProfileMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContractorProfileMapper._());
      ServiceTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ContractorProfile';

  static List<ServiceType> _$services(ContractorProfile v) => v.services;
  static const Field<ContractorProfile, List<ServiceType>> _f$services =
      Field('services', _$services);
  static List<InvalidType> _$equipments(ContractorProfile v) => v.equipments;
  static const Field<ContractorProfile, List<InvalidType>> _f$equipments =
      Field('equipments', _$equipments);

  @override
  final MappableFields<ContractorProfile> fields = const {
    #services: _f$services,
    #equipments: _f$equipments,
  };

  static ContractorProfile _instantiate(DecodingData data) {
    return ContractorProfile(
        services: data.dec(_f$services), equipments: data.dec(_f$equipments));
  }

  @override
  final Function instantiate = _instantiate;

  static ContractorProfile fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ContractorProfile>(map);
  }

  static ContractorProfile fromJson(String json) {
    return ensureInitialized().decodeJson<ContractorProfile>(json);
  }
}

mixin ContractorProfileMappable {
  String toJson() {
    return ContractorProfileMapper.ensureInitialized()
        .encodeJson<ContractorProfile>(this as ContractorProfile);
  }

  Map<String, dynamic> toMap() {
    return ContractorProfileMapper.ensureInitialized()
        .encodeMap<ContractorProfile>(this as ContractorProfile);
  }

  ContractorProfileCopyWith<ContractorProfile, ContractorProfile,
          ContractorProfile>
      get copyWith =>
          _ContractorProfileCopyWithImpl<ContractorProfile, ContractorProfile>(
              this as ContractorProfile, $identity, $identity);
  @override
  String toString() {
    return ContractorProfileMapper.ensureInitialized()
        .stringifyValue(this as ContractorProfile);
  }

  @override
  bool operator ==(Object other) {
    return ContractorProfileMapper.ensureInitialized()
        .equalsValue(this as ContractorProfile, other);
  }

  @override
  int get hashCode {
    return ContractorProfileMapper.ensureInitialized()
        .hashValue(this as ContractorProfile);
  }
}

extension ContractorProfileValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ContractorProfile, $Out> {
  ContractorProfileCopyWith<$R, ContractorProfile, $Out>
      get $asContractorProfile => $base
          .as((v, t, t2) => _ContractorProfileCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ContractorProfileCopyWith<$R, $In extends ContractorProfile,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, ServiceType, ObjectCopyWith<$R, ServiceType, ServiceType>>
      get services;
  ListCopyWith<$R, InvalidType, ObjectCopyWith<$R, InvalidType, InvalidType>>
      get equipments;
  $R call({List<ServiceType>? services, List<InvalidType>? equipments});
  ContractorProfileCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ContractorProfileCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ContractorProfile, $Out>
    implements ContractorProfileCopyWith<$R, ContractorProfile, $Out> {
  _ContractorProfileCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ContractorProfile> $mapper =
      ContractorProfileMapper.ensureInitialized();
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
  $R call({List<ServiceType>? services, List<InvalidType>? equipments}) =>
      $apply(FieldCopyWithData({
        if (services != null) #services: services,
        if (equipments != null) #equipments: equipments
      }));
  @override
  ContractorProfile $make(CopyWithData data) => ContractorProfile(
      services: data.get(#services, or: $value.services),
      equipments: data.get(#equipments, or: $value.equipments));

  @override
  ContractorProfileCopyWith<$R2, ContractorProfile, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ContractorProfileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
