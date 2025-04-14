import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'supabase_client_provider.g.dart';

@riverpod
SupabaseClient supabaseClient(SupabaseClientRef ref) {
    return Supabase.instance.client;
}
