// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'shared_models.dart';

class ContactMapper extends ClassMapperBase<Contact> {
  ContactMapper._();

  static ContactMapper? _instance;
  static ContactMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContactMapper._());
      ContactTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Contact';

  static ContactType _$type(Contact v) => v.type;
  static const Field<Contact, ContactType> _f$type = Field('type', _$type);
  static String _$value(Contact v) => v.value;
  static const Field<Contact, String> _f$value = Field('value', _$value);

  @override
  final MappableFields<Contact> fields = const {
    #type: _f$type,
    #value: _f$value,
  };

  static Contact _instantiate(DecodingData data) {
    return Contact(type: data.dec(_f$type), value: data.dec(_f$value));
  }

  @override
  final Function instantiate = _instantiate;

  static Contact fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Contact>(map);
  }

  static Contact fromJson(String json) {
    return ensureInitialized().decodeJson<Contact>(json);
  }
}

mixin ContactMappable {
  String toJson() {
    return ContactMapper.ensureInitialized()
        .encodeJson<Contact>(this as Contact);
  }

  Map<String, dynamic> toMap() {
    return ContactMapper.ensureInitialized()
        .encodeMap<Contact>(this as Contact);
  }

  ContactCopyWith<Contact, Contact, Contact> get copyWith =>
      _ContactCopyWithImpl<Contact, Contact>(
          this as Contact, $identity, $identity);
  @override
  String toString() {
    return ContactMapper.ensureInitialized().stringifyValue(this as Contact);
  }

  @override
  bool operator ==(Object other) {
    return ContactMapper.ensureInitialized()
        .equalsValue(this as Contact, other);
  }

  @override
  int get hashCode {
    return ContactMapper.ensureInitialized().hashValue(this as Contact);
  }
}

extension ContactValueCopy<$R, $Out> on ObjectCopyWith<$R, Contact, $Out> {
  ContactCopyWith<$R, Contact, $Out> get $asContact =>
      $base.as((v, t, t2) => _ContactCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ContactCopyWith<$R, $In extends Contact, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({ContactType? type, String? value});
  ContactCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ContactCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Contact, $Out>
    implements ContactCopyWith<$R, Contact, $Out> {
  _ContactCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Contact> $mapper =
      ContactMapper.ensureInitialized();
  @override
  $R call({ContactType? type, String? value}) => $apply(FieldCopyWithData(
      {if (type != null) #type: type, if (value != null) #value: value}));
  @override
  Contact $make(CopyWithData data) => Contact(
      type: data.get(#type, or: $value.type),
      value: data.get(#value, or: $value.value));

  @override
  ContactCopyWith<$R2, Contact, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ContactCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
