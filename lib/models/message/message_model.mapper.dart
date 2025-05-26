// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'message_model.dart';

class MessageMapper extends ClassMapperBase<Message> {
  MessageMapper._();

  static MessageMapper? _instance;
  static MessageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MessageMapper._());
      AttachmentTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Message';

  static String _$id(Message v) => v.id;
  static const Field<Message, String> _f$id = Field('id', _$id);
  static String? _$content(Message v) => v.content;
  static const Field<Message, String> _f$content = Field('content', _$content);
  static bool _$markAsRead(Message v) => v.markAsRead;
  static const Field<Message, bool> _f$markAsRead =
      Field('markAsRead', _$markAsRead, key: r'mark_as_read');
  static String _$userFrom_id(Message v) => v.userFrom_id;
  static const Field<Message, String> _f$userFrom_id =
      Field('userFrom_id', _$userFrom_id, key: r'user_from');
  static String _$userTo_id(Message v) => v.userTo_id;
  static const Field<Message, String> _f$userTo_id =
      Field('userTo_id', _$userTo_id, key: r'user_to');
  static DateTime _$createAt(Message v) => v.createAt;
  static const Field<Message, DateTime> _f$createAt =
      Field('createAt', _$createAt, key: r'created_at');
  static AttachmentType _$attachmentType(Message v) => v.attachmentType;
  static const Field<Message, AttachmentType> _f$attachmentType = Field(
      'attachmentType', _$attachmentType,
      key: r'attachment_type', opt: true, def: AttachmentType.none);
  static String? _$attachmentUrl(Message v) => v.attachmentUrl;
  static const Field<Message, String> _f$attachmentUrl = Field(
      'attachmentUrl', _$attachmentUrl,
      key: r'attachment_url', opt: true);
  static String? _$attachmentName(Message v) => v.attachmentName;
  static const Field<Message, String> _f$attachmentName = Field(
      'attachmentName', _$attachmentName,
      key: r'attachment_name', opt: true);
  static int? _$attachmentSize(Message v) => v.attachmentSize;
  static const Field<Message, int> _f$attachmentSize = Field(
      'attachmentSize', _$attachmentSize,
      key: r'attachment_size', opt: true);
  static String? _$attachmentMimeType(Message v) => v.attachmentMimeType;
  static const Field<Message, String> _f$attachmentMimeType = Field(
      'attachmentMimeType', _$attachmentMimeType,
      key: r'attachment_mime_type', opt: true);

  @override
  final MappableFields<Message> fields = const {
    #id: _f$id,
    #content: _f$content,
    #markAsRead: _f$markAsRead,
    #userFrom_id: _f$userFrom_id,
    #userTo_id: _f$userTo_id,
    #createAt: _f$createAt,
    #attachmentType: _f$attachmentType,
    #attachmentUrl: _f$attachmentUrl,
    #attachmentName: _f$attachmentName,
    #attachmentSize: _f$attachmentSize,
    #attachmentMimeType: _f$attachmentMimeType,
  };

  static Message _instantiate(DecodingData data) {
    return Message(
        id: data.dec(_f$id),
        content: data.dec(_f$content),
        markAsRead: data.dec(_f$markAsRead),
        userFrom_id: data.dec(_f$userFrom_id),
        userTo_id: data.dec(_f$userTo_id),
        createAt: data.dec(_f$createAt),
        attachmentType: data.dec(_f$attachmentType),
        attachmentUrl: data.dec(_f$attachmentUrl),
        attachmentName: data.dec(_f$attachmentName),
        attachmentSize: data.dec(_f$attachmentSize),
        attachmentMimeType: data.dec(_f$attachmentMimeType));
  }

  @override
  final Function instantiate = _instantiate;

  static Message fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Message>(map);
  }

  static Message fromJson(String json) {
    return ensureInitialized().decodeJson<Message>(json);
  }
}

mixin MessageMappable {
  String toJson() {
    return MessageMapper.ensureInitialized()
        .encodeJson<Message>(this as Message);
  }

  Map<String, dynamic> toMap() {
    return MessageMapper.ensureInitialized()
        .encodeMap<Message>(this as Message);
  }

  MessageCopyWith<Message, Message, Message> get copyWith =>
      _MessageCopyWithImpl<Message, Message>(
          this as Message, $identity, $identity);
  @override
  String toString() {
    return MessageMapper.ensureInitialized().stringifyValue(this as Message);
  }

  @override
  bool operator ==(Object other) {
    return MessageMapper.ensureInitialized()
        .equalsValue(this as Message, other);
  }

  @override
  int get hashCode {
    return MessageMapper.ensureInitialized().hashValue(this as Message);
  }
}

extension MessageValueCopy<$R, $Out> on ObjectCopyWith<$R, Message, $Out> {
  MessageCopyWith<$R, Message, $Out> get $asMessage =>
      $base.as((v, t, t2) => _MessageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MessageCopyWith<$R, $In extends Message, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      String? content,
      bool? markAsRead,
      String? userFrom_id,
      String? userTo_id,
      DateTime? createAt,
      AttachmentType? attachmentType,
      String? attachmentUrl,
      String? attachmentName,
      int? attachmentSize,
      String? attachmentMimeType});
  MessageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MessageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Message, $Out>
    implements MessageCopyWith<$R, Message, $Out> {
  _MessageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Message> $mapper =
      MessageMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          Object? content = $none,
          bool? markAsRead,
          String? userFrom_id,
          String? userTo_id,
          DateTime? createAt,
          AttachmentType? attachmentType,
          Object? attachmentUrl = $none,
          Object? attachmentName = $none,
          Object? attachmentSize = $none,
          Object? attachmentMimeType = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (content != $none) #content: content,
        if (markAsRead != null) #markAsRead: markAsRead,
        if (userFrom_id != null) #userFrom_id: userFrom_id,
        if (userTo_id != null) #userTo_id: userTo_id,
        if (createAt != null) #createAt: createAt,
        if (attachmentType != null) #attachmentType: attachmentType,
        if (attachmentUrl != $none) #attachmentUrl: attachmentUrl,
        if (attachmentName != $none) #attachmentName: attachmentName,
        if (attachmentSize != $none) #attachmentSize: attachmentSize,
        if (attachmentMimeType != $none) #attachmentMimeType: attachmentMimeType
      }));
  @override
  Message $make(CopyWithData data) => Message(
      id: data.get(#id, or: $value.id),
      content: data.get(#content, or: $value.content),
      markAsRead: data.get(#markAsRead, or: $value.markAsRead),
      userFrom_id: data.get(#userFrom_id, or: $value.userFrom_id),
      userTo_id: data.get(#userTo_id, or: $value.userTo_id),
      createAt: data.get(#createAt, or: $value.createAt),
      attachmentType: data.get(#attachmentType, or: $value.attachmentType),
      attachmentUrl: data.get(#attachmentUrl, or: $value.attachmentUrl),
      attachmentName: data.get(#attachmentName, or: $value.attachmentName),
      attachmentSize: data.get(#attachmentSize, or: $value.attachmentSize),
      attachmentMimeType:
          data.get(#attachmentMimeType, or: $value.attachmentMimeType));

  @override
  MessageCopyWith<$R2, Message, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MessageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
