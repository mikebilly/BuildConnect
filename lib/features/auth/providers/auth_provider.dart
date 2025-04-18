import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:buildconnect/models/app_user/app_user_model.dart';
import 'package:buildconnect/features/auth/services/auth_service.dart';
import 'package:buildconnect/features/auth/providers/auth_service_provider.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  late final AuthService _auth;

  @override
  FutureOr<AppUser?> build() async {
    _auth = ref.watch(authServiceProvider);

    if (!_auth.isLoggedIn) {
      return null;
    }

    return await _auth.fetchAppUser();
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    try {
      await _auth.signIn(email, password);
      final user = await _auth.fetchAppUser();
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    await _auth.signOut();
    state = const AsyncData(null);
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    try {
      await _auth.signUp(email, password);
      final user = await _auth.fetchAppUser();
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}