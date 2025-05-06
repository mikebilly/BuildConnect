import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buildconnect/features/auth/services/auth_service.dart';
import 'package:buildconnect/core/services/supabase/supabase_client_provider.dart';

part 'auth_service_provider.g.dart';

@riverpod
AuthService authService(Ref ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return AuthService(supabase);
}

