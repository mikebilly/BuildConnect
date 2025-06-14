// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'profile_model.dart';

class ProfileMapper extends ClassMapperBase<Profile> {
  ProfileMapper._();

  static ProfileMapper? _instance;
  static ProfileMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProfileMapper._());
      ProfileTypeMapper.ensureInitialized();
      CityMapper.ensureInitialized();
      AvailabilityStatusMapper.ensureInitialized();
      WorkingModeMapper.ensureInitialized();
      DomainMapper.ensureInitialized();
      ContactMapper.ensureInitialized();
      PaymentMethodMapper.ensureInitialized();
      BusinessEntityTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Profile';

  static String? _$id(Profile v) => v.id;
  static const Field<Profile, String> _f$id = Field('id', _$id, opt: true);
  static String? _$userId(Profile v) => v.userId;
  static const Field<Profile, String> _f$userId =
      Field('userId', _$userId, key: r'user_id', opt: true);
  static String _$displayName(Profile v) => v.displayName;
  static const Field<Profile, String> _f$displayName =
      Field('displayName', _$displayName, key: r'display_name');
  static ProfileType _$profileType(Profile v) => v.profileType;
  static const Field<Profile, ProfileType> _f$profileType =
      Field('profileType', _$profileType, key: r'profile_type');
  static City _$mainCity(Profile v) => v.mainCity;
  static const Field<Profile, City> _f$mainCity =
      Field('mainCity', _$mainCity, key: r'main_city');
  static String _$mainAddress(Profile v) => v.mainAddress;
  static const Field<Profile, String> _f$mainAddress =
      Field('mainAddress', _$mainAddress, key: r'main_address');
  static List<City> _$operatingAreas(Profile v) => v.operatingAreas;
  static const Field<Profile, List<City>> _f$operatingAreas =
      Field('operatingAreas', _$operatingAreas, key: r'operating_areas');
  static String _$bio(Profile v) => v.bio;
  static const Field<Profile, String> _f$bio = Field('bio', _$bio);
  static AvailabilityStatus _$availabilityStatus(Profile v) =>
      v.availabilityStatus;
  static const Field<Profile, AvailabilityStatus> _f$availabilityStatus = Field(
      'availabilityStatus', _$availabilityStatus,
      key: r'availability_status');
  static int _$yearsOfExperience(Profile v) => v.yearsOfExperience;
  static const Field<Profile, int> _f$yearsOfExperience = Field(
      'yearsOfExperience', _$yearsOfExperience,
      key: r'years_of_experience');
  static WorkingMode _$workingMode(Profile v) => v.workingMode;
  static const Field<Profile, WorkingMode> _f$workingMode =
      Field('workingMode', _$workingMode, key: r'working_mode');
  static List<Domain> _$domains(Profile v) => v.domains;
  static const Field<Profile, List<Domain>> _f$domains =
      Field('domains', _$domains);
  static List<Contact> _$contacts(Profile v) => v.contacts;
  static const Field<Profile, List<Contact>> _f$contacts =
      Field('contacts', _$contacts);
  static List<PaymentMethod> _$paymentMethods(Profile v) => v.paymentMethods;
  static const Field<Profile, List<PaymentMethod>> _f$paymentMethods =
      Field('paymentMethods', _$paymentMethods, key: r'payment_methods');
  static BusinessEntityType _$businessEntityType(Profile v) =>
      v.businessEntityType;
  static const Field<Profile, BusinessEntityType> _f$businessEntityType = Field(
      'businessEntityType', _$businessEntityType,
      key: r'business_entity_type');

  @override
  final MappableFields<Profile> fields = const {
    #id: _f$id,
    #userId: _f$userId,
    #displayName: _f$displayName,
    #profileType: _f$profileType,
    #mainCity: _f$mainCity,
    #mainAddress: _f$mainAddress,
    #operatingAreas: _f$operatingAreas,
    #bio: _f$bio,
    #availabilityStatus: _f$availabilityStatus,
    #yearsOfExperience: _f$yearsOfExperience,
    #workingMode: _f$workingMode,
    #domains: _f$domains,
    #contacts: _f$contacts,
    #paymentMethods: _f$paymentMethods,
    #businessEntityType: _f$businessEntityType,
  };

  static Profile _instantiate(DecodingData data) {
    return Profile(
        id: data.dec(_f$id),
        userId: data.dec(_f$userId),
        displayName: data.dec(_f$displayName),
        profileType: data.dec(_f$profileType),
        mainCity: data.dec(_f$mainCity),
        mainAddress: data.dec(_f$mainAddress),
        operatingAreas: data.dec(_f$operatingAreas),
        bio: data.dec(_f$bio),
        availabilityStatus: data.dec(_f$availabilityStatus),
        yearsOfExperience: data.dec(_f$yearsOfExperience),
        workingMode: data.dec(_f$workingMode),
        domains: data.dec(_f$domains),
        contacts: data.dec(_f$contacts),
        paymentMethods: data.dec(_f$paymentMethods),
        businessEntityType: data.dec(_f$businessEntityType));
  }

  @override
  final Function instantiate = _instantiate;

  static Profile fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Profile>(map);
  }

  static Profile fromJson(String json) {
    return ensureInitialized().decodeJson<Profile>(json);
  }
}

mixin ProfileMappable {
  String toJson() {
    return ProfileMapper.ensureInitialized()
        .encodeJson<Profile>(this as Profile);
  }

  Map<String, dynamic> toMap() {
    return ProfileMapper.ensureInitialized()
        .encodeMap<Profile>(this as Profile);
  }

  ProfileCopyWith<Profile, Profile, Profile> get copyWith =>
      _ProfileCopyWithImpl<Profile, Profile>(
          this as Profile, $identity, $identity);
  @override
  String toString() {
    return ProfileMapper.ensureInitialized().stringifyValue(this as Profile);
  }

  @override
  bool operator ==(Object other) {
    return ProfileMapper.ensureInitialized()
        .equalsValue(this as Profile, other);
  }

  @override
  int get hashCode {
    return ProfileMapper.ensureInitialized().hashValue(this as Profile);
  }
}

extension ProfileValueCopy<$R, $Out> on ObjectCopyWith<$R, Profile, $Out> {
  ProfileCopyWith<$R, Profile, $Out> get $asProfile =>
      $base.as((v, t, t2) => _ProfileCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProfileCopyWith<$R, $In extends Profile, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, City, ObjectCopyWith<$R, City, City>> get operatingAreas;
  ListCopyWith<$R, Domain, ObjectCopyWith<$R, Domain, Domain>> get domains;
  ListCopyWith<$R, Contact, ContactCopyWith<$R, Contact, Contact>> get contacts;
  ListCopyWith<$R, PaymentMethod,
      ObjectCopyWith<$R, PaymentMethod, PaymentMethod>> get paymentMethods;
  $R call(
      {String? id,
      String? userId,
      String? displayName,
      ProfileType? profileType,
      City? mainCity,
      String? mainAddress,
      List<City>? operatingAreas,
      String? bio,
      AvailabilityStatus? availabilityStatus,
      int? yearsOfExperience,
      WorkingMode? workingMode,
      List<Domain>? domains,
      List<Contact>? contacts,
      List<PaymentMethod>? paymentMethods,
      BusinessEntityType? businessEntityType});
  ProfileCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProfileCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Profile, $Out>
    implements ProfileCopyWith<$R, Profile, $Out> {
  _ProfileCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Profile> $mapper =
      ProfileMapper.ensureInitialized();
  @override
  ListCopyWith<$R, City, ObjectCopyWith<$R, City, City>> get operatingAreas =>
      ListCopyWith(
          $value.operatingAreas,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(operatingAreas: v));
  @override
  ListCopyWith<$R, Domain, ObjectCopyWith<$R, Domain, Domain>> get domains =>
      ListCopyWith($value.domains, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(domains: v));
  @override
  ListCopyWith<$R, Contact, ContactCopyWith<$R, Contact, Contact>>
      get contacts => ListCopyWith($value.contacts,
          (v, t) => v.copyWith.$chain(t), (v) => call(contacts: v));
  @override
  ListCopyWith<$R, PaymentMethod,
          ObjectCopyWith<$R, PaymentMethod, PaymentMethod>>
      get paymentMethods => ListCopyWith(
          $value.paymentMethods,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(paymentMethods: v));
  @override
  $R call(
          {Object? id = $none,
          Object? userId = $none,
          String? displayName,
          ProfileType? profileType,
          City? mainCity,
          String? mainAddress,
          List<City>? operatingAreas,
          String? bio,
          AvailabilityStatus? availabilityStatus,
          int? yearsOfExperience,
          WorkingMode? workingMode,
          List<Domain>? domains,
          List<Contact>? contacts,
          List<PaymentMethod>? paymentMethods,
          BusinessEntityType? businessEntityType}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (userId != $none) #userId: userId,
        if (displayName != null) #displayName: displayName,
        if (profileType != null) #profileType: profileType,
        if (mainCity != null) #mainCity: mainCity,
        if (mainAddress != null) #mainAddress: mainAddress,
        if (operatingAreas != null) #operatingAreas: operatingAreas,
        if (bio != null) #bio: bio,
        if (availabilityStatus != null) #availabilityStatus: availabilityStatus,
        if (yearsOfExperience != null) #yearsOfExperience: yearsOfExperience,
        if (workingMode != null) #workingMode: workingMode,
        if (domains != null) #domains: domains,
        if (contacts != null) #contacts: contacts,
        if (paymentMethods != null) #paymentMethods: paymentMethods,
        if (businessEntityType != null) #businessEntityType: businessEntityType
      }));
  @override
  Profile $make(CopyWithData data) => Profile(
      id: data.get(#id, or: $value.id),
      userId: data.get(#userId, or: $value.userId),
      displayName: data.get(#displayName, or: $value.displayName),
      profileType: data.get(#profileType, or: $value.profileType),
      mainCity: data.get(#mainCity, or: $value.mainCity),
      mainAddress: data.get(#mainAddress, or: $value.mainAddress),
      operatingAreas: data.get(#operatingAreas, or: $value.operatingAreas),
      bio: data.get(#bio, or: $value.bio),
      availabilityStatus:
          data.get(#availabilityStatus, or: $value.availabilityStatus),
      yearsOfExperience:
          data.get(#yearsOfExperience, or: $value.yearsOfExperience),
      workingMode: data.get(#workingMode, or: $value.workingMode),
      domains: data.get(#domains, or: $value.domains),
      contacts: data.get(#contacts, or: $value.contacts),
      paymentMethods: data.get(#paymentMethods, or: $value.paymentMethods),
      businessEntityType:
          data.get(#businessEntityType, or: $value.businessEntityType));

  @override
  ProfileCopyWith<$R2, Profile, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ProfileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
