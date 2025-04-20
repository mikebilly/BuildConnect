import 'package:buildconnect/features/auth/providers/auth_service_provider.dart';
import 'package:buildconnect/features/auth/services/auth_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:buildconnect/features/profile_data/providers/profile_data_service_provider.dart';
import 'package:buildconnect/features/profile_data/services/profile_data_service.dart';
import 'package:buildconnect/models/profile_data/profile_data_model.dart';
import 'package:flutter/foundation.dart';
part 'profile_data_provider.g.dart';

@Riverpod(keepAlive: true)
class ProfileDataNotifier extends _$ProfileDataNotifier {
  ProfileDataService get _profileDataService => ref.watch(profileDataServiceProvider);

  AuthService get _authService => ref.watch(authServiceProvider);

  ProfileData? get _data =>
      state.maybeWhen(data: (value) => value, orElse: () => null);

  bool get _isLoggedIn => _authService.isLoggedIn;
  String? get _userId => _authService.currentUserId;

  @override
  FutureOr<ProfileData?> build() async {
    if (!_isLoggedIn || _userId == null) {
      debugPrint("Not logged in");
      return ProfileData.empty();
    }

    return await _profileDataService.getProfileData(_userId ?? '');
  }

  Future<void> updateProfileData() async {
    final data = _data;
    final userId = _userId;

    state = const AsyncLoading();
    // if (data == null || userId == null) return;
    await _profileDataService.upsertProfileData(userId, data);
    state = const AsyncData(null);
  }

  void dumpFromControllers({required String email}) {
    final data = _data;
    if (data == null) return;

    state = AsyncData(data.copyWith(email: email));
  }
}
