import 'package:buildconnect/models/enums/enums.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'profile_data_model.mapper.dart';

@MappableClass()
class ProfileData with ProfileDataMappable {
  final String displayName;
  final ProfileType profileType;

  final List<String> portfolioLinks;
  final List<DesignStyle> designStyles;

  const ProfileData({
    required this.displayName,
    required this.profileType,
    required this.portfolioLinks,
    required this.designStyles
  });

  factory ProfileData.empty() {
    return const ProfileData(
      displayName: '',
      profileType: ProfileType.architect,
      portfolioLinks: [],
      designStyles: [],
    );
  }
}
