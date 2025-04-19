import 'package:dart_mappable/dart_mappable.dart';
import 'package:buildconnect/models/enums/enums.dart';

part 'contractor_profile_model.mapper.dart';

@MappableClass()
class ContractorProfile with ContractorProfileMappable {
  final List<ServiceType> services;
  final List<Equipment> equipments;

  const ContractorProfile({
    required this.services,
    required this.equipments,
  });
}

