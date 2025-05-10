// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'search_profile_model.dart';

class SearchProfileModelMapper extends ClassMapperBase<SearchProfileModel> {
  SearchProfileModelMapper._();

  static SearchProfileModelMapper? _instance;
  static SearchProfileModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SearchProfileModelMapper._());
      CityMapper.ensureInitialized();
      ProfileTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SearchProfileModel';

  static String? _$query(SearchProfileModel v) => v.query;
  static const Field<SearchProfileModel, String> _f$query =
      Field('query', _$query, opt: true);
  static List<City>? _$cityList(SearchProfileModel v) => v.cityList;
  static const Field<SearchProfileModel, List<City>> _f$cityList =
      Field('cityList', _$cityList, opt: true, def: const []);
  static List<ProfileType>? _$profileType(SearchProfileModel v) =>
      v.profileType;
  static const Field<SearchProfileModel, List<ProfileType>> _f$profileType =
      Field('profileType', _$profileType, opt: true);
  static int? _$minYearsOfExperience(SearchProfileModel v) =>
      v.minYearsOfExperience;
  static const Field<SearchProfileModel, int> _f$minYearsOfExperience =
      Field('minYearsOfExperience', _$minYearsOfExperience, opt: true);

  @override
  final MappableFields<SearchProfileModel> fields = const {
    #query: _f$query,
    #cityList: _f$cityList,
    #profileType: _f$profileType,
    #minYearsOfExperience: _f$minYearsOfExperience,
  };

  static SearchProfileModel _instantiate(DecodingData data) {
    return SearchProfileModel(
        query: data.dec(_f$query),
        cityList: data.dec(_f$cityList),
        profileType: data.dec(_f$profileType),
        minYearsOfExperience: data.dec(_f$minYearsOfExperience));
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
  ListCopyWith<$R, City, ObjectCopyWith<$R, City, City>>? get cityList;
  ListCopyWith<$R, ProfileType, ObjectCopyWith<$R, ProfileType, ProfileType>>?
      get profileType;
  $R call(
      {String? query,
      List<City>? cityList,
      List<ProfileType>? profileType,
      int? minYearsOfExperience});
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
  ListCopyWith<$R, City, ObjectCopyWith<$R, City, City>>? get cityList =>
      $value.cityList != null
          ? ListCopyWith(
              $value.cityList!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(cityList: v))
          : null;
  @override
  ListCopyWith<$R, ProfileType, ObjectCopyWith<$R, ProfileType, ProfileType>>?
      get profileType => $value.profileType != null
          ? ListCopyWith(
              $value.profileType!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(profileType: v))
          : null;
  @override
  $R call(
          {Object? query = $none,
          Object? cityList = $none,
          Object? profileType = $none,
          Object? minYearsOfExperience = $none}) =>
      $apply(FieldCopyWithData({
        if (query != $none) #query: query,
        if (cityList != $none) #cityList: cityList,
        if (profileType != $none) #profileType: profileType,
        if (minYearsOfExperience != $none)
          #minYearsOfExperience: minYearsOfExperience
      }));
  @override
  SearchProfileModel $make(CopyWithData data) => SearchProfileModel(
      query: data.get(#query, or: $value.query),
      cityList: data.get(#cityList, or: $value.cityList),
      profileType: data.get(#profileType, or: $value.profileType),
      minYearsOfExperience:
          data.get(#minYearsOfExperience, or: $value.minYearsOfExperience));

  @override
  SearchProfileModelCopyWith<$R2, SearchProfileModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SearchProfileModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
