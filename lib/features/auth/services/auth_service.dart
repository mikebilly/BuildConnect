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

      if (response.user == null) {
        debugPrint('Sign in: No user returned');
        throw AuthException('No user returned from sign in');
      }

      debugPrint("User signed in: ${response.user!.email}");
    } on AuthException catch (error) {
      debugPrint('Sign in error: ${error.message}');
      rethrow;
    } catch (error) {
      debugPrint('Unexpected error during sign in: $error');
      rethrow;
    }
  }

  @override
  Future<void> signUp(String email, String password) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user == null) {
        debugPrint('Sign up: No user returned');
        throw AuthException('No user returned from sign up');
      }

      debugPrint("User signed up: ${response.user!.email}");
    } on AuthException catch (error) {
      debugPrint('Sign up error: ${error.message}');
      rethrow;
    } catch (error) {
      debugPrint('Unexpected error during sign up: $error');
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
      debugPrint('User signed out');
    } on AuthException catch (error) {
      debugPrint('Sign out error: ${error.message}');
      rethrow;
    } catch (error) {
      debugPrint('Unexpected error during sign out: $error');
      rethrow;
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
    if (user == null) return null;

    try {
      final data = await _supabase
          .from(SupabaseConstants.usersTable)
          .select('id, email, created_at')
          .eq('id', user.id)
          .single();

      debugPrint('🟡 Supabase user data: $data');

      return AppUserMapper.fromMap(data);
    } catch (error) {
      debugPrint('Error fetching app user: $error');
      return null;
    }
  }
}
