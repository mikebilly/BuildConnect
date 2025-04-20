import 'package:dart_mappable/dart_mappable.dart';

part 'profile_data_model.mapper.dart';

@MappableClass()
class ProfileData with ProfileDataMappable {
  final String name;
  final String email;

  const ProfileData({
    required this.name,
    required this.email,
  });

  factory ProfileData.empty() {
    return const ProfileData(
      name: '',
      email: '',
    );
  }
}
