import 'package:dart_mappable/dart_mappable.dart';
import 'package:buildconnect/models/enums/enums.dart';

part 'construction_team_profile_model.mapper.dart';

@MappableClass()
class ConstructionTeamProfile with ConstructionTeamProfileMappable {
  final Representative representative;
  final int teamSize;
  final List<ServiceType> services;
  final List<Equipment> equipments;

  const ConstructionTeamProfile({
    required this.representative,
    required this.teamSize,
    required this.services,
    required this.equipments,
  });
}
