import 'package:buildconnect/models/profile_data/profile_data_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:buildconnect/core/constants/supabase_constants.dart';
import 'package:buildconnect/models/profile/profile_model.dart';

abstract class IProfileDataService {
  Future<void> upsertProfileData(String userId, ProfileData profileData);
  Future<ProfileData?> getProfileData(String userId);
}

class ProfileDataService implements IProfileDataService {
  final SupabaseClient _supabase;

  ProfileDataService(this._supabase);

  Future<void> upsertProfile(String userId, Profile profile) async {
    debugPrint('========================= upsertProfile called');
    debugPrint(
      '========================= attempting to upsertProfile: $userId, profile: $profile',
    );
    final profileMap = profile.toMap();
    debugPrint('========================= UPSERT profileMap $profileMap');

    try {
      final response =
          await _supabase
              .from(SupabaseConstants.profilesTable)
              .upsert(profileMap, onConflict: 'user_id')
              .select();
    } on PostgrestException catch (e) {
      debugPrint('Error at upsert PROFILE: $e');
      throw Exception('Error at upsert PROFILE: $e');
    } catch (e) {
      debugPrint('Error at upsert PROFILE: $e');
    }
  }

  Future<void> upsertSubProfile(String id, ProfileData profileData) async {
    debugPrint('========================= upsertSubProfile called');

    final subProfileMap = profileData.subProfileMap;    
    final subProfileTable = profileData.subProfileTable;

    debugPrint(
      '========================= UPSERT subProfileMap $subProfileMap',
    );

    try {
      final response =
          await _supabase
              .from(subProfileTable)
              .upsert(subProfileMap, onConflict: 'profile_id')
              .select();

      debugPrint('========================= UPSERT response $response');
    } on PostgrestException catch (e) {
      debugPrint('Error at upsert SUBPROFILE: $e');
      throw Exception('Error at upsert SUBPROFILE: $e');
    } catch (e) {
      debugPrint('Error at upsert SUBPROFILE: $e');
    }
  }

  Future<Profile> fetchProfile(String userId) async {
    debugPrint('========================= fetchProfile called');
    debugPrint('========================= userId: $userId');

    try {
      final profileRes = await _supabase
          .from(SupabaseConstants.profilesTable)
          .select()
          .eq('user_id', userId)
          .single();

      debugPrint(
        '========================= ProfileDataService fetchProfile: $profileRes',
      );
      return ProfileMapper.fromMap(profileRes);
    } on PostgrestException catch (e) {
      debugPrint('Error at fetch: $e');
      return Profile.empty();
    } catch (e) {
      debugPrint('Error at fetch: $e');
      return Profile.empty();
    }
  }

  @override
  Future<void> upsertProfileData(
    String? userId,
    ProfileData? profileData,
  ) async {
    debugPrint("========================= upsertProfileData called");
    debugPrint(
      '========================= attempting to upsertProfileData: $userId, profileData: $profileData',
    );

    if (userId == null) {
      debugPrint(
        'Error at upsert: User ID is null, cannot upsert profile data.',
      );
      throw Exception('Error at upsert ProfileData: User ID is null');
    }

    if (profileData == null) {
      debugPrint(
        'Error at upsert: ProfileData is null, cannot upsert profile data.',
      );
      throw Exception('Error at upsert ProfileData: ProfileData is null');
    }

    await upsertProfile(userId, profileData.profile);
    await upsertSubProfile(userId, profileData);

    // await Future.delayed(const Duration(seconds: 5));
  }

  @override
  Future<ProfileData?> getProfileData(String userId) async {
    // await Future.delayed(const Duration(seconds: 1));

    //
    // debugPrint('========================= getProfileData called');
    // final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      debugPrint('Error at fetch: User ID is null, cannot fetch profile data.');
      throw Exception('Error at fetch: User ID is null');
    }

    try {
      final profileDataRes =
          await _supabase
              .from(SupabaseConstants.profilesTable)
              .select()
              .eq('user_id', userId)
              .single();

      debugPrint(
        '========================= ProfileDataService getProfileData: $profileDataRes',
      );
      return ProfileDataMapper.fromMap(profileDataRes);
    } on PostgrestException catch (e) {
      debugPrint('Error at fetch: $e');
      return ProfileData.empty();
    } catch (e) {
      debugPrint('Error at fetch: $e');
      return ProfileData.empty();
    }
  }
}
