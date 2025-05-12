// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'supplier_profile_model.dart';

class SupplierProfileMapper extends ClassMapperBase<SupplierProfile> {
  SupplierProfileMapper._();

  static SupplierProfileMapper? _instance;
  static SupplierProfileMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SupplierProfileMapper._());
      SupplierTypeMapper.ensureInitialized();
      MaterialCategoryMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SupplierProfile';

  static String? _$profileId(SupplierProfile v) => v.profileId;
  static const Field<SupplierProfile, String> _f$profileId =
      Field('profileId', _$profileId, key: r'profile_id', opt: true);
  static SupplierType _$supplierType(SupplierProfile v) => v.supplierType;
  static const Field<SupplierProfile, SupplierType> _f$supplierType =
      Field('supplierType', _$supplierType, key: r'supplier_type');
  static List<MaterialCategory> _$materialCategories(SupplierProfile v) =>
      v.materialCategories;
  static const Field<SupplierProfile, List<MaterialCategory>>
      _f$materialCategories = Field('materialCategories', _$materialCategories,
          key: r'material_categories');
  static int _$deliveryRadius(SupplierProfile v) => v.deliveryRadius;
  static const Field<SupplierProfile, int> _f$deliveryRadius =
      Field('deliveryRadius', _$deliveryRadius, key: r'delivery_radius');

  @override
  final MappableFields<SupplierProfile> fields = const {
    #profileId: _f$profileId,
    #supplierType: _f$supplierType,
    #materialCategories: _f$materialCategories,
    #deliveryRadius: _f$deliveryRadius,
  };

  static SupplierProfile _instantiate(DecodingData data) {
    return SupplierProfile(
        profileId: data.dec(_f$profileId),
        supplierType: data.dec(_f$supplierType),
        materialCategories: data.dec(_f$materialCategories),
        deliveryRadius: data.dec(_f$deliveryRadius));
  }

  @override
  final Function instantiate = _instantiate;

  static SupplierProfile fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SupplierProfile>(map);
  }

  static SupplierProfile fromJson(String json) {
    return ensureInitialized().decodeJson<SupplierProfile>(json);
  }
}

mixin SupplierProfileMappable {
  String toJson() {
    return SupplierProfileMapper.ensureInitialized()
        .encodeJson<SupplierProfile>(this as SupplierProfile);
  }

  Map<String, dynamic> toMap() {
    return SupplierProfileMapper.ensureInitialized()
        .encodeMap<SupplierProfile>(this as SupplierProfile);
  }

  SupplierProfileCopyWith<SupplierProfile, SupplierProfile, SupplierProfile>
      get copyWith =>
          _SupplierProfileCopyWithImpl<SupplierProfile, SupplierProfile>(
              this as SupplierProfile, $identity, $identity);
  @override
  String toString() {
    return SupplierProfileMapper.ensureInitialized()
        .stringifyValue(this as SupplierProfile);
  }

  @override
  bool operator ==(Object other) {
    return SupplierProfileMapper.ensureInitialized()
        .equalsValue(this as SupplierProfile, other);
  }

  @override
  int get hashCode {
    return SupplierProfileMapper.ensureInitialized()
        .hashValue(this as SupplierProfile);
  }
}

extension SupplierProfileValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SupplierProfile, $Out> {
  SupplierProfileCopyWith<$R, SupplierProfile, $Out> get $asSupplierProfile =>
      $base.as((v, t, t2) => _SupplierProfileCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SupplierProfileCopyWith<$R, $In extends SupplierProfile, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, MaterialCategory,
          ObjectCopyWith<$R, MaterialCategory, MaterialCategory>>
      get materialCategories;
  $R call(
      {String? profileId,
      SupplierType? supplierType,
      List<MaterialCategory>? materialCategories,
      int? deliveryRadius});
  SupplierProfileCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SupplierProfileCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SupplierProfile, $Out>
    implements SupplierProfileCopyWith<$R, SupplierProfile, $Out> {
  _SupplierProfileCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SupplierProfile> $mapper =
      SupplierProfileMapper.ensureInitialized();
  @override
  ListCopyWith<$R, MaterialCategory,
          ObjectCopyWith<$R, MaterialCategory, MaterialCategory>>
      get materialCategories => ListCopyWith(
          $value.materialCategories,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(materialCategories: v));
  @override
  $R call(
          {Object? profileId = $none,
          SupplierType? supplierType,
          List<MaterialCategory>? materialCategories,
          int? deliveryRadius}) =>
      $apply(FieldCopyWithData({
        if (profileId != $none) #profileId: profileId,
        if (supplierType != null) #supplierType: supplierType,
        if (materialCategories != null) #materialCategories: materialCategories,
        if (deliveryRadius != null) #deliveryRadius: deliveryRadius
      }));
  @override
  SupplierProfile $make(CopyWithData data) => SupplierProfile(
      profileId: data.get(#profileId, or: $value.profileId),
      supplierType: data.get(#supplierType, or: $value.supplierType),
      materialCategories:
          data.get(#materialCategories, or: $value.materialCategories),
      deliveryRadius: data.get(#deliveryRadius, or: $value.deliveryRadius));

  @override
  SupplierProfileCopyWith<$R2, SupplierProfile, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SupplierProfileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
