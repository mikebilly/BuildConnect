// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'profile_data_model.dart';

class ProfileDataMapper extends ClassMapperBase<ProfileData> {
  ProfileDataMapper._();

  static ProfileDataMapper? _instance;
  static ProfileDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProfileDataMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ProfileData';

  static String _$name(ProfileData v) => v.name;
  static const Field<ProfileData, String> _f$name = Field('name', _$name);
  static String _$email(ProfileData v) => v.email;
  static const Field<ProfileData, String> _f$email = Field('email', _$email);

  @override
  final MappableFields<ProfileData> fields = const {
    #name: _f$name,
    #email: _f$email,
  };

  static ProfileData _instantiate(DecodingData data) {
    return ProfileData(name: data.dec(_f$name), email: data.dec(_f$email));
  }

  @override
  final Function instantiate = _instantiate;

  static ProfileData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProfileData>(map);
  }

  static ProfileData fromJson(String json) {
    return ensureInitialized().decodeJson<ProfileData>(json);
  }
}

mixin ProfileDataMappable {
  String toJson() {
    return ProfileDataMapper.ensureInitialized()
        .encodeJson<ProfileData>(this as ProfileData);
  }

  Map<String, dynamic> toMap() {
    return ProfileDataMapper.ensureInitialized()
        .encodeMap<ProfileData>(this as ProfileData);
  }

  ProfileDataCopyWith<ProfileData, ProfileData, ProfileData> get copyWith =>
      _ProfileDataCopyWithImpl<ProfileData, ProfileData>(
          this as ProfileData, $identity, $identity);
  @override
  String toString() {
    return ProfileDataMapper.ensureInitialized()
        .stringifyValue(this as ProfileData);
  }

  @override
  bool operator ==(Object other) {
    return ProfileDataMapper.ensureInitialized()
        .equalsValue(this as ProfileData, other);
  }

  @override
  int get hashCode {
    return ProfileDataMapper.ensureInitialized().hashValue(this as ProfileData);
  }
}

extension ProfileDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProfileData, $Out> {
  ProfileDataCopyWith<$R, ProfileData, $Out> get $asProfileData =>
      $base.as((v, t, t2) => _ProfileDataCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProfileDataCopyWith<$R, $In extends ProfileData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? email});
  ProfileDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProfileDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProfileData, $Out>
    implements ProfileDataCopyWith<$R, ProfileData, $Out> {
  _ProfileDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProfileData> $mapper =
      ProfileDataMapper.ensureInitialized();
  @override
  $R call({String? name, String? email}) => $apply(FieldCopyWithData(
      {if (name != null) #name: name, if (email != null) #email: email}));
  @override
  ProfileData $make(CopyWithData data) => ProfileData(
      name: data.get(#name, or: $value.name),
      email: data.get(#email, or: $value.email));

  @override
  ProfileDataCopyWith<$R2, ProfileData, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ProfileDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
