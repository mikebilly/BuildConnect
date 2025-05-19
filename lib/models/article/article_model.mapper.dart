// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'article_model.dart';

class ArticleModelMapper extends ClassMapperBase<ArticleModel> {
  ArticleModelMapper._();

  static ArticleModelMapper? _instance;
  static ArticleModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ArticleModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ArticleModel';

  static String _$title(ArticleModel v) => v.title;
  static const Field<ArticleModel, String> _f$title = Field('title', _$title);
  static String _$description(ArticleModel v) => v.description;
  static const Field<ArticleModel, String> _f$description =
      Field('description', _$description);
  static String _$url(ArticleModel v) => v.url;
  static const Field<ArticleModel, String> _f$url = Field('url', _$url);
  static String _$imageUrl(ArticleModel v) => v.imageUrl;
  static const Field<ArticleModel, String> _f$imageUrl =
      Field('imageUrl', _$imageUrl);
  static String _$sourceName(ArticleModel v) => v.sourceName;
  static const Field<ArticleModel, String> _f$sourceName =
      Field('sourceName', _$sourceName);
  static DateTime _$publishedAt(ArticleModel v) => v.publishedAt;
  static const Field<ArticleModel, DateTime> _f$publishedAt =
      Field('publishedAt', _$publishedAt);

  @override
  final MappableFields<ArticleModel> fields = const {
    #title: _f$title,
    #description: _f$description,
    #url: _f$url,
    #imageUrl: _f$imageUrl,
    #sourceName: _f$sourceName,
    #publishedAt: _f$publishedAt,
  };

  static ArticleModel _instantiate(DecodingData data) {
    return ArticleModel(
        title: data.dec(_f$title),
        description: data.dec(_f$description),
        url: data.dec(_f$url),
        imageUrl: data.dec(_f$imageUrl),
        sourceName: data.dec(_f$sourceName),
        publishedAt: data.dec(_f$publishedAt));
  }

  @override
  final Function instantiate = _instantiate;

  static ArticleModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ArticleModel>(map);
  }

  static ArticleModel fromJson(String json) {
    return ensureInitialized().decodeJson<ArticleModel>(json);
  }
}

mixin ArticleModelMappable {
  String toJson() {
    return ArticleModelMapper.ensureInitialized()
        .encodeJson<ArticleModel>(this as ArticleModel);
  }

  Map<String, dynamic> toMap() {
    return ArticleModelMapper.ensureInitialized()
        .encodeMap<ArticleModel>(this as ArticleModel);
  }

  ArticleModelCopyWith<ArticleModel, ArticleModel, ArticleModel> get copyWith =>
      _ArticleModelCopyWithImpl<ArticleModel, ArticleModel>(
          this as ArticleModel, $identity, $identity);
  @override
  String toString() {
    return ArticleModelMapper.ensureInitialized()
        .stringifyValue(this as ArticleModel);
  }

  @override
  bool operator ==(Object other) {
    return ArticleModelMapper.ensureInitialized()
        .equalsValue(this as ArticleModel, other);
  }

  @override
  int get hashCode {
    return ArticleModelMapper.ensureInitialized()
        .hashValue(this as ArticleModel);
  }
}

extension ArticleModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ArticleModel, $Out> {
  ArticleModelCopyWith<$R, ArticleModel, $Out> get $asArticleModel =>
      $base.as((v, t, t2) => _ArticleModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ArticleModelCopyWith<$R, $In extends ArticleModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? title,
      String? description,
      String? url,
      String? imageUrl,
      String? sourceName,
      DateTime? publishedAt});
  ArticleModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ArticleModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ArticleModel, $Out>
    implements ArticleModelCopyWith<$R, ArticleModel, $Out> {
  _ArticleModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ArticleModel> $mapper =
      ArticleModelMapper.ensureInitialized();
  @override
  $R call(
          {String? title,
          String? description,
          String? url,
          String? imageUrl,
          String? sourceName,
          DateTime? publishedAt}) =>
      $apply(FieldCopyWithData({
        if (title != null) #title: title,
        if (description != null) #description: description,
        if (url != null) #url: url,
        if (imageUrl != null) #imageUrl: imageUrl,
        if (sourceName != null) #sourceName: sourceName,
        if (publishedAt != null) #publishedAt: publishedAt
      }));
  @override
  ArticleModel $make(CopyWithData data) => ArticleModel(
      title: data.get(#title, or: $value.title),
      description: data.get(#description, or: $value.description),
      url: data.get(#url, or: $value.url),
      imageUrl: data.get(#imageUrl, or: $value.imageUrl),
      sourceName: data.get(#sourceName, or: $value.sourceName),
      publishedAt: data.get(#publishedAt, or: $value.publishedAt));

  @override
  ArticleModelCopyWith<$R2, ArticleModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ArticleModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
