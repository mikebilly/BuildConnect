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

  static SupplierType _$supplierType(SupplierProfile v) => v.supplierType;
  static const Field<SupplierProfile, SupplierType> _f$supplierType =
      Field('supplierType', _$supplierType);
  static List<MaterialCategory> _$materialCategories(SupplierProfile v) =>
      v.materialCategories;
  static const Field<SupplierProfile, List<MaterialCategory>>
      _f$materialCategories = Field('materialCategories', _$materialCategories);
  static String _$supplyCapacity(SupplierProfile v) => v.supplyCapacity;
  static const Field<SupplierProfile, String> _f$supplyCapacity =
      Field('supplyCapacity', _$supplyCapacity);
  static int _$deliveryRadius(SupplierProfile v) => v.deliveryRadius;
  static const Field<SupplierProfile, int> _f$deliveryRadius =
      Field('deliveryRadius', _$deliveryRadius);
  static List<InvalidType> _$warehouseLocations(SupplierProfile v) =>
      v.warehouseLocations;
  static const Field<SupplierProfile, List<InvalidType>> _f$warehouseLocations =
      Field('warehouseLocations', _$warehouseLocations);
  static List<InvalidType> _$catalogs(SupplierProfile v) => v.catalogs;
  static const Field<SupplierProfile, List<InvalidType>> _f$catalogs =
      Field('catalogs', _$catalogs);

  @override
  final MappableFields<SupplierProfile> fields = const {
    #supplierType: _f$supplierType,
    #materialCategories: _f$materialCategories,
    #supplyCapacity: _f$supplyCapacity,
    #deliveryRadius: _f$deliveryRadius,
    #warehouseLocations: _f$warehouseLocations,
    #catalogs: _f$catalogs,
  };

  static SupplierProfile _instantiate(DecodingData data) {
    return SupplierProfile(
        supplierType: data.dec(_f$supplierType),
        materialCategories: data.dec(_f$materialCategories),
        supplyCapacity: data.dec(_f$supplyCapacity),
        deliveryRadius: data.dec(_f$deliveryRadius),
        warehouseLocations: data.dec(_f$warehouseLocations),
        catalogs: data.dec(_f$catalogs));
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
  ListCopyWith<$R, InvalidType, ObjectCopyWith<$R, InvalidType, InvalidType>>
      get warehouseLocations;
  ListCopyWith<$R, InvalidType, ObjectCopyWith<$R, InvalidType, InvalidType>>
      get catalogs;
  $R call(
      {SupplierType? supplierType,
      List<MaterialCategory>? materialCategories,
      String? supplyCapacity,
      int? deliveryRadius,
      List<InvalidType>? warehouseLocations,
      List<InvalidType>? catalogs});
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
  ListCopyWith<$R, InvalidType, ObjectCopyWith<$R, InvalidType, InvalidType>>
      get warehouseLocations => ListCopyWith(
          $value.warehouseLocations,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(warehouseLocations: v));
  @override
  ListCopyWith<$R, InvalidType, ObjectCopyWith<$R, InvalidType, InvalidType>>
      get catalogs => ListCopyWith($value.catalogs,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(catalogs: v));
  @override
  $R call(
          {SupplierType? supplierType,
          List<MaterialCategory>? materialCategories,
          String? supplyCapacity,
          int? deliveryRadius,
          List<InvalidType>? warehouseLocations,
          List<InvalidType>? catalogs}) =>
      $apply(FieldCopyWithData({
        if (supplierType != null) #supplierType: supplierType,
        if (materialCategories != null) #materialCategories: materialCategories,
        if (supplyCapacity != null) #supplyCapacity: supplyCapacity,
        if (deliveryRadius != null) #deliveryRadius: deliveryRadius,
        if (warehouseLocations != null) #warehouseLocations: warehouseLocations,
        if (catalogs != null) #catalogs: catalogs
      }));
  @override
  SupplierProfile $make(CopyWithData data) => SupplierProfile(
      supplierType: data.get(#supplierType, or: $value.supplierType),
      materialCategories:
          data.get(#materialCategories, or: $value.materialCategories),
      supplyCapacity: data.get(#supplyCapacity, or: $value.supplyCapacity),
      deliveryRadius: data.get(#deliveryRadius, or: $value.deliveryRadius),
      warehouseLocations:
          data.get(#warehouseLocations, or: $value.warehouseLocations),
      catalogs: data.get(#catalogs, or: $value.catalogs));

  @override
  SupplierProfileCopyWith<$R2, SupplierProfile, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SupplierProfileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
