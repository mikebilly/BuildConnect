import 'package:buildconnect/models/enums/enums.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:buildconnect/models/shared/shared_models.dart';
import 'package:buildconnect/models/profile/profile_model.dart';
import 'package:buildconnect/models/sub_profiles/architect_profile/architect_profile_model.dart';
import 'package:buildconnect/models/sub_profiles/contractor_profile/contractor_profile_model.dart';
import 'package:buildconnect/models/sub_profiles/supplier_profile/supplier_profile_model.dart';
import 'package:buildconnect/models/sub_profiles/construction_team_profile/construction_team_profile_model.dart';

part 'profile_data_model.mapper.dart';

@MappableClass()
class ProfileData with ProfileDataMappable {
  final Profile profile;
  final ArchitectProfile? architectProfile;
  final ContractorProfile? contractorProfile;
  final SupplierProfile? supplierProfile;
  final ConstructionTeamProfile? constructionTeamProfile;

  const ProfileData({
    // required this.displayName,
    // required this.profileType,
    // required this.portfolioLinks,
    // required this.designStyles,
    // required this.contacts,
    required this.profile,
    this.architectProfile,
    this.contractorProfile,
    this.supplierProfile,
    this.constructionTeamProfile,
  });

  factory ProfileData.empty() {
    return ProfileData(
      profile: Profile.empty(),
      architectProfile: null,
      contractorProfile: null,
      supplierProfile: null,
      constructionTeamProfile: null,
    );
  }

  Object? get subProfile => switch (profile.profileType) {
    ProfileType.architect => architectProfile,
    ProfileType.contractor => contractorProfile,
    ProfileType.supplier => supplierProfile,
    ProfileType.constructionTeam => constructionTeamProfile,
  };

  String get subProfileTable => profile.profileType.table;

  Map<String, dynamic> get subProfileMap {
    final _subProfile = subProfile;
    if (_subProfile == null) {
      return {};
    }
    return (_subProfile as dynamic).toMap();
  }
}
