// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'search_post_model.dart';

class SearchPostModelMapper extends ClassMapperBase<SearchPostModel> {
  SearchPostModelMapper._();

  static SearchPostModelMapper? _instance;
  static SearchPostModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SearchPostModelMapper._());
      CityMapper.ensureInitialized();
      JobPostingTypeMapper.ensureInitialized();
      ProfileTypeMapper.ensureInitialized();
      DomainMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SearchPostModel';

  static String _$query(SearchPostModel v) => v.query;
  static const Field<SearchPostModel, String> _f$query =
      Field('query', _$query, opt: true, def: '');
  static List<City> _$location(SearchPostModel v) => v.location;
  static const Field<SearchPostModel, List<City>> _f$location =
      Field('location', _$location, opt: true, def: const []);
  static List<JobPostingType> _$jobType(SearchPostModel v) => v.jobType;
  static const Field<SearchPostModel, List<JobPostingType>> _f$jobType =
      Field('jobType', _$jobType, opt: true, def: const []);
  static List<ProfileType> _$profileType(SearchPostModel v) => v.profileType;
  static const Field<SearchPostModel, List<ProfileType>> _f$profileType =
      Field('profileType', _$profileType, opt: true, def: const []);
  static List<Domain> _$domain(SearchPostModel v) => v.domain;
  static const Field<SearchPostModel, List<Domain>> _f$domain =
      Field('domain', _$domain, opt: true, def: const []);
  static int? _$budget(SearchPostModel v) => v.budget;
  static const Field<SearchPostModel, int> _f$budget =
      Field('budget', _$budget, opt: true);
  static DateTime? _$startDate(SearchPostModel v) => v.startDate;
  static const Field<SearchPostModel, DateTime> _f$startDate =
      Field('startDate', _$startDate, opt: true);
  static DateTime? _$endDate(SearchPostModel v) => v.endDate;
  static const Field<SearchPostModel, DateTime> _f$endDate =
      Field('endDate', _$endDate, opt: true);

  @override
  final MappableFields<SearchPostModel> fields = const {
    #query: _f$query,
    #location: _f$location,
    #jobType: _f$jobType,
    #profileType: _f$profileType,
    #domain: _f$domain,
    #budget: _f$budget,
    #startDate: _f$startDate,
    #endDate: _f$endDate,
  };

  static SearchPostModel _instantiate(DecodingData data) {
    return SearchPostModel(
        query: data.dec(_f$query),
        location: data.dec(_f$location),
        jobType: data.dec(_f$jobType),
        profileType: data.dec(_f$profileType),
        domain: data.dec(_f$domain),
        budget: data.dec(_f$budget),
        startDate: data.dec(_f$startDate),
        endDate: data.dec(_f$endDate));
  }

  @override
  final Function instantiate = _instantiate;

  static SearchPostModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SearchPostModel>(map);
  }

  static SearchPostModel fromJson(String json) {
    return ensureInitialized().decodeJson<SearchPostModel>(json);
  }
}

mixin SearchPostModelMappable {
  String toJson() {
    return SearchPostModelMapper.ensureInitialized()
        .encodeJson<SearchPostModel>(this as SearchPostModel);
  }

  Map<String, dynamic> toMap() {
    return SearchPostModelMapper.ensureInitialized()
        .encodeMap<SearchPostModel>(this as SearchPostModel);
  }

  SearchPostModelCopyWith<SearchPostModel, SearchPostModel, SearchPostModel>
      get copyWith =>
          _SearchPostModelCopyWithImpl<SearchPostModel, SearchPostModel>(
              this as SearchPostModel, $identity, $identity);
  @override
  String toString() {
    return SearchPostModelMapper.ensureInitialized()
        .stringifyValue(this as SearchPostModel);
  }

  @override
  bool operator ==(Object other) {
    return SearchPostModelMapper.ensureInitialized()
        .equalsValue(this as SearchPostModel, other);
  }

  @override
  int get hashCode {
    return SearchPostModelMapper.ensureInitialized()
        .hashValue(this as SearchPostModel);
  }
}

extension SearchPostModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SearchPostModel, $Out> {
  SearchPostModelCopyWith<$R, SearchPostModel, $Out> get $asSearchPostModel =>
      $base.as((v, t, t2) => _SearchPostModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SearchPostModelCopyWith<$R, $In extends SearchPostModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, City, ObjectCopyWith<$R, City, City>> get location;
  ListCopyWith<$R, JobPostingType,
      ObjectCopyWith<$R, JobPostingType, JobPostingType>> get jobType;
  ListCopyWith<$R, ProfileType, ObjectCopyWith<$R, ProfileType, ProfileType>>
      get profileType;
  ListCopyWith<$R, Domain, ObjectCopyWith<$R, Domain, Domain>> get domain;
  $R call(
      {String? query,
      List<City>? location,
      List<JobPostingType>? jobType,
      List<ProfileType>? profileType,
      List<Domain>? domain,
      int? budget,
      DateTime? startDate,
      DateTime? endDate});
  SearchPostModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SearchPostModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SearchPostModel, $Out>
    implements SearchPostModelCopyWith<$R, SearchPostModel, $Out> {
  _SearchPostModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SearchPostModel> $mapper =
      SearchPostModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, City, ObjectCopyWith<$R, City, City>> get location =>
      ListCopyWith($value.location, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(location: v));
  @override
  ListCopyWith<$R, JobPostingType,
          ObjectCopyWith<$R, JobPostingType, JobPostingType>>
      get jobType => ListCopyWith($value.jobType,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(jobType: v));
  @override
  ListCopyWith<$R, ProfileType, ObjectCopyWith<$R, ProfileType, ProfileType>>
      get profileType => ListCopyWith(
          $value.profileType,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(profileType: v));
  @override
  ListCopyWith<$R, Domain, ObjectCopyWith<$R, Domain, Domain>> get domain =>
      ListCopyWith($value.domain, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(domain: v));
  @override
  $R call(
          {String? query,
          List<City>? location,
          List<JobPostingType>? jobType,
          List<ProfileType>? profileType,
          List<Domain>? domain,
          Object? budget = $none,
          Object? startDate = $none,
          Object? endDate = $none}) =>
      $apply(FieldCopyWithData({
        if (query != null) #query: query,
        if (location != null) #location: location,
        if (jobType != null) #jobType: jobType,
        if (profileType != null) #profileType: profileType,
        if (domain != null) #domain: domain,
        if (budget != $none) #budget: budget,
        if (startDate != $none) #startDate: startDate,
        if (endDate != $none) #endDate: endDate
      }));
  @override
  SearchPostModel $make(CopyWithData data) => SearchPostModel(
      query: data.get(#query, or: $value.query),
      location: data.get(#location, or: $value.location),
      jobType: data.get(#jobType, or: $value.jobType),
      profileType: data.get(#profileType, or: $value.profileType),
      domain: data.get(#domain, or: $value.domain),
      budget: data.get(#budget, or: $value.budget),
      startDate: data.get(#startDate, or: $value.startDate),
      endDate: data.get(#endDate, or: $value.endDate));

  @override
  SearchPostModelCopyWith<$R2, SearchPostModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SearchPostModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
