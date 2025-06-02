// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'conversation_model.dart';

class ConversationModelMapper extends ClassMapperBase<ConversationModel> {
  ConversationModelMapper._();

  static ConversationModelMapper? _instance;
  static ConversationModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ConversationModelMapper._());
      MessageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ConversationModel';

  static String _$partnerId(ConversationModel v) => v.partnerId;
  static const Field<ConversationModel, String> _f$partnerId =
      Field('partnerId', _$partnerId);
  static String _$partnerDisplayName(ConversationModel v) =>
      v.partnerDisplayName;
  static const Field<ConversationModel, String> _f$partnerDisplayName =
      Field('partnerDisplayName', _$partnerDisplayName);
  static String? _$partnerAvatarUrl(ConversationModel v) => v.partnerAvatarUrl;
  static const Field<ConversationModel, String> _f$partnerAvatarUrl =
      Field('partnerAvatarUrl', _$partnerAvatarUrl, opt: true);
  static Message _$lastMessage(ConversationModel v) => v.lastMessage;
  static const Field<ConversationModel, Message> _f$lastMessage =
      Field('lastMessage', _$lastMessage);
  static int _$unreadCount(ConversationModel v) => v.unreadCount;
  static const Field<ConversationModel, int> _f$unreadCount =
      Field('unreadCount', _$unreadCount);

  @override
  final MappableFields<ConversationModel> fields = const {
    #partnerId: _f$partnerId,
    #partnerDisplayName: _f$partnerDisplayName,
    #partnerAvatarUrl: _f$partnerAvatarUrl,
    #lastMessage: _f$lastMessage,
    #unreadCount: _f$unreadCount,
  };

  static ConversationModel _instantiate(DecodingData data) {
    return ConversationModel(
        partnerId: data.dec(_f$partnerId),
        partnerDisplayName: data.dec(_f$partnerDisplayName),
        partnerAvatarUrl: data.dec(_f$partnerAvatarUrl),
        lastMessage: data.dec(_f$lastMessage),
        unreadCount: data.dec(_f$unreadCount));
  }

  @override
  final Function instantiate = _instantiate;

  static ConversationModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ConversationModel>(map);
  }

  static ConversationModel fromJson(String json) {
    return ensureInitialized().decodeJson<ConversationModel>(json);
  }
}

mixin ConversationModelMappable {
  String toJson() {
    return ConversationModelMapper.ensureInitialized()
        .encodeJson<ConversationModel>(this as ConversationModel);
  }

  Map<String, dynamic> toMap() {
    return ConversationModelMapper.ensureInitialized()
        .encodeMap<ConversationModel>(this as ConversationModel);
  }

  ConversationModelCopyWith<ConversationModel, ConversationModel,
          ConversationModel>
      get copyWith =>
          _ConversationModelCopyWithImpl<ConversationModel, ConversationModel>(
              this as ConversationModel, $identity, $identity);
  @override
  String toString() {
    return ConversationModelMapper.ensureInitialized()
        .stringifyValue(this as ConversationModel);
  }

  @override
  bool operator ==(Object other) {
    return ConversationModelMapper.ensureInitialized()
        .equalsValue(this as ConversationModel, other);
  }

  @override
  int get hashCode {
    return ConversationModelMapper.ensureInitialized()
        .hashValue(this as ConversationModel);
  }
}

extension ConversationModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ConversationModel, $Out> {
  ConversationModelCopyWith<$R, ConversationModel, $Out>
      get $asConversationModel => $base
          .as((v, t, t2) => _ConversationModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ConversationModelCopyWith<$R, $In extends ConversationModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  MessageCopyWith<$R, Message, Message> get lastMessage;
  $R call(
      {String? partnerId,
      String? partnerDisplayName,
      String? partnerAvatarUrl,
      Message? lastMessage,
      int? unreadCount});
  ConversationModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ConversationModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ConversationModel, $Out>
    implements ConversationModelCopyWith<$R, ConversationModel, $Out> {
  _ConversationModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ConversationModel> $mapper =
      ConversationModelMapper.ensureInitialized();
  @override
  MessageCopyWith<$R, Message, Message> get lastMessage =>
      $value.lastMessage.copyWith.$chain((v) => call(lastMessage: v));
  @override
  $R call(
          {String? partnerId,
          String? partnerDisplayName,
          Object? partnerAvatarUrl = $none,
          Message? lastMessage,
          int? unreadCount}) =>
      $apply(FieldCopyWithData({
        if (partnerId != null) #partnerId: partnerId,
        if (partnerDisplayName != null) #partnerDisplayName: partnerDisplayName,
        if (partnerAvatarUrl != $none) #partnerAvatarUrl: partnerAvatarUrl,
        if (lastMessage != null) #lastMessage: lastMessage,
        if (unreadCount != null) #unreadCount: unreadCount
      }));
  @override
  ConversationModel $make(CopyWithData data) => ConversationModel(
      partnerId: data.get(#partnerId, or: $value.partnerId),
      partnerDisplayName:
          data.get(#partnerDisplayName, or: $value.partnerDisplayName),
      partnerAvatarUrl:
          data.get(#partnerAvatarUrl, or: $value.partnerAvatarUrl),
      lastMessage: data.get(#lastMessage, or: $value.lastMessage),
      unreadCount: data.get(#unreadCount, or: $value.unreadCount));

  @override
  ConversationModelCopyWith<$R2, ConversationModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ConversationModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
