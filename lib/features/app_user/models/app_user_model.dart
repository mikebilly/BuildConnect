import 'package:dart_mappable/dart_mappable.dart';

part 'app_user_model.mapper.dart';

@MappableClass()
class AppUser with AppUserMappable {
    final String? id;
    final String username;
    final String email;

    const AppUser({
        this.id,
        required this.username,
        required this.email,
    });

    factory AppUser.fromSupabase(Map<String, dynamic> map) {
        return AppUserMapper.fromMap(map);
    }
}
