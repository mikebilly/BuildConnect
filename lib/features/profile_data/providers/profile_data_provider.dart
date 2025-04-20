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
  late final ProfileDataService _profileDataService;
  late final AuthService _authService;

  @override
  FutureOr<ProfileData?> build() async {
    _authService = ref.read(authServiceProvider);
    _profileDataService = ref.read(profileDataServiceProvider);

    final isLoggedIn = _authService.isLoggedIn;
    // final userId = _authService.currentUserId;
    final userId = "1";
    // if (!isLoggedIn || userId == null) {
    //   debugPrint("Not logged in");
    //   return ProfileData.empty();
    // }

    return await _profileDataService.getProfileData(userId);
  }

  void dumpFromControllers({required String email}) {
    final data = state.value;
    if (data == null) return;

    state = AsyncData(data.copyWith(email: email));
  }
}
