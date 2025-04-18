import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:buildconnect/core/constants/supabase_constants.dart';
import 'package:buildconnect/models/app_user/app_user_model.dart';

abstract class IAuthService {
  Future<void> signIn(String email, String password);
  Future<void> signUp(String email, String password);
  Future<void> signOut();

  User? get currentUser;
  bool get isLoggedIn;
  String? get currentUserId;
  Future<AppUser?> fetchAppUser();
}

class AuthService implements IAuthService {
  final SupabaseClient _supabase;

  AuthService(this._supabase);

  @override
  Future<void> signIn(String email, String password) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        debugPrint("User signed in: ${response.user!.email}");
      } else {
        debugPrint('Sign in: No user returned');
      }
    } on AuthException catch (error) {
      debugPrint('Sign in error: ${error.message}');
    } catch (error) {
      debugPrint('Unexpected error: $error');
    }
  }

  @override
  Future<void> signUp(String email, String password) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      if (response.user != null) {
        debugPrint("User signed up: ${response.user!.email}");
      } else {
        debugPrint('Sign up: No user returned');
      }
    } on AuthException catch (error) {
      debugPrint('Sign up error: ${error.message}');
    } catch (error) {
      debugPrint('Unexpected error: $error');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
      debugPrint('User signed out');
    } on AuthException catch (error) {
      debugPrint('Sign out error: ${error.message}');
    } catch (error) {
      debugPrint('Unexpected error: $error');
    }
  }

  @override
  User? get currentUser {
    return _supabase.auth.currentUser;
  }

  @override
  bool get isLoggedIn {
    return currentUser != null;
  }

  @override
  String? get currentUserId {
    return currentUser?.id;
  }

  @override
  Future<AppUser?> fetchAppUser() async {
    final user = currentUser;
    if (user == null) {
      return null;
    }

    final data = await _supabase
      .from(SupabaseConstants.usersTable)
      .select('id, email, created_at')
      .eq('id', user.id)
      .single();

    debugPrint('🟡 Supabase user data: $data');
    
    return AppUserMapper.fromMap(data);
  }
}
