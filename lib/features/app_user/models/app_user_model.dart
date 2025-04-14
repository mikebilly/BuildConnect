import 'package:dart_mappable/dart_mappable.dart';

part 'app_user_model.mapper.dart';

@MappableClass()
class AppUser with AppUserMappable {
    final String? id;
    final String email;
    @MappableField(key: 'created_at')
    final DateTime? createdAt;
    @MappableField(key: 'updated_at')
    final DateTime? updatedAt;

    const AppUser({
        this.id,
        required this.email,
        this.createdAt,
        this.updatedAt,
    });

    factory AppUser.fromSupabase(Map<String, dynamic> map) {
        return AppUserMapper.fromMap(map);
    }
}
