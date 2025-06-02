// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'notification_model.dart';

class NotificationModelMapper extends ClassMapperBase<NotificationModel> {
  NotificationModelMapper._();

  static NotificationModelMapper? _instance;
  static NotificationModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NotificationModelMapper._());
      NotificationTypeMapper.ensureInitialized();
      RelatedEntityTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'NotificationModel';

  static String _$id(NotificationModel v) => v.id;
  static const Field<NotificationModel, String> _f$id = Field('id', _$id);
  static String _$userId(NotificationModel v) => v.userId;
  static const Field<NotificationModel, String> _f$userId =
      Field('userId', _$userId, key: r'user_id');
  static NotificationType _$type(NotificationModel v) => v.type;
  static const Field<NotificationModel, NotificationType> _f$type =
      Field('type', _$type);
  static String? _$title(NotificationModel v) => v.title;
  static const Field<NotificationModel, String> _f$title =
      Field('title', _$title, opt: true);
  static String _$body(NotificationModel v) => v.body;
  static const Field<NotificationModel, String> _f$body = Field('body', _$body);
  static RelatedEntityType? _$relatedEntityType(NotificationModel v) =>
      v.relatedEntityType;
  static const Field<NotificationModel, RelatedEntityType>
      _f$relatedEntityType = Field('relatedEntityType', _$relatedEntityType,
          key: r'related_entity_type', opt: true);
  static String? _$relatedEntityId(NotificationModel v) => v.relatedEntityId;
  static const Field<NotificationModel, String> _f$relatedEntityId = Field(
      'relatedEntityId', _$relatedEntityId,
      key: r'related_entity_id', opt: true);
  static String? _$actorId(NotificationModel v) => v.actorId;
  static const Field<NotificationModel, String> _f$actorId =
      Field('actorId', _$actorId, key: r'actor_id', opt: true);
  static String? _$actorDisplayName(NotificationModel v) => v.actorDisplayName;
  static const Field<NotificationModel, String> _f$actorDisplayName = Field(
      'actorDisplayName', _$actorDisplayName,
      key: r'actor_display_name', opt: true);
  static String? _$actorAvatarUrl(NotificationModel v) => v.actorAvatarUrl;
  static const Field<NotificationModel, String> _f$actorAvatarUrl = Field(
      'actorAvatarUrl', _$actorAvatarUrl,
      key: r'actor_avatar_url', opt: true);
  static bool _$isRead(NotificationModel v) => v.isRead;
  static const Field<NotificationModel, bool> _f$isRead =
      Field('isRead', _$isRead, key: r'is_read');
  static DateTime _$createdAt(NotificationModel v) => v.createdAt;
  static const Field<NotificationModel, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt, key: r'created_at');

  @override
  final MappableFields<NotificationModel> fields = const {
    #id: _f$id,
    #userId: _f$userId,
    #type: _f$type,
    #title: _f$title,
    #body: _f$body,
    #relatedEntityType: _f$relatedEntityType,
    #relatedEntityId: _f$relatedEntityId,
    #actorId: _f$actorId,
    #actorDisplayName: _f$actorDisplayName,
    #actorAvatarUrl: _f$actorAvatarUrl,
    #isRead: _f$isRead,
    #createdAt: _f$createdAt,
  };

  static NotificationModel _instantiate(DecodingData data) {
    return NotificationModel(
        id: data.dec(_f$id),
        userId: data.dec(_f$userId),
        type: data.dec(_f$type),
        title: data.dec(_f$title),
        body: data.dec(_f$body),
        relatedEntityType: data.dec(_f$relatedEntityType),
        relatedEntityId: data.dec(_f$relatedEntityId),
        actorId: data.dec(_f$actorId),
        actorDisplayName: data.dec(_f$actorDisplayName),
        actorAvatarUrl: data.dec(_f$actorAvatarUrl),
        isRead: data.dec(_f$isRead),
        createdAt: data.dec(_f$createdAt));
  }

  @override
  final Function instantiate = _instantiate;

  static NotificationModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NotificationModel>(map);
  }

  static NotificationModel fromJson(String json) {
    return ensureInitialized().decodeJson<NotificationModel>(json);
  }
}

mixin NotificationModelMappable {
  String toJson() {
    return NotificationModelMapper.ensureInitialized()
        .encodeJson<NotificationModel>(this as NotificationModel);
  }

  Map<String, dynamic> toMap() {
    return NotificationModelMapper.ensureInitialized()
        .encodeMap<NotificationModel>(this as NotificationModel);
  }

  NotificationModelCopyWith<NotificationModel, NotificationModel,
          NotificationModel>
      get copyWith =>
          _NotificationModelCopyWithImpl<NotificationModel, NotificationModel>(
              this as NotificationModel, $identity, $identity);
  @override
  String toString() {
    return NotificationModelMapper.ensureInitialized()
        .stringifyValue(this as NotificationModel);
  }

  @override
  bool operator ==(Object other) {
    return NotificationModelMapper.ensureInitialized()
        .equalsValue(this as NotificationModel, other);
  }

  @override
  int get hashCode {
    return NotificationModelMapper.ensureInitialized()
        .hashValue(this as NotificationModel);
  }
}

extension NotificationModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NotificationModel, $Out> {
  NotificationModelCopyWith<$R, NotificationModel, $Out>
      get $asNotificationModel => $base
          .as((v, t, t2) => _NotificationModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class NotificationModelCopyWith<$R, $In extends NotificationModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      String? userId,
      NotificationType? type,
      String? title,
      String? body,
      RelatedEntityType? relatedEntityType,
      String? relatedEntityId,
      String? actorId,
      String? actorDisplayName,
      String? actorAvatarUrl,
      bool? isRead,
      DateTime? createdAt});
  NotificationModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _NotificationModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NotificationModel, $Out>
    implements NotificationModelCopyWith<$R, NotificationModel, $Out> {
  _NotificationModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NotificationModel> $mapper =
      NotificationModelMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          String? userId,
          NotificationType? type,
          Object? title = $none,
          String? body,
          Object? relatedEntityType = $none,
          Object? relatedEntityId = $none,
          Object? actorId = $none,
          Object? actorDisplayName = $none,
          Object? actorAvatarUrl = $none,
          bool? isRead,
          DateTime? createdAt}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (userId != null) #userId: userId,
        if (type != null) #type: type,
        if (title != $none) #title: title,
        if (body != null) #body: body,
        if (relatedEntityType != $none) #relatedEntityType: relatedEntityType,
        if (relatedEntityId != $none) #relatedEntityId: relatedEntityId,
        if (actorId != $none) #actorId: actorId,
        if (actorDisplayName != $none) #actorDisplayName: actorDisplayName,
        if (actorAvatarUrl != $none) #actorAvatarUrl: actorAvatarUrl,
        if (isRead != null) #isRead: isRead,
        if (createdAt != null) #createdAt: createdAt
      }));
  @override
  NotificationModel $make(CopyWithData data) => NotificationModel(
      id: data.get(#id, or: $value.id),
      userId: data.get(#userId, or: $value.userId),
      type: data.get(#type, or: $value.type),
      title: data.get(#title, or: $value.title),
      body: data.get(#body, or: $value.body),
      relatedEntityType:
          data.get(#relatedEntityType, or: $value.relatedEntityType),
      relatedEntityId: data.get(#relatedEntityId, or: $value.relatedEntityId),
      actorId: data.get(#actorId, or: $value.actorId),
      actorDisplayName:
          data.get(#actorDisplayName, or: $value.actorDisplayName),
      actorAvatarUrl: data.get(#actorAvatarUrl, or: $value.actorAvatarUrl),
      isRead: data.get(#isRead, or: $value.isRead),
      createdAt: data.get(#createdAt, or: $value.createdAt));

  @override
  NotificationModelCopyWith<$R2, NotificationModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NotificationModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
