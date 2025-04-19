
import 'package:dart_mappable/dart_mappable.dart';
import 'package:buildconnect/models/enums/enums.dart';

part 'architect_profile_model.mapper.dart';

@MappableClass()
class ArchitectProfile with ArchitectProfileMappable {
  final ArchitectRole architectRole;
  final List<Education> education;
  final String designPhilosophy;
  final List<DesignStyle> designStyles;
  final List<String> portfolioLinks;

  const ArchitectProfile({
    required this.architectRole,
    required this.education,
    required this.designPhilosophy,
    required this.designStyles,
    required this.portfolioLinks,
  });
}
