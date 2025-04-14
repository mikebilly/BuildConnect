import 'package:buildconnect/features/app_user/providers/app_user_provider.dart';
import 'package:buildconnect/features/app_user/models/app_user_model.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buildconnect/features/auth/providers/auth_provider.dart';


// If you need to mock any dependencies
// import 'package:mockito/mockito.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  try {
    print('Initializing Supabase...');
    
    // Initialize Supabase
    await Supabase.initialize(
      url: 'https://eizgvukiycewbdxqjkfz.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVpemd2dWtpeWNld2JkeHFqa2Z6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQyODQwMTksImV4cCI6MjA1OTg2MDAxOX0.9llj-m6yYl-BitElbbdQ83lmpY21zKx50Gx6rnoA_Yo'
    );
    
    final supabase = Supabase.instance.client;
    print('Supabase client initialized');
    
    // Clear any existing session
    await supabase.auth.signOut();
    print('Signed out any existing session');
    
    // IMPORTANT: This test requires email confirmation to be disabled in your Supabase project
    // Go to Supabase Dashboard > Authentication > Email > Disable "Confirm Email"
    print('\n⚠️ IMPORTANT: For this test to work, disable email confirmation in Supabase dashboard');
    print('Go to Authentication > Email > Turn OFF "Confirm email"');
    print('Otherwise, the login will fail with "Email not confirmed" error\n');
    
    // Test registration and login separately
    try {
      print('--- Testing Registration ---');
      // Use a more standard email format with a real domain
      final testEmail = 'test${DateTime.now().millisecondsSinceEpoch}@gmail.com';
      final testPassword = 'Password123!';
      
      print('Registering with email: $testEmail');
      final signUpResponse = await supabase.auth.signUp(
        email: testEmail,
        password: testPassword,
      );
      
      if (signUpResponse.user != null) {
        print('✅ Registration successful!');
        print('User ID: ${signUpResponse.user!.id}');
        print('User Email: ${signUpResponse.user!.email}');
        
        // Check if our custom user was created
        await Future.delayed(const Duration(seconds: 1));
        final userData = await supabase
            .from('users')
            .select()
            .eq('id', signUpResponse.user!.id)
            .maybeSingle();
        
        if (userData != null) {
          print('✅ Custom user record created in users table');
          print('User data: $userData');
        } else {
          print('❌ Custom user record not created in users table');
          print('Check your database trigger implementation');
        }
        
        // Test logout
        print('\n--- Testing Logout ---');
        await supabase.auth.signOut();
        print('✅ Logout successful!');
        
        // Test login
        print('\n--- Testing Login ---');
        print('Logging in with email: $testEmail');
        
        try {
          final signInResponse = await supabase.auth.signInWithPassword(
            email: testEmail,
            password: testPassword,
          );
          
          if (signInResponse.user != null) {
            print('✅ Login successful!');
            print('User ID: ${signInResponse.user!.id}');
            print('User Email: ${signInResponse.user!.email}');
            
            // Get the user data from our custom table
            final userData = await supabase
                .from('users')
                .select()
                .eq('id', signInResponse.user!.id)
                .maybeSingle();
                
            if (userData != null) {
              print('✅ Custom user data retrieved successfully');
              print('Raw user data: $userData');
              final appUser = AppUserMapper.fromMap(userData);
              print('Mapped user: $appUser');
            } else {
              print('❌ Could not retrieve custom user data');
            }
          } else {
            print('❌ Login failed');
          }
        } catch (e) {
          print('❌ Login failed: $e');
          print('If error is "Email not confirmed", you need to disable email confirmation in Supabase dashboard');
        }
      } else {
        print('❌ Registration failed');
      }
      
    } catch (e) {
      print('❌ Authentication test error: $e');
    }
    
    // Final cleanup
    await supabase.auth.signOut();
    await Supabase.instance.dispose();
    print('\nTest completed');
    
  } catch (e, stackTrace) {
    print('❌ Error: $e');
    print('Stack trace: $stackTrace');
  }
}
