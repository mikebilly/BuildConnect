import 'package:dart_mappable/dart_mappable.dart';
import 'package:buildconnect/models/enums/enums.dart';

part 'profile_model.mapper.dart';

@MappableClass()
class Profile with ProfileMappable {
  final String id;
  final String userId; // FK to AppUser.id
  final String displayName;
  final String logo;
  final ProfileType profileType;
  final ContactInfo contactInfo;
  final String profilePhoto;
  final VerificationInfo verificationInfo;
  final Location mainLocation;
  final String bio;
  final String availabilityStatus;
  final List<Project> projects;
  final List<Certification> certifications;
  final int yearsOfExperience;
  final RatingsInfo ratingsInfo;
  final Legal? legal;
  final DateTime? established;
  final List<String> operatingAreas;
  final WorkingMode workingMode;
  final List<Media> medias;
  final List<String> links;
  final Warranty? warranty;
  final List<Domain> domains;
  final PaymentTerms paymentTerms;

  // One of the following will be populated based on profileType
  final ArchitectProfile? architectProfile;
  final ContractorProfile? contractorProfile;
  final ConstructionTeamProfile? constructionTeamProfile;
  final SupplierProfile? supplierProfile;

  Profile({
    required this.id,
    required this.userId,
    required this.displayName,
    required this.logo,
    required this.profileType,
    required this.contactInfo,
    required this.profilePhoto,
    required this.verificationInfo,
    required this.mainLocation,
    required this.bio,
    required this.availabilityStatus,
    required this.projects,
    required this.certifications,
    required this.yearsOfExperience,
    required this.ratingsInfo,
    this.legal,
    this.established,
    required this.operatingAreas,
    required this.workingMode,
    required this.medias,
    required this.links,
    this.warranty,
    required this.domains,
    required this.paymentTerms,
    this.architectProfile,
    this.contractorProfile,
    this.constructionTeamProfile,
    this.supplierProfile,
  });
}
