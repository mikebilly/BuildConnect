// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'post_model.dart';

class PostModelMapper extends ClassMapperBase<PostModel> {
  PostModelMapper._();

  static PostModelMapper? _instance;
  static PostModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PostModelMapper._());
      JobPostingTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PostModel';

  static String? _$id(PostModel v) => v.id;
  static const Field<PostModel, String> _f$id = Field('id', _$id, opt: true);
  static String _$title(PostModel v) => v.title;
  static const Field<PostModel, String> _f$title = Field('title', _$title);
  static JobPostingType _$jobPostingType(PostModel v) => v.jobPostingType;
  static const Field<PostModel, JobPostingType> _f$jobPostingType =
      Field('jobPostingType', _$jobPostingType, key: r'job_posting_type');
  static String _$location(PostModel v) => v.location;
  static const Field<PostModel, String> _f$location =
      Field('location', _$location);
  static String _$description(PostModel v) => v.description;
  static const Field<PostModel, String> _f$description =
      Field('description', _$description);
  static double? _$budget(PostModel v) => v.budget;
  static const Field<PostModel, double> _f$budget =
      Field('budget', _$budget, opt: true);
  static DateTime? _$deadline(PostModel v) => v.deadline;
  static const Field<PostModel, DateTime> _f$deadline =
      Field('deadline', _$deadline, opt: true);
  static List<String>? _$requiredSkills(PostModel v) => v.requiredSkills;
  static const Field<PostModel, List<String>> _f$requiredSkills = Field(
      'requiredSkills', _$requiredSkills,
      key: r'required_skills', opt: true);
  static String _$authorId(PostModel v) => v.authorId;
  static const Field<PostModel, String> _f$authorId =
      Field('authorId', _$authorId, key: r'author_id');
  static DateTime? _$createdAt(PostModel v) => v.createdAt;
  static const Field<PostModel, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt, opt: true);

  @override
  final MappableFields<PostModel> fields = const {
    #id: _f$id,
    #title: _f$title,
    #jobPostingType: _f$jobPostingType,
    #location: _f$location,
    #description: _f$description,
    #budget: _f$budget,
    #deadline: _f$deadline,
    #requiredSkills: _f$requiredSkills,
    #authorId: _f$authorId,
    #createdAt: _f$createdAt,
  };

  static PostModel _instantiate(DecodingData data) {
    return PostModel(
        id: data.dec(_f$id),
        title: data.dec(_f$title),
        jobPostingType: data.dec(_f$jobPostingType),
        location: data.dec(_f$location),
        description: data.dec(_f$description),
        budget: data.dec(_f$budget),
        deadline: data.dec(_f$deadline),
        requiredSkills: data.dec(_f$requiredSkills),
        authorId: data.dec(_f$authorId),
        createdAt: data.dec(_f$createdAt));
  }

  @override
  final Function instantiate = _instantiate;

  static PostModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PostModel>(map);
  }

  static PostModel fromJson(String json) {
    return ensureInitialized().decodeJson<PostModel>(json);
  }
}

mixin PostModelMappable {
  String toJson() {
    return PostModelMapper.ensureInitialized()
        .encodeJson<PostModel>(this as PostModel);
  }

  Map<String, dynamic> toMap() {
    return PostModelMapper.ensureInitialized()
        .encodeMap<PostModel>(this as PostModel);
  }

  PostModelCopyWith<PostModel, PostModel, PostModel> get copyWith =>
      _PostModelCopyWithImpl<PostModel, PostModel>(
          this as PostModel, $identity, $identity);
  @override
  String toString() {
    return PostModelMapper.ensureInitialized()
        .stringifyValue(this as PostModel);
  }

  @override
  bool operator ==(Object other) {
    return PostModelMapper.ensureInitialized()
        .equalsValue(this as PostModel, other);
  }

  @override
  int get hashCode {
    return PostModelMapper.ensureInitialized().hashValue(this as PostModel);
  }
}

extension PostModelValueCopy<$R, $Out> on ObjectCopyWith<$R, PostModel, $Out> {
  PostModelCopyWith<$R, PostModel, $Out> get $asPostModel =>
      $base.as((v, t, t2) => _PostModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PostModelCopyWith<$R, $In extends PostModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
      get requiredSkills;
  $R call(
      {String? id,
      String? title,
      JobPostingType? jobPostingType,
      String? location,
      String? description,
      double? budget,
      DateTime? deadline,
      List<String>? requiredSkills,
      String? authorId,
      DateTime? createdAt});
  PostModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PostModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PostModel, $Out>
    implements PostModelCopyWith<$R, PostModel, $Out> {
  _PostModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PostModel> $mapper =
      PostModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
      get requiredSkills => $value.requiredSkills != null
          ? ListCopyWith(
              $value.requiredSkills!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(requiredSkills: v))
          : null;
  @override
  $R call(
          {Object? id = $none,
          String? title,
          JobPostingType? jobPostingType,
          String? location,
          String? description,
          Object? budget = $none,
          Object? deadline = $none,
          Object? requiredSkills = $none,
          String? authorId,
          Object? createdAt = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (title != null) #title: title,
        if (jobPostingType != null) #jobPostingType: jobPostingType,
        if (location != null) #location: location,
        if (description != null) #description: description,
        if (budget != $none) #budget: budget,
        if (deadline != $none) #deadline: deadline,
        if (requiredSkills != $none) #requiredSkills: requiredSkills,
        if (authorId != null) #authorId: authorId,
        if (createdAt != $none) #createdAt: createdAt
      }));
  @override
  PostModel $make(CopyWithData data) => PostModel(
      id: data.get(#id, or: $value.id),
      title: data.get(#title, or: $value.title),
      jobPostingType: data.get(#jobPostingType, or: $value.jobPostingType),
      location: data.get(#location, or: $value.location),
      description: data.get(#description, or: $value.description),
      budget: data.get(#budget, or: $value.budget),
      deadline: data.get(#deadline, or: $value.deadline),
      requiredSkills: data.get(#requiredSkills, or: $value.requiredSkills),
      authorId: data.get(#authorId, or: $value.authorId),
      createdAt: data.get(#createdAt, or: $value.createdAt));

  @override
  PostModelCopyWith<$R2, PostModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PostModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
