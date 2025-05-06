import 'package:dart_mappable/dart_mappable.dart';
import 'package:buildconnect/models/enums/enums.dart';

part 'shared_models.mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class Contact with ContactMappable {
  final ContactType type;
  final String value;

  const Contact({required this.type, required this.value});
}

// @MappableClass(caseStyle: CaseStyle.snakeCase)
// class Location with LocationMappable {
//   final City city;
//   final String? address;

//   const Location({required this.city, this.address});

//   factory Location.empty() {
//     return Location(city: City.values.first, address: '');
//   }
// }