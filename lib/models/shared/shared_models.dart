import 'package:dart_mappable/dart_mappable.dart';
import 'package:buildconnect/models/enums/enums.dart';

part 'shared_models.mapper.dart';

@MappableClass()
class Contact with ContactMappable {
  final ContactType type;
  final String value;

  const Contact({required this.type, required this.value});
}
