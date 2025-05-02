import 'package:flutter/rendering.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:buildconnect/models/app_user/app_user_model.dart';
import 'package:buildconnect/features/auth/services/auth_service.dart';
import 'package:buildconnect/features/auth/providers/auth_service_provider.dart';

import 'package:buildconnect/features/profile_data/providers/profile_data_provider.dart';
part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  late final AuthService _authService;
  late final ProfileDataNotifier _profileDataNotifier;

  @override
  FutureOr<AppUser?> build() async {
    _authService = ref.watch(authServiceProvider);
    _profileDataNotifier = ref.read(profileDataNotifierProvider.notifier);

    if (!_authService.isLoggedIn) {
      return null;
    }

    return await _authService.fetchAppUser();
  }

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncLoading();

    try {
      await _authService.signIn(email, password);
      final user = await _authService.fetchAppUser();
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void invalidateProviders() {
    debugPrint('%%%%%%%%%%%%%%%%%Invalidating providers');
    ref.invalidate(profileDataNotifierProvider);
    ref.invalidate(profileDataByUserIdProvider);
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    await _authService.signOut();

    // await _profileDataNotifier.clearProfileData();
    invalidateProviders();
    state = const AsyncData(null);
  }

  Future<void> signUp({required String email, required String password}) async {
    state = const AsyncLoading();

    try {
      await _authService.signUp(email, password);
      final user = await _authService.fetchAppUser();
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
