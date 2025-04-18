import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

class SupabaseConfig {
  // static String get url => dotenv.get('SUPABASE_URL', fallback: '');
  // static String get anonKey => dotenv.get('SUPABASE_ANON_KEY', fallback: '');

  /// Call this before `runApp()` in `main.dart`
  static Future<void> initialize() async {
    final url = dotenv.get('SUPABASE_URL', fallback: '');
    final anonKey = dotenv.get('SUPABASE_ANON_KEY', fallback: '');

    await Supabase.initialize(url: url, anonKey: anonKey, debug: kDebugMode);
  }
}
