import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:buildconnect/core/services/supabase_client_provider.dart';
import 'package:buildconnect/features/app_user/models/app_user_model.dart';
part 'app_user_provider.g.dart';

@riverpod
Future<List<AppUser>> searchAppUserByEmail(SearchAppUserByEmailRef ref, String email) async {
  final supabase = ref.watch(supabaseClientProvider);
  
  try {
    final List<dynamic> data = await supabase
        .from('users')
        .select()
        .ilike('email', '%$email%');
    
        return data.map((json) => AppUserMapper.fromMap(json)).toList();
  } catch (error) {
        throw error;
  }
}

@riverpod
Future<AppUser> createAppUser(CreateAppUserRef ref, AppUser appUser) async {
    final supabase = ref.watch(supabaseClientProvider);

    try {
    final data = await supabase
        .from('users')
        .insert(appUser.toMap())
        .select()
        .single();

        return AppUserMapper.fromMap(data);
    } catch (error) {
        throw error;
    }
}
