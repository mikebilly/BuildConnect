import 'package:buildconnect/features/auth/providers/auth_service_provider.dart';
import 'package:buildconnect/features/auth/services/auth_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:buildconnect/features/profile_data/providers/profile_data_service_provider.dart';
import 'package:buildconnect/features/profile_data/services/profile_data_service.dart';
import 'package:buildconnect/models/profile_data/profile_data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:buildconnect/models/enums/enums.dart';

part 'profile_data_provider.g.dart';

@Riverpod(keepAlive: true)
class ProfileDataNotifier extends _$ProfileDataNotifier {
  ProfileDataService get _profileDataService =>
      ref.watch(profileDataServiceProvider);

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

  // Future<void> dumpFromControllers({
  //   String? displayName,
  //   ProfileType? profileType,
  //   // add other fields here
  // }) async {
  //   final data = _data;
  //   if (data == null) {
  //     debugPrint("Data is null, cannot update");
  //     return;
  //   }
  //   debugPrint('Loading...');
  //   state = const AsyncLoading();
  //   debugPrint('profileType saved: $profileType');

  //   state = AsyncData(
  //     data.copyWith(
  //       displayName: displayName ?? data.displayName,
  //       // displayName: displayName ?? data.displayName,
  //       profileType: profileType ?? data.profileType,
  //     ),
  //   );
  //   debugPrint('Finished dumping');
  // }

  Future<ProfileData> dumpFromControllers({
    String? displayName,
    ProfileType? profileType,
    List<String>? portfolioLinks,
    List<DesignStyle>? designStyles,
  }) async {
    final data = _data;
    if (data == null) throw Exception("Data is null");

    state = const AsyncLoading();

    // Optional: simulate a delay or real async save
    // await Future.delayed(const Duration(milliseconds: 500));

    final updatedData = data.copyWith(
      displayName: displayName ?? data.displayName,
      profileType: profileType ?? data.profileType,
      portfolioLinks: portfolioLinks ?? data.portfolioLinks,
      designStyles: designStyles ?? data.designStyles,
    );

    state = AsyncData(updatedData);

    return updatedData;
  }
}
