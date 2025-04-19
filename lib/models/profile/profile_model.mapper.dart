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
      WorkingModeMapper.ensureInitialized();
      DomainMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Profile';

  static String _$id(Profile v) => v.id;
  static const Field<Profile, String> _f$id = Field('id', _$id);
  static String _$userId(Profile v) => v.userId;
  static const Field<Profile, String> _f$userId = Field('userId', _$userId);
  static String _$displayName(Profile v) => v.displayName;
  static const Field<Profile, String> _f$displayName =
      Field('displayName', _$displayName);
  static String _$logo(Profile v) => v.logo;
  static const Field<Profile, String> _f$logo = Field('logo', _$logo);
  static ProfileType _$profileType(Profile v) => v.profileType;
  static const Field<Profile, ProfileType> _f$profileType =
      Field('profileType', _$profileType);
  static InvalidType _$contactInfo(Profile v) => v.contactInfo;
  static const Field<Profile, InvalidType> _f$contactInfo =
      Field('contactInfo', _$contactInfo);
  static String _$profilePhoto(Profile v) => v.profilePhoto;
  static const Field<Profile, String> _f$profilePhoto =
      Field('profilePhoto', _$profilePhoto);
  static InvalidType _$verificationInfo(Profile v) => v.verificationInfo;
  static const Field<Profile, InvalidType> _f$verificationInfo =
      Field('verificationInfo', _$verificationInfo);
  static InvalidType _$mainLocation(Profile v) => v.mainLocation;
  static const Field<Profile, InvalidType> _f$mainLocation =
      Field('mainLocation', _$mainLocation);
  static String _$bio(Profile v) => v.bio;
  static const Field<Profile, String> _f$bio = Field('bio', _$bio);
  static String _$availabilityStatus(Profile v) => v.availabilityStatus;
  static const Field<Profile, String> _f$availabilityStatus =
      Field('availabilityStatus', _$availabilityStatus);
  static List<InvalidType> _$projects(Profile v) => v.projects;
  static const Field<Profile, List<InvalidType>> _f$projects =
      Field('projects', _$projects);
  static List<InvalidType> _$certifications(Profile v) => v.certifications;
  static const Field<Profile, List<InvalidType>> _f$certifications =
      Field('certifications', _$certifications);
  static int _$yearsOfExperience(Profile v) => v.yearsOfExperience;
  static const Field<Profile, int> _f$yearsOfExperience =
      Field('yearsOfExperience', _$yearsOfExperience);
  static InvalidType _$ratingsInfo(Profile v) => v.ratingsInfo;
  static const Field<Profile, InvalidType> _f$ratingsInfo =
      Field('ratingsInfo', _$ratingsInfo);
  static InvalidType _$legal(Profile v) => v.legal;
  static const Field<Profile, InvalidType> _f$legal =
      Field('legal', _$legal, opt: true);
  static DateTime? _$established(Profile v) => v.established;
  static const Field<Profile, DateTime> _f$established =
      Field('established', _$established, opt: true);
  static List<String> _$operatingAreas(Profile v) => v.operatingAreas;
  static const Field<Profile, List<String>> _f$operatingAreas =
      Field('operatingAreas', _$operatingAreas);
  static WorkingMode _$workingMode(Profile v) => v.workingMode;
  static const Field<Profile, WorkingMode> _f$workingMode =
      Field('workingMode', _$workingMode);
  static List<InvalidType> _$medias(Profile v) => v.medias;
  static const Field<Profile, List<InvalidType>> _f$medias =
      Field('medias', _$medias);
  static List<String> _$links(Profile v) => v.links;
  static const Field<Profile, List<String>> _f$links = Field('links', _$links);
  static InvalidType _$warranty(Profile v) => v.warranty;
  static const Field<Profile, InvalidType> _f$warranty =
      Field('warranty', _$warranty, opt: true);
  static List<Domain> _$domains(Profile v) => v.domains;
  static const Field<Profile, List<Domain>> _f$domains =
      Field('domains', _$domains);
  static InvalidType _$paymentTerms(Profile v) => v.paymentTerms;
  static const Field<Profile, InvalidType> _f$paymentTerms =
      Field('paymentTerms', _$paymentTerms);
  static InvalidType _$architectProfile(Profile v) => v.architectProfile;
  static const Field<Profile, InvalidType> _f$architectProfile =
      Field('architectProfile', _$architectProfile, opt: true);
  static InvalidType _$contractorProfile(Profile v) => v.contractorProfile;
  static const Field<Profile, InvalidType> _f$contractorProfile =
      Field('contractorProfile', _$contractorProfile, opt: true);
  static InvalidType _$constructionTeamProfile(Profile v) =>
      v.constructionTeamProfile;
  static const Field<Profile, InvalidType> _f$constructionTeamProfile =
      Field('constructionTeamProfile', _$constructionTeamProfile, opt: true);
  static InvalidType _$supplierProfile(Profile v) => v.supplierProfile;
  static const Field<Profile, InvalidType> _f$supplierProfile =
      Field('supplierProfile', _$supplierProfile, opt: true);

  @override
  final MappableFields<Profile> fields = const {
    #id: _f$id,
    #userId: _f$userId,
    #displayName: _f$displayName,
    #logo: _f$logo,
    #profileType: _f$profileType,
    #contactInfo: _f$contactInfo,
    #profilePhoto: _f$profilePhoto,
    #verificationInfo: _f$verificationInfo,
    #mainLocation: _f$mainLocation,
    #bio: _f$bio,
    #availabilityStatus: _f$availabilityStatus,
    #projects: _f$projects,
    #certifications: _f$certifications,
    #yearsOfExperience: _f$yearsOfExperience,
    #ratingsInfo: _f$ratingsInfo,
    #legal: _f$legal,
    #established: _f$established,
    #operatingAreas: _f$operatingAreas,
    #workingMode: _f$workingMode,
    #medias: _f$medias,
    #links: _f$links,
    #warranty: _f$warranty,
    #domains: _f$domains,
    #paymentTerms: _f$paymentTerms,
    #architectProfile: _f$architectProfile,
    #contractorProfile: _f$contractorProfile,
    #constructionTeamProfile: _f$constructionTeamProfile,
    #supplierProfile: _f$supplierProfile,
  };

  static Profile _instantiate(DecodingData data) {
    return Profile(
        id: data.dec(_f$id),
        userId: data.dec(_f$userId),
        displayName: data.dec(_f$displayName),
        logo: data.dec(_f$logo),
        profileType: data.dec(_f$profileType),
        contactInfo: data.dec(_f$contactInfo),
        profilePhoto: data.dec(_f$profilePhoto),
        verificationInfo: data.dec(_f$verificationInfo),
        mainLocation: data.dec(_f$mainLocation),
        bio: data.dec(_f$bio),
        availabilityStatus: data.dec(_f$availabilityStatus),
        projects: data.dec(_f$projects),
        certifications: data.dec(_f$certifications),
        yearsOfExperience: data.dec(_f$yearsOfExperience),
        ratingsInfo: data.dec(_f$ratingsInfo),
        legal: data.dec(_f$legal),
        established: data.dec(_f$established),
        operatingAreas: data.dec(_f$operatingAreas),
        workingMode: data.dec(_f$workingMode),
        medias: data.dec(_f$medias),
        links: data.dec(_f$links),
        warranty: data.dec(_f$warranty),
        domains: data.dec(_f$domains),
        paymentTerms: data.dec(_f$paymentTerms),
        architectProfile: data.dec(_f$architectProfile),
        contractorProfile: data.dec(_f$contractorProfile),
        constructionTeamProfile: data.dec(_f$constructionTeamProfile),
        supplierProfile: data.dec(_f$supplierProfile));
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
  ListCopyWith<$R, InvalidType, ObjectCopyWith<$R, InvalidType, InvalidType>>
      get projects;
  ListCopyWith<$R, InvalidType, ObjectCopyWith<$R, InvalidType, InvalidType>>
      get certifications;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get operatingAreas;
  ListCopyWith<$R, InvalidType, ObjectCopyWith<$R, InvalidType, InvalidType>>
      get medias;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get links;
  ListCopyWith<$R, Domain, ObjectCopyWith<$R, Domain, Domain>> get domains;
  $R call(
      {String? id,
      String? userId,
      String? displayName,
      String? logo,
      ProfileType? profileType,
      InvalidType? contactInfo,
      String? profilePhoto,
      InvalidType? verificationInfo,
      InvalidType? mainLocation,
      String? bio,
      String? availabilityStatus,
      List<InvalidType>? projects,
      List<InvalidType>? certifications,
      int? yearsOfExperience,
      InvalidType? ratingsInfo,
      InvalidType? legal,
      DateTime? established,
      List<String>? operatingAreas,
      WorkingMode? workingMode,
      List<InvalidType>? medias,
      List<String>? links,
      InvalidType? warranty,
      List<Domain>? domains,
      InvalidType? paymentTerms,
      InvalidType? architectProfile,
      InvalidType? contractorProfile,
      InvalidType? constructionTeamProfile,
      InvalidType? supplierProfile});
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
  ListCopyWith<$R, InvalidType, ObjectCopyWith<$R, InvalidType, InvalidType>>
      get projects => ListCopyWith($value.projects,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(projects: v));
  @override
  ListCopyWith<$R, InvalidType, ObjectCopyWith<$R, InvalidType, InvalidType>>
      get certifications => ListCopyWith(
          $value.certifications,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(certifications: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get operatingAreas => ListCopyWith(
          $value.operatingAreas,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(operatingAreas: v));
  @override
  ListCopyWith<$R, InvalidType, ObjectCopyWith<$R, InvalidType, InvalidType>>
      get medias => ListCopyWith($value.medias,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(medias: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get links =>
      ListCopyWith($value.links, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(links: v));
  @override
  ListCopyWith<$R, Domain, ObjectCopyWith<$R, Domain, Domain>> get domains =>
      ListCopyWith($value.domains, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(domains: v));
  @override
  $R call(
          {String? id,
          String? userId,
          String? displayName,
          String? logo,
          ProfileType? profileType,
          InvalidType? contactInfo,
          String? profilePhoto,
          InvalidType? verificationInfo,
          InvalidType? mainLocation,
          String? bio,
          String? availabilityStatus,
          List<InvalidType>? projects,
          List<InvalidType>? certifications,
          int? yearsOfExperience,
          InvalidType? ratingsInfo,
          InvalidType? legal,
          Object? established = $none,
          List<String>? operatingAreas,
          WorkingMode? workingMode,
          List<InvalidType>? medias,
          List<String>? links,
          InvalidType? warranty,
          List<Domain>? domains,
          InvalidType? paymentTerms,
          InvalidType? architectProfile,
          InvalidType? contractorProfile,
          InvalidType? constructionTeamProfile,
          InvalidType? supplierProfile}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (userId != null) #userId: userId,
        if (displayName != null) #displayName: displayName,
        if (logo != null) #logo: logo,
        if (profileType != null) #profileType: profileType,
        if (contactInfo != null) #contactInfo: contactInfo,
        if (profilePhoto != null) #profilePhoto: profilePhoto,
        if (verificationInfo != null) #verificationInfo: verificationInfo,
        if (mainLocation != null) #mainLocation: mainLocation,
        if (bio != null) #bio: bio,
        if (availabilityStatus != null) #availabilityStatus: availabilityStatus,
        if (projects != null) #projects: projects,
        if (certifications != null) #certifications: certifications,
        if (yearsOfExperience != null) #yearsOfExperience: yearsOfExperience,
        if (ratingsInfo != null) #ratingsInfo: ratingsInfo,
        if (legal != null) #legal: legal,
        if (established != $none) #established: established,
        if (operatingAreas != null) #operatingAreas: operatingAreas,
        if (workingMode != null) #workingMode: workingMode,
        if (medias != null) #medias: medias,
        if (links != null) #links: links,
        if (warranty != null) #warranty: warranty,
        if (domains != null) #domains: domains,
        if (paymentTerms != null) #paymentTerms: paymentTerms,
        if (architectProfile != null) #architectProfile: architectProfile,
        if (contractorProfile != null) #contractorProfile: contractorProfile,
        if (constructionTeamProfile != null)
          #constructionTeamProfile: constructionTeamProfile,
        if (supplierProfile != null) #supplierProfile: supplierProfile
      }));
  @override
  Profile $make(CopyWithData data) => Profile(
      id: data.get(#id, or: $value.id),
      userId: data.get(#userId, or: $value.userId),
      displayName: data.get(#displayName, or: $value.displayName),
      logo: data.get(#logo, or: $value.logo),
      profileType: data.get(#profileType, or: $value.profileType),
      contactInfo: data.get(#contactInfo, or: $value.contactInfo),
      profilePhoto: data.get(#profilePhoto, or: $value.profilePhoto),
      verificationInfo:
          data.get(#verificationInfo, or: $value.verificationInfo),
      mainLocation: data.get(#mainLocation, or: $value.mainLocation),
      bio: data.get(#bio, or: $value.bio),
      availabilityStatus:
          data.get(#availabilityStatus, or: $value.availabilityStatus),
      projects: data.get(#projects, or: $value.projects),
      certifications: data.get(#certifications, or: $value.certifications),
      yearsOfExperience:
          data.get(#yearsOfExperience, or: $value.yearsOfExperience),
      ratingsInfo: data.get(#ratingsInfo, or: $value.ratingsInfo),
      legal: data.get(#legal, or: $value.legal),
      established: data.get(#established, or: $value.established),
      operatingAreas: data.get(#operatingAreas, or: $value.operatingAreas),
      workingMode: data.get(#workingMode, or: $value.workingMode),
      medias: data.get(#medias, or: $value.medias),
      links: data.get(#links, or: $value.links),
      warranty: data.get(#warranty, or: $value.warranty),
      domains: data.get(#domains, or: $value.domains),
      paymentTerms: data.get(#paymentTerms, or: $value.paymentTerms),
      architectProfile:
          data.get(#architectProfile, or: $value.architectProfile),
      contractorProfile:
          data.get(#contractorProfile, or: $value.contractorProfile),
      constructionTeamProfile: data.get(#constructionTeamProfile,
          or: $value.constructionTeamProfile),
      supplierProfile: data.get(#supplierProfile, or: $value.supplierProfile));

  @override
  ProfileCopyWith<$R2, Profile, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ProfileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
