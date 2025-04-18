import 'package:flutter/material.dart';
import 'app.dart';
import 'core/config/supabase_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await dotenv.load(fileName: ".env");
  await SupabaseConfig.initialize();

  runApp(
    const ProviderScope(
      child: BuildConnectApp()
    )
  );
}
