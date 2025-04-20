import 'package:buildconnect/models/profile_data/profile_data_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

abstract class IProfileDataService {
  Future<void> upsertProfileData(String userId, ProfileData profileData);
  Future<ProfileData?> getProfileData(String userId);
  Future<void> deleteProfileData(String userId);
}

class ProfileDataService implements IProfileDataService {
  final SupabaseClient _supabase;

  ProfileDataService(this._supabase);

  @override
  Future<void> upsertProfileData(String userId, ProfileData profileData) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<ProfileData?> getProfileData(String userId) async {
    await Future.delayed(const Duration(seconds: 1));
    final returedProfileData = ProfileData(
      name: 'John Doe',
      email: 'test@gmail.com',
    );
    debugPrint('ProfileDataService getProfileData: $returedProfileData');
    return returedProfileData;
  }

  @override
  Future<void> deleteProfileData(String userId) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
