import 'package:buildconnect/features/auth/providers/auth_service_provider.dart';
import 'package:buildconnect/features/auth/services/auth_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:buildconnect/features/profile_data/providers/profile_data_service_provider.dart';
import 'package:buildconnect/features/profile_data/services/profile_data_service.dart';
import 'package:buildconnect/models/profile_data/profile_data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:buildconnect/models/shared/shared_models.dart';

import 'package:buildconnect/models/profile/profile_model.dart';
import 'package:buildconnect/models/sub_profiles/architect_profile/architect_profile_model.dart';
import 'package:buildconnect/models/sub_profiles/contractor_profile/contractor_profile_model.dart';
import 'package:buildconnect/models/sub_profiles/supplier_profile/supplier_profile_model.dart';
import 'package:buildconnect/models/sub_profiles/construction_team_profile/construction_team_profile_model.dart';

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

 Future<ProfileData> dumpFromControllers({
    Profile? profile,

    ArchitectProfile? architectProfile,
    ContractorProfile? contractorProfile,
    ConstructionTeamProfile? constructionTeamProfile,
    SupplierProfile? supplierProfile,

    List<Contact>? contacts,
  }) async {
    final data = _data;
    final userId = _userId;
    if (data == null) throw Exception("Data is null");

    state = const AsyncLoading();

    // Optional: simulate a delay or real async save
    // await Future.delayed(const Duration(milliseconds: 500));

    final newProfile = (profile != null ? profile.copyWith(userId: userId, contacts: data.profile.contacts) : (contacts != null ? data.profile.copyWith(contacts: contacts) : data.profile));
    final newArchitectProfile = (architectProfile != null ? architectProfile.copyWith(profileId: userId) : data.architectProfile);
    final newContractorProfile = (contractorProfile != null ? contractorProfile.copyWith(profileId: userId) : data.contractorProfile);
    final newConstructionTeamProfile = (constructionTeamProfile != null ? constructionTeamProfile.copyWith(profileId: userId) : data.constructionTeamProfile);
    final newSupplierProfile = (supplierProfile != null ? supplierProfile.copyWith(profileId: userId) : data.supplierProfile);

    final updatedData = data.copyWith(
      profile: newProfile,
      architectProfile: newArchitectProfile,
      contractorProfile: newContractorProfile,
      constructionTeamProfile: newConstructionTeamProfile,
      supplierProfile: newSupplierProfile,
    );

    debugPrint('Updated data: $updatedData');

    state = AsyncData(updatedData);

    return updatedData;
  }
}
