import 'package:buildconnect/features/app_user/providers/app_user_provider.dart';
import 'package:buildconnect/features/app_user/models/app_user_model.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// If you need to mock any dependencies
// import 'package:mockito/mockito.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  try {
    print('1x');
    
    // Initialize Supabase
    await Supabase.initialize(
      url: 'https://eizgvukiycewbdxqjkfz.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVpemd2dWtpeWNld2JkeHFqa2Z6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQyODQwMTksImV4cCI6MjA1OTg2MDAxOX0.9llj-m6yYl-BitElbbdQ83lmpY21zKx50Gx6rnoA_Yo'
    );
    
    final supabase = Supabase.instance.client;
    print('Supabase client initialized');
    

    // final response = await searchAppUserByUsernameProvider("test");
    // print('Found users: $response');
    
    AppUser appUser = AppUserMapper.fromMap({
        'username': 'test',
        'email': 'test@test.com',
    });

    final container = ProviderContainer();
    final createdAppUser = await container.read(createAppUserProvider(appUser).future);

    print('Created user: $createdAppUser');

    await Supabase.instance.dispose();
    print('Test completed successfully');
    
  } catch (e, stackTrace) {
    print('Error: $e');
    print('Stack trace: $stackTrace');
  }
}
