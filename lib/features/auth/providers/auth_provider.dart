import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:buildconnect/core/services/supabase_client_provider.dart';
import 'package:buildconnect/features/app_user/models/app_user_model.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  @override
  FutureOr<AppUser?> build() async {
    final supabase = ref.watch(supabaseClientProvider);
    final user = supabase.auth.currentUser;
    
    if (user == null) {
      return null;
    }
    
    try {
      final data = await supabase
          .from('users')
          .select()
          .eq('id', user.id)
          .single();
      
      return AppUserMapper.fromMap(data);
    } catch (e) {
      // If the user exists in auth but not in our table (rare edge case)
      return null;
    }
  }
  
  Future<void> signUp({required String email, required String password}) async {
    final supabase = ref.read(supabaseClientProvider);
    
    state = const AsyncLoading();
    
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      
      if (response.user != null) {
        // The database trigger will handle creating the user record
        // Giving the trigger a moment to complete
        await Future.delayed(const Duration(milliseconds: 300));
        state = AsyncData(await _getCurrentUser());
      } else {
        state = AsyncError('Account creation failed', StackTrace.current);
      }
    } on AuthException catch (e) {
      state = AsyncError(e.message, StackTrace.current);
    } catch (e) {
      state = AsyncError('An unexpected error occurred', StackTrace.current);
    }
  }
  
  Future<void> signIn({required String email, required String password}) async {
    final supabase = ref.read(supabaseClientProvider);
    
    state = const AsyncLoading();
    
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      if (response.user != null) {
        state = AsyncData(await _getCurrentUser());
      } else {
        state = AsyncError('Authentication failed', StackTrace.current);
      }
    } on AuthException catch (e) {
      state = AsyncError(e.message, StackTrace.current);
    } catch (e) {
      state = AsyncError('An unexpected error occurred', StackTrace.current);
    }
  }
  
  Future<void> signOut() async {
    final supabase = ref.read(supabaseClientProvider);
    
    state = const AsyncLoading();
    
    try {
      await supabase.auth.signOut();
      state = const AsyncData(null);
    } catch (e) {
      state = AsyncError('Failed to sign out', StackTrace.current);
    }
  }
  
  Future<void> updateEmail({required String email}) async {
    final supabase = ref.read(supabaseClientProvider);
    
    try {
      await supabase.auth.updateUser(UserAttributes(
        email: email,
      ));
      
      // Refresh state with updated user info
      state = AsyncData(await _getCurrentUser());
    } on AuthException catch (e) {
      state = AsyncError(e.message, StackTrace.current);
    } catch (e) {
      state = AsyncError('Failed to update email', StackTrace.current);
    }
  }
  
  Future<void> updatePassword({required String password}) async {
    final supabase = ref.read(supabaseClientProvider);
    
    try {
      await supabase.auth.updateUser(UserAttributes(
        password: password,
      ));
      
      // No need to refresh state as password change doesn't affect our user data
    } on AuthException catch (e) {
      state = AsyncError(e.message, StackTrace.current);
    } catch (e) {
      state = AsyncError('Failed to update password', StackTrace.current);
    }
  }
  
  Future<AppUser?> _getCurrentUser() async {
    final supabase = ref.read(supabaseClientProvider);
    final user = supabase.auth.currentUser;
    
    if (user == null) {
      return null;
    }
    
    try {
      final data = await supabase
          .from('users')
          .select()
          .eq('id', user.id)
          .single();
      
      return AppUserMapper.fromMap(data);
    } catch (e) {
      return null;
    }
  }
} 