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
    }
    return _instance!;
  }

  @override
  final String id = 'Message';

  static String _$id(Message v) => v.id;
  static const Field<Message, String> _f$id = Field('id', _$id);
  static String _$content(Message v) => v.content;
  static const Field<Message, String> _f$content = Field('content', _$content);
  static bool _$markAsRead(Message v) => v.markAsRead;
  static const Field<Message, bool> _f$markAsRead =
      Field('markAsRead', _$markAsRead);
  static String _$userFrom_id(Message v) => v.userFrom_id;
  static const Field<Message, String> _f$userFrom_id =
      Field('userFrom_id', _$userFrom_id);
  static String _$userTo_id(Message v) => v.userTo_id;
  static const Field<Message, String> _f$userTo_id =
      Field('userTo_id', _$userTo_id);
  static DateTime _$createAt(Message v) => v.createAt;
  static const Field<Message, DateTime> _f$createAt =
      Field('createAt', _$createAt);
  static bool _$isMine(Message v) => v.isMine;
  static const Field<Message, bool> _f$isMine = Field('isMine', _$isMine);

  @override
  final MappableFields<Message> fields = const {
    #id: _f$id,
    #content: _f$content,
    #markAsRead: _f$markAsRead,
    #userFrom_id: _f$userFrom_id,
    #userTo_id: _f$userTo_id,
    #createAt: _f$createAt,
    #isMine: _f$isMine,
  };

  static Message _instantiate(DecodingData data) {
    return Message(
        id: data.dec(_f$id),
        content: data.dec(_f$content),
        markAsRead: data.dec(_f$markAsRead),
        userFrom_id: data.dec(_f$userFrom_id),
        userTo_id: data.dec(_f$userTo_id),
        createAt: data.dec(_f$createAt),
        isMine: data.dec(_f$isMine));
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
      bool? isMine});
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
          String? content,
          bool? markAsRead,
          String? userFrom_id,
          String? userTo_id,
          DateTime? createAt,
          bool? isMine}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (content != null) #content: content,
        if (markAsRead != null) #markAsRead: markAsRead,
        if (userFrom_id != null) #userFrom_id: userFrom_id,
        if (userTo_id != null) #userTo_id: userTo_id,
        if (createAt != null) #createAt: createAt,
        if (isMine != null) #isMine: isMine
      }));
  @override
  Message $make(CopyWithData data) => Message(
      id: data.get(#id, or: $value.id),
      content: data.get(#content, or: $value.content),
      markAsRead: data.get(#markAsRead, or: $value.markAsRead),
      userFrom_id: data.get(#userFrom_id, or: $value.userFrom_id),
      userTo_id: data.get(#userTo_id, or: $value.userTo_id),
      createAt: data.get(#createAt, or: $value.createAt),
      isMine: data.get(#isMine, or: $value.isMine));

  @override
  MessageCopyWith<$R2, Message, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MessageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
