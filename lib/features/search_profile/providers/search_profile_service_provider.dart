import 'package:buildconnect/features/search_profile/services/search_profile_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'search_profile_service_provider.g.dart';

@Riverpod(keepAlive: true)
SearchPostService searchProfileService(Ref ref) {
  final SupabaseClient _supabase = Supabase.instance.client;
  return SearchPostService(_supabase);
}
