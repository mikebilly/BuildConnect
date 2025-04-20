import 'package:buildconnect/features/profile_data/services/profile_data_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buildconnect/core/services/supabase/supabase_client_provider.dart';

part 'profile_data_service_provider.g.dart';

@Riverpod(keepAlive: true)
ProfileDataService profileDataService(Ref ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return ProfileDataService(supabase);
}
