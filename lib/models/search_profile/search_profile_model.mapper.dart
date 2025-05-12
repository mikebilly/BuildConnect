// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'search_profile_model.dart';

class ArchitectFilterModelMapper extends ClassMapperBase<ArchitectFilterModel> {
  ArchitectFilterModelMapper._();

  static ArchitectFilterModelMapper? _instance;
  static ArchitectFilterModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ArchitectFilterModelMapper._());
      ArchitectRoleMapper.ensureInitialized();
      DesignStyleMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ArchitectFilterModel';

  static ArchitectRole? _$architectRole(ArchitectFilterModel v) =>
      v.architectRole;
  static const Field<ArchitectFilterModel, ArchitectRole> _f$architectRole =
      Field('architectRole', _$architectRole, opt: true);
  static List<DesignStyle> _$designStyle(ArchitectFilterModel v) =>
      v.designStyle;
  static const Field<ArchitectFilterModel, List<DesignStyle>> _f$designStyle =
      Field('designStyle', _$designStyle, opt: true, def: const []);

  @override
  final MappableFields<ArchitectFilterModel> fields = const {
    #architectRole: _f$architectRole,
    #designStyle: _f$designStyle,
  };

  static ArchitectFilterModel _instantiate(DecodingData data) {
    return ArchitectFilterModel(
        architectRole: data.dec(_f$architectRole),
        designStyle: data.dec(_f$designStyle));
  }

  @override
  final Function instantiate = _instantiate;

  static ArchitectFilterModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ArchitectFilterModel>(map);
  }

  static ArchitectFilterModel fromJson(String json) {
    return ensureInitialized().decodeJson<ArchitectFilterModel>(json);
  }
}

mixin ArchitectFilterModelMappable {
  String toJson() {
    return ArchitectFilterModelMapper.ensureInitialized()
        .encodeJson<ArchitectFilterModel>(this as ArchitectFilterModel);
  }

  Map<String, dynamic> toMap() {
    return ArchitectFilterModelMapper.ensureInitialized()
        .encodeMap<ArchitectFilterModel>(this as ArchitectFilterModel);
  }

  ArchitectFilterModelCopyWith<ArchitectFilterModel, ArchitectFilterModel,
      ArchitectFilterModel> get copyWith => _ArchitectFilterModelCopyWithImpl<
          ArchitectFilterModel, ArchitectFilterModel>(
      this as ArchitectFilterModel, $identity, $identity);
  @override
  String toString() {
    return ArchitectFilterModelMapper.ensureInitialized()
        .stringifyValue(this as ArchitectFilterModel);
  }

  @override
  bool operator ==(Object other) {
    return ArchitectFilterModelMapper.ensureInitialized()
        .equalsValue(this as ArchitectFilterModel, other);
  }

  @override
  int get hashCode {
    return ArchitectFilterModelMapper.ensureInitialized()
        .hashValue(this as ArchitectFilterModel);
  }
}

extension ArchitectFilterModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ArchitectFilterModel, $Out> {
  ArchitectFilterModelCopyWith<$R, ArchitectFilterModel, $Out>
      get $asArchitectFilterModel => $base.as(
          (v, t, t2) => _ArchitectFilterModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ArchitectFilterModelCopyWith<
    $R,
    $In extends ArchitectFilterModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, DesignStyle, ObjectCopyWith<$R, DesignStyle, DesignStyle>>
      get designStyle;
  $R call({ArchitectRole? architectRole, List<DesignStyle>? designStyle});
  ArchitectFilterModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ArchitectFilterModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ArchitectFilterModel, $Out>
    implements ArchitectFilterModelCopyWith<$R, ArchitectFilterModel, $Out> {
  _ArchitectFilterModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ArchitectFilterModel> $mapper =
      ArchitectFilterModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, DesignStyle, ObjectCopyWith<$R, DesignStyle, DesignStyle>>
      get designStyle => ListCopyWith(
          $value.designStyle,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(designStyle: v));
  @override
  $R call({Object? architectRole = $none, List<DesignStyle>? designStyle}) =>
      $apply(FieldCopyWithData({
        if (architectRole != $none) #architectRole: architectRole,
        if (designStyle != null) #designStyle: designStyle
      }));
  @override
  ArchitectFilterModel $make(CopyWithData data) => ArchitectFilterModel(
      architectRole: data.get(#architectRole, or: $value.architectRole),
      designStyle: data.get(#designStyle, or: $value.designStyle));

  @override
  ArchitectFilterModelCopyWith<$R2, ArchitectFilterModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _ArchitectFilterModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ContractorFilterModelMapper
    extends ClassMapperBase<ContractorFilterModel> {
  ContractorFilterModelMapper._();

  static ContractorFilterModelMapper? _instance;
  static ContractorFilterModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContractorFilterModelMapper._());
      ServiceTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ContractorFilterModel';

  static List<ServiceType> _$serviceType(ContractorFilterModel v) =>
      v.serviceType;
  static const Field<ContractorFilterModel, List<ServiceType>> _f$serviceType =
      Field('serviceType', _$serviceType, opt: true, def: const []);

  @override
  final MappableFields<ContractorFilterModel> fields = const {
    #serviceType: _f$serviceType,
  };

  static ContractorFilterModel _instantiate(DecodingData data) {
    return ContractorFilterModel(serviceType: data.dec(_f$serviceType));
  }

  @override
  final Function instantiate = _instantiate;

  static ContractorFilterModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ContractorFilterModel>(map);
  }

  static ContractorFilterModel fromJson(String json) {
    return ensureInitialized().decodeJson<ContractorFilterModel>(json);
  }
}

mixin ContractorFilterModelMappable {
  String toJson() {
    return ContractorFilterModelMapper.ensureInitialized()
        .encodeJson<ContractorFilterModel>(this as ContractorFilterModel);
  }

  Map<String, dynamic> toMap() {
    return ContractorFilterModelMapper.ensureInitialized()
        .encodeMap<ContractorFilterModel>(this as ContractorFilterModel);
  }

  ContractorFilterModelCopyWith<ContractorFilterModel, ContractorFilterModel,
      ContractorFilterModel> get copyWith => _ContractorFilterModelCopyWithImpl<
          ContractorFilterModel, ContractorFilterModel>(
      this as ContractorFilterModel, $identity, $identity);
  @override
  String toString() {
    return ContractorFilterModelMapper.ensureInitialized()
        .stringifyValue(this as ContractorFilterModel);
  }

  @override
  bool operator ==(Object other) {
    return ContractorFilterModelMapper.ensureInitialized()
        .equalsValue(this as ContractorFilterModel, other);
  }

  @override
  int get hashCode {
    return ContractorFilterModelMapper.ensureInitialized()
        .hashValue(this as ContractorFilterModel);
  }
}

extension ContractorFilterModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ContractorFilterModel, $Out> {
  ContractorFilterModelCopyWith<$R, ContractorFilterModel, $Out>
      get $asContractorFilterModel => $base.as(
          (v, t, t2) => _ContractorFilterModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ContractorFilterModelCopyWith<
    $R,
    $In extends ContractorFilterModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, ServiceType, ObjectCopyWith<$R, ServiceType, ServiceType>>
      get serviceType;
  $R call({List<ServiceType>? serviceType});
  ContractorFilterModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ContractorFilterModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ContractorFilterModel, $Out>
    implements ContractorFilterModelCopyWith<$R, ContractorFilterModel, $Out> {
  _ContractorFilterModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ContractorFilterModel> $mapper =
      ContractorFilterModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, ServiceType, ObjectCopyWith<$R, ServiceType, ServiceType>>
      get serviceType => ListCopyWith(
          $value.serviceType,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(serviceType: v));
  @override
  $R call({List<ServiceType>? serviceType}) => $apply(
      FieldCopyWithData({if (serviceType != null) #serviceType: serviceType}));
  @override
  ContractorFilterModel $make(CopyWithData data) => ContractorFilterModel(
      serviceType: data.get(#serviceType, or: $value.serviceType));

  @override
  ContractorFilterModelCopyWith<$R2, ContractorFilterModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _ContractorFilterModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ConstructionTeamFilterModelMapper
    extends ClassMapperBase<ConstructionTeamFilterModel> {
  ConstructionTeamFilterModelMapper._();

  static ConstructionTeamFilterModelMapper? _instance;
  static ConstructionTeamFilterModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = ConstructionTeamFilterModelMapper._());
      ServiceTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ConstructionTeamFilterModel';

  static List<ServiceType> _$serviceType(ConstructionTeamFilterModel v) =>
      v.serviceType;
  static const Field<ConstructionTeamFilterModel, List<ServiceType>>
      _f$serviceType =
      Field('serviceType', _$serviceType, opt: true, def: const []);

  @override
  final MappableFields<ConstructionTeamFilterModel> fields = const {
    #serviceType: _f$serviceType,
  };

  static ConstructionTeamFilterModel _instantiate(DecodingData data) {
    return ConstructionTeamFilterModel(serviceType: data.dec(_f$serviceType));
  }

  @override
  final Function instantiate = _instantiate;

  static ConstructionTeamFilterModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ConstructionTeamFilterModel>(map);
  }

  static ConstructionTeamFilterModel fromJson(String json) {
    return ensureInitialized().decodeJson<ConstructionTeamFilterModel>(json);
  }
}

mixin ConstructionTeamFilterModelMappable {
  String toJson() {
    return ConstructionTeamFilterModelMapper.ensureInitialized()
        .encodeJson<ConstructionTeamFilterModel>(
            this as ConstructionTeamFilterModel);
  }

  Map<String, dynamic> toMap() {
    return ConstructionTeamFilterModelMapper.ensureInitialized()
        .encodeMap<ConstructionTeamFilterModel>(
            this as ConstructionTeamFilterModel);
  }

  ConstructionTeamFilterModelCopyWith<ConstructionTeamFilterModel,
          ConstructionTeamFilterModel, ConstructionTeamFilterModel>
      get copyWith => _ConstructionTeamFilterModelCopyWithImpl<
              ConstructionTeamFilterModel, ConstructionTeamFilterModel>(
          this as ConstructionTeamFilterModel, $identity, $identity);
  @override
  String toString() {
    return ConstructionTeamFilterModelMapper.ensureInitialized()
        .stringifyValue(this as ConstructionTeamFilterModel);
  }

  @override
  bool operator ==(Object other) {
    return ConstructionTeamFilterModelMapper.ensureInitialized()
        .equalsValue(this as ConstructionTeamFilterModel, other);
  }

  @override
  int get hashCode {
    return ConstructionTeamFilterModelMapper.ensureInitialized()
        .hashValue(this as ConstructionTeamFilterModel);
  }
}

extension ConstructionTeamFilterModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ConstructionTeamFilterModel, $Out> {
  ConstructionTeamFilterModelCopyWith<$R, ConstructionTeamFilterModel, $Out>
      get $asConstructionTeamFilterModel => $base.as((v, t, t2) =>
          _ConstructionTeamFilterModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ConstructionTeamFilterModelCopyWith<
    $R,
    $In extends ConstructionTeamFilterModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, ServiceType, ObjectCopyWith<$R, ServiceType, ServiceType>>
      get serviceType;
  $R call({List<ServiceType>? serviceType});
  ConstructionTeamFilterModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ConstructionTeamFilterModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ConstructionTeamFilterModel, $Out>
    implements
        ConstructionTeamFilterModelCopyWith<$R, ConstructionTeamFilterModel,
            $Out> {
  _ConstructionTeamFilterModelCopyWithImpl(
      super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ConstructionTeamFilterModel> $mapper =
      ConstructionTeamFilterModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, ServiceType, ObjectCopyWith<$R, ServiceType, ServiceType>>
      get serviceType => ListCopyWith(
          $value.serviceType,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(serviceType: v));
  @override
  $R call({List<ServiceType>? serviceType}) => $apply(
      FieldCopyWithData({if (serviceType != null) #serviceType: serviceType}));
  @override
  ConstructionTeamFilterModel $make(CopyWithData data) =>
      ConstructionTeamFilterModel(
          serviceType: data.get(#serviceType, or: $value.serviceType));

  @override
  ConstructionTeamFilterModelCopyWith<$R2, ConstructionTeamFilterModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _ConstructionTeamFilterModelCopyWithImpl<$R2, $Out2>(
              $value, $cast, t);
}

class SupplierFilterModelMapper extends ClassMapperBase<SupplierFilterModel> {
  SupplierFilterModelMapper._();

  static SupplierFilterModelMapper? _instance;
  static SupplierFilterModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SupplierFilterModelMapper._());
      MaterialCategoryMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SupplierFilterModel';

  static List<MaterialCategory> _$materialCategory(SupplierFilterModel v) =>
      v.materialCategory;
  static const Field<SupplierFilterModel, List<MaterialCategory>>
      _f$materialCategory =
      Field('materialCategory', _$materialCategory, opt: true, def: const []);

  @override
  final MappableFields<SupplierFilterModel> fields = const {
    #materialCategory: _f$materialCategory,
  };

  static SupplierFilterModel _instantiate(DecodingData data) {
    return SupplierFilterModel(materialCategory: data.dec(_f$materialCategory));
  }

  @override
  final Function instantiate = _instantiate;

  static SupplierFilterModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SupplierFilterModel>(map);
  }

  static SupplierFilterModel fromJson(String json) {
    return ensureInitialized().decodeJson<SupplierFilterModel>(json);
  }
}

mixin SupplierFilterModelMappable {
  String toJson() {
    return SupplierFilterModelMapper.ensureInitialized()
        .encodeJson<SupplierFilterModel>(this as SupplierFilterModel);
  }

  Map<String, dynamic> toMap() {
    return SupplierFilterModelMapper.ensureInitialized()
        .encodeMap<SupplierFilterModel>(this as SupplierFilterModel);
  }

  SupplierFilterModelCopyWith<SupplierFilterModel, SupplierFilterModel,
      SupplierFilterModel> get copyWith => _SupplierFilterModelCopyWithImpl<
          SupplierFilterModel, SupplierFilterModel>(
      this as SupplierFilterModel, $identity, $identity);
  @override
  String toString() {
    return SupplierFilterModelMapper.ensureInitialized()
        .stringifyValue(this as SupplierFilterModel);
  }

  @override
  bool operator ==(Object other) {
    return SupplierFilterModelMapper.ensureInitialized()
        .equalsValue(this as SupplierFilterModel, other);
  }

  @override
  int get hashCode {
    return SupplierFilterModelMapper.ensureInitialized()
        .hashValue(this as SupplierFilterModel);
  }
}

extension SupplierFilterModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SupplierFilterModel, $Out> {
  SupplierFilterModelCopyWith<$R, SupplierFilterModel, $Out>
      get $asSupplierFilterModel => $base.as(
          (v, t, t2) => _SupplierFilterModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SupplierFilterModelCopyWith<$R, $In extends SupplierFilterModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, MaterialCategory,
          ObjectCopyWith<$R, MaterialCategory, MaterialCategory>>
      get materialCategory;
  $R call({List<MaterialCategory>? materialCategory});
  SupplierFilterModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SupplierFilterModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SupplierFilterModel, $Out>
    implements SupplierFilterModelCopyWith<$R, SupplierFilterModel, $Out> {
  _SupplierFilterModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SupplierFilterModel> $mapper =
      SupplierFilterModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, MaterialCategory,
          ObjectCopyWith<$R, MaterialCategory, MaterialCategory>>
      get materialCategory => ListCopyWith(
          $value.materialCategory,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(materialCategory: v));
  @override
  $R call({List<MaterialCategory>? materialCategory}) =>
      $apply(FieldCopyWithData(
          {if (materialCategory != null) #materialCategory: materialCategory}));
  @override
  SupplierFilterModel $make(CopyWithData data) => SupplierFilterModel(
      materialCategory:
          data.get(#materialCategory, or: $value.materialCategory));

  @override
  SupplierFilterModelCopyWith<$R2, SupplierFilterModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _SupplierFilterModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class SearchProfileModelMapper extends ClassMapperBase<SearchProfileModel> {
  SearchProfileModelMapper._();

  static SearchProfileModelMapper? _instance;
  static SearchProfileModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SearchProfileModelMapper._());
      CityMapper.ensureInitialized();
      ProfileTypeMapper.ensureInitialized();
      ArchitectFilterModelMapper.ensureInitialized();
      ContractorFilterModelMapper.ensureInitialized();
      ConstructionTeamFilterModelMapper.ensureInitialized();
      SupplierFilterModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SearchProfileModel';

  static String _$query(SearchProfileModel v) => v.query;
  static const Field<SearchProfileModel, String> _f$query =
      Field('query', _$query, opt: true, def: '');
  static List<City> _$cityList(SearchProfileModel v) => v.cityList;
  static const Field<SearchProfileModel, List<City>> _f$cityList =
      Field('cityList', _$cityList, opt: true, def: const []);
  static List<ProfileType> _$profileType(SearchProfileModel v) => v.profileType;
  static const Field<SearchProfileModel, List<ProfileType>> _f$profileType =
      Field('profileType', _$profileType, opt: true, def: const []);
  static int? _$minYearsOfExperience(SearchProfileModel v) =>
      v.minYearsOfExperience;
  static const Field<SearchProfileModel, int> _f$minYearsOfExperience =
      Field('minYearsOfExperience', _$minYearsOfExperience, opt: true);
  static ArchitectFilterModel? _$architectFilterModel(SearchProfileModel v) =>
      v.architectFilterModel;
  static const Field<SearchProfileModel, ArchitectFilterModel>
      _f$architectFilterModel =
      Field('architectFilterModel', _$architectFilterModel, opt: true);
  static ContractorFilterModel? _$contractorFilterModel(SearchProfileModel v) =>
      v.contractorFilterModel;
  static const Field<SearchProfileModel, ContractorFilterModel>
      _f$contractorFilterModel =
      Field('contractorFilterModel', _$contractorFilterModel, opt: true);
  static ConstructionTeamFilterModel? _$constructionTeamFilterModel(
          SearchProfileModel v) =>
      v.constructionTeamFilterModel;
  static const Field<SearchProfileModel, ConstructionTeamFilterModel>
      _f$constructionTeamFilterModel = Field(
          'constructionTeamFilterModel', _$constructionTeamFilterModel,
          opt: true);
  static SupplierFilterModel? _$supplierFilterModel(SearchProfileModel v) =>
      v.supplierFilterModel;
  static const Field<SearchProfileModel, SupplierFilterModel>
      _f$supplierFilterModel =
      Field('supplierFilterModel', _$supplierFilterModel, opt: true);

  @override
  final MappableFields<SearchProfileModel> fields = const {
    #query: _f$query,
    #cityList: _f$cityList,
    #profileType: _f$profileType,
    #minYearsOfExperience: _f$minYearsOfExperience,
    #architectFilterModel: _f$architectFilterModel,
    #contractorFilterModel: _f$contractorFilterModel,
    #constructionTeamFilterModel: _f$constructionTeamFilterModel,
    #supplierFilterModel: _f$supplierFilterModel,
  };

  static SearchProfileModel _instantiate(DecodingData data) {
    return SearchProfileModel(
        query: data.dec(_f$query),
        cityList: data.dec(_f$cityList),
        profileType: data.dec(_f$profileType),
        minYearsOfExperience: data.dec(_f$minYearsOfExperience),
        architectFilterModel: data.dec(_f$architectFilterModel),
        contractorFilterModel: data.dec(_f$contractorFilterModel),
        constructionTeamFilterModel: data.dec(_f$constructionTeamFilterModel),
        supplierFilterModel: data.dec(_f$supplierFilterModel));
  }

  @override
  final Function instantiate = _instantiate;

  static SearchProfileModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SearchProfileModel>(map);
  }

  static SearchProfileModel fromJson(String json) {
    return ensureInitialized().decodeJson<SearchProfileModel>(json);
  }
}

mixin SearchProfileModelMappable {
  String toJson() {
    return SearchProfileModelMapper.ensureInitialized()
        .encodeJson<SearchProfileModel>(this as SearchProfileModel);
  }

  Map<String, dynamic> toMap() {
    return SearchProfileModelMapper.ensureInitialized()
        .encodeMap<SearchProfileModel>(this as SearchProfileModel);
  }

  SearchProfileModelCopyWith<SearchProfileModel, SearchProfileModel,
          SearchProfileModel>
      get copyWith => _SearchProfileModelCopyWithImpl<SearchProfileModel,
          SearchProfileModel>(this as SearchProfileModel, $identity, $identity);
  @override
  String toString() {
    return SearchProfileModelMapper.ensureInitialized()
        .stringifyValue(this as SearchProfileModel);
  }

  @override
  bool operator ==(Object other) {
    return SearchProfileModelMapper.ensureInitialized()
        .equalsValue(this as SearchProfileModel, other);
  }

  @override
  int get hashCode {
    return SearchProfileModelMapper.ensureInitialized()
        .hashValue(this as SearchProfileModel);
  }
}

extension SearchProfileModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SearchProfileModel, $Out> {
  SearchProfileModelCopyWith<$R, SearchProfileModel, $Out>
      get $asSearchProfileModel => $base.as(
          (v, t, t2) => _SearchProfileModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SearchProfileModelCopyWith<$R, $In extends SearchProfileModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, City, ObjectCopyWith<$R, City, City>> get cityList;
  ListCopyWith<$R, ProfileType, ObjectCopyWith<$R, ProfileType, ProfileType>>
      get profileType;
  ArchitectFilterModelCopyWith<$R, ArchitectFilterModel, ArchitectFilterModel>?
      get architectFilterModel;
  ContractorFilterModelCopyWith<$R, ContractorFilterModel,
      ContractorFilterModel>? get contractorFilterModel;
  ConstructionTeamFilterModelCopyWith<$R, ConstructionTeamFilterModel,
      ConstructionTeamFilterModel>? get constructionTeamFilterModel;
  SupplierFilterModelCopyWith<$R, SupplierFilterModel, SupplierFilterModel>?
      get supplierFilterModel;
  $R call(
      {String? query,
      List<City>? cityList,
      List<ProfileType>? profileType,
      int? minYearsOfExperience,
      ArchitectFilterModel? architectFilterModel,
      ContractorFilterModel? contractorFilterModel,
      ConstructionTeamFilterModel? constructionTeamFilterModel,
      SupplierFilterModel? supplierFilterModel});
  SearchProfileModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SearchProfileModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SearchProfileModel, $Out>
    implements SearchProfileModelCopyWith<$R, SearchProfileModel, $Out> {
  _SearchProfileModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SearchProfileModel> $mapper =
      SearchProfileModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, City, ObjectCopyWith<$R, City, City>> get cityList =>
      ListCopyWith($value.cityList, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(cityList: v));
  @override
  ListCopyWith<$R, ProfileType, ObjectCopyWith<$R, ProfileType, ProfileType>>
      get profileType => ListCopyWith(
          $value.profileType,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(profileType: v));
  @override
  ArchitectFilterModelCopyWith<$R, ArchitectFilterModel, ArchitectFilterModel>?
      get architectFilterModel => $value.architectFilterModel?.copyWith
          .$chain((v) => call(architectFilterModel: v));
  @override
  ContractorFilterModelCopyWith<$R, ContractorFilterModel,
          ContractorFilterModel>?
      get contractorFilterModel => $value.contractorFilterModel?.copyWith
          .$chain((v) => call(contractorFilterModel: v));
  @override
  ConstructionTeamFilterModelCopyWith<$R, ConstructionTeamFilterModel,
          ConstructionTeamFilterModel>?
      get constructionTeamFilterModel =>
          $value.constructionTeamFilterModel?.copyWith
              .$chain((v) => call(constructionTeamFilterModel: v));
  @override
  SupplierFilterModelCopyWith<$R, SupplierFilterModel, SupplierFilterModel>?
      get supplierFilterModel => $value.supplierFilterModel?.copyWith
          .$chain((v) => call(supplierFilterModel: v));
  @override
  $R call(
          {String? query,
          List<City>? cityList,
          List<ProfileType>? profileType,
          Object? minYearsOfExperience = $none,
          Object? architectFilterModel = $none,
          Object? contractorFilterModel = $none,
          Object? constructionTeamFilterModel = $none,
          Object? supplierFilterModel = $none}) =>
      $apply(FieldCopyWithData({
        if (query != null) #query: query,
        if (cityList != null) #cityList: cityList,
        if (profileType != null) #profileType: profileType,
        if (minYearsOfExperience != $none)
          #minYearsOfExperience: minYearsOfExperience,
        if (architectFilterModel != $none)
          #architectFilterModel: architectFilterModel,
        if (contractorFilterModel != $none)
          #contractorFilterModel: contractorFilterModel,
        if (constructionTeamFilterModel != $none)
          #constructionTeamFilterModel: constructionTeamFilterModel,
        if (supplierFilterModel != $none)
          #supplierFilterModel: supplierFilterModel
      }));
  @override
  SearchProfileModel $make(CopyWithData data) => SearchProfileModel(
      query: data.get(#query, or: $value.query),
      cityList: data.get(#cityList, or: $value.cityList),
      profileType: data.get(#profileType, or: $value.profileType),
      minYearsOfExperience:
          data.get(#minYearsOfExperience, or: $value.minYearsOfExperience),
      architectFilterModel:
          data.get(#architectFilterModel, or: $value.architectFilterModel),
      contractorFilterModel:
          data.get(#contractorFilterModel, or: $value.contractorFilterModel),
      constructionTeamFilterModel: data.get(#constructionTeamFilterModel,
          or: $value.constructionTeamFilterModel),
      supplierFilterModel:
          data.get(#supplierFilterModel, or: $value.supplierFilterModel));

  @override
  SearchProfileModelCopyWith<$R2, SearchProfileModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SearchProfileModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
