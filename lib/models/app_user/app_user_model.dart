import 'package:dart_mappable/dart_mappable.dart';

part 'app_user_model.mapper.dart';

@MappableClass()
class AppUser with AppUserMappable {
  final String id;
  final String email;

  @MappableField(key: 'created_at')
  final DateTime createdAt;

  const AppUser({
    required this.id,
    required this.email,
    required this.createdAt,
  });
}
