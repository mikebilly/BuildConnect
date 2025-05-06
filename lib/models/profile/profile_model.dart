import 'package:dart_mappable/dart_mappable.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:buildconnect/models/shared/shared_models.dart';

part 'profile_model.mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class Profile with ProfileMappable {
  final String? id;
  final String? userId; // FK to AppUser.id
  final String displayName;
  // final String logo;
  final ProfileType profileType;
  // final ContactInfo contactInfo;
  // final String profilePhoto;
  // final VerificationInfo verificationInfo;

  final City mainCity;
  final String mainAddress;
  final List<City> operatingAreas;

  final String bio;
  final AvailabilityStatus availabilityStatus;
  // final List<Project> projects;
  // final List<Certification> certifications;
  final int yearsOfExperience;
  // final RatingsInfo ratingsInfo;
  // final Legal? legal;
  // final DateTime? established;
  // final List<String> operatingAreas;
  final WorkingMode workingMode;
  // final List<Media> medias;
  // final List<String> links;
  // final Warranty? warranty;
  final List<Domain> domains;

  final List<Contact> contacts;

  final List<PaymentMethod> paymentMethods;

  final BusinessEntityType businessEntityType;
  // final PaymentTerms paymentTerms;

  // One of the following will be populated based on profileType
  // final ArchitectProfile? architectProfile;
  // final ContractorProfile? contractorProfile;
  // final ConstructionTeamProfile? constructionTeamProfile;
  // final SupplierProfile? supplierProfile;

  Profile({
    this.id,
    this.userId,
    required this.displayName,
    // required this.logo,
    required this.profileType,
    // required this.contactInfo,
    // required this.profilePhoto,
    // required this.verificationInfo,

    required this.mainCity,
    required this.mainAddress,
    required this.operatingAreas,

    required this.bio,
    required this.availabilityStatus,
    // required this.projects,
    // required this.certifications,
    required this.yearsOfExperience,
    // required this.ratingsInfo,
    // this.legal,
    // this.established,
    // required this.operatingAreas,
    required this.workingMode,
    // required this.medias,
    // required this.links,
    // this.warranty,
    required this.domains,
    // required this.paymentTerms,
    // this.architectProfile,
    // this.contractorProfile,
    // this.constructionTeamProfile,
    // this.supplierProfile,

    required this.contacts,
    required this.paymentMethods,
    required this.businessEntityType,
  });

  factory Profile.empty() {
    return Profile(
      // userId: '',
      displayName: '',
      profileType: ProfileType.values.first,
      bio: '',
      availabilityStatus: AvailabilityStatus.values.first,
      yearsOfExperience: 1,
      workingMode: WorkingMode.values.first,
      domains: [],
      contacts: [],
      paymentMethods: [],
      businessEntityType: BusinessEntityType.values.first,

      mainCity: City.values.first,
      mainAddress: '',
      operatingAreas: [],
    );
  }
}
