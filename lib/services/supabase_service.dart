import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
    static final SupabaseClient supabaseClient = Supabase.instance.client;

    static SupabaseClient get client => supabaseClient;
}
