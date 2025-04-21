import 'package:buildconnect/models/profile_data/profile_data_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:buildconnect/models/enums/enums.dart';

abstract class IProfileDataService {
  Future<void> upsertProfileData(String userId, ProfileData profileData);
  Future<ProfileData?> getProfileData(String userId);
}

class ProfileDataService implements IProfileDataService {
  final SupabaseClient _supabase;

  ProfileDataService(this._supabase);

  @override
  Future<void> upsertProfileData(String? userId, ProfileData? profileData) async {
    await Future.delayed(const Duration(seconds: 5));
  }

  @override
  Future<ProfileData?> getProfileData(String userId) async {
    await Future.delayed(const Duration(seconds: 1));
    final returedProfileData = ProfileData(
      displayName: 'xyz',
      profileType: ProfileType.architect,
      portfolioLinks: [],
      designStyles: [],
    );
    debugPrint('ProfileDataService getProfileData: $returedProfileData');
    return returedProfileData;
  }
}
