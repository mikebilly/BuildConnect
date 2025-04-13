import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseKeys {
    static String get url => dotenv.get('SUPABASE_URL', fallback: '');
    static String get anonKey => dotenv.get('SUPABSE_ANON_KEY', fallback: '');
}
