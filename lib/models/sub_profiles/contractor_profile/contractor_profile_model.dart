import 'package:dart_mappable/dart_mappable.dart';
import 'package:buildconnect/models/enums/enums.dart';

part 'contractor_profile_model.mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class ContractorProfile with ContractorProfileMappable {
  final String? profileId;
  final List<ServiceType> services;
  // final List<Equipment> equipments;

  const ContractorProfile({
    this.profileId,
    required this.services,
    // required this.equipments,
  });

  factory ContractorProfile.empty() {
    return const ContractorProfile(services: []);
  }
}
