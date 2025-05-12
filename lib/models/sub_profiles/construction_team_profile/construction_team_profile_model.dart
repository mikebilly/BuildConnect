import 'package:dart_mappable/dart_mappable.dart';
import 'package:buildconnect/models/enums/enums.dart';

part 'construction_team_profile_model.mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class ConstructionTeamProfile with ConstructionTeamProfileMappable {
  final String? profileId;
  // final Representative representative;
  final String representativeName;
  final String representativePhone;

  final int teamSize;
  final List<ServiceType> services;
  // final List<Equipment> equipments;

  const ConstructionTeamProfile({
    this.profileId,
    // required this.representative,
    required this.representativeName,
    required this.representativePhone,
    required this.teamSize,
    required this.services,
    // required this.equipments,
  });

  factory ConstructionTeamProfile.empty() {
    return const ConstructionTeamProfile(
      representativeName: '',
      representativePhone: '',
      teamSize: 0,
      services: [],
    );
  }
}
