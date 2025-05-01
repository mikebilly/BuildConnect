import 'package:buildconnect/models/profile_data/profile_data_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:buildconnect/core/constants/supabase_constants.dart';
import 'package:buildconnect/models/profile/profile_model.dart';
import 'package:buildconnect/models/shared/shared_models.dart';

import 'package:buildconnect/models/sub_profiles/architect_profile/architect_profile_model.dart';
import 'package:buildconnect/models/sub_profiles/contractor_profile/contractor_profile_model.dart';
import 'package:buildconnect/models/sub_profiles/supplier_profile/supplier_profile_model.dart';
import 'package:buildconnect/models/sub_profiles/construction_team_profile/construction_team_profile_model.dart';

abstract class IProfileDataService {
  Future<void> upsertProfileData(String userId, ProfileData profileData);
  Future<ProfileData?> getProfileData(String userId);
}

class ProfileDataService implements IProfileDataService {
  final SupabaseClient _supabase;
  ProfileDataService(this._supabase);

  // String? get userId => _supabase.auth.currentUser?.id;

  Future<void> upsertProfile(String? userId, Profile profile) async {
    debugPrint('========================= upsertProfile called');
    debugPrint(
      '========================= attempting to upsertProfile: $userId, profile: $profile',
    );

    if (userId == null) {
      throw Exception('Error at upsert Profile: User ID is null');
    }

    final profileResponse =
        await _supabase
            .from(SupabaseConstants.profilesTable)
            .upsert({
              'user_id': userId,
              'display_name': profile.displayName,
              'profile_type': profile.profileType.name,
              'bio': profile.bio,
              'availability_status': profile.availabilityStatus.name,
              'years_of_experience': profile.yearsOfExperience,
              'working_mode': profile.workingMode.name,
              'business_entity_type': profile.businessEntityType.name,
            }, onConflict: 'user_id')
            .select()
            .maybeSingle();

    debugPrint('🟡 Supabase upsert response: $profileResponse');
    if (profileResponse == null) {
      throw Exception('🛑 Upsert returned null. Profile not saved.');
    }

    final profileId = profileResponse?['id'];
    if (profileId == null) {
      throw Exception('Error at upsert Profile: Profile ID is null');
    }

    final contactsReponse = await _supabase
        .from(SupabaseConstants.profileContactsTable)
        .delete()
        .eq('profile_id', profileId);

    final contactsInserts =
        profile.contacts
            .map(
              (contact) => {
                'profile_id': profileId,
                'contact': contact.toMap(),
              },
            )
            .toList();

    if (contactsInserts.isNotEmpty) {
      await _supabase
          .from(SupabaseConstants.profileContactsTable)
          .insert(contactsInserts);
    }

    // Delete old domains
    await _supabase
        .from('profile_domains')
        .delete()
        .eq('profile_id', profileId);

    // Insert new domains
    final domainInserts =
        profile.domains
            .map((domain) => {'profile_id': profileId, 'domain': domain.name})
            .toList();

    if (domainInserts.isNotEmpty) {
      await _supabase.from('profile_domains').insert(domainInserts);
    }

    await _supabase
        .from('profile_payment_methods')
        .delete()
        .eq('profile_id', profileId);

    final paymentInserts =
        profile.paymentMethods
            .map(
              (method) => {
                'profile_id': profileId,
                'payment_method': method.name,
              },
            )
            .toList();

    if (paymentInserts.isNotEmpty) {
      await _supabase.from('profile_payment_methods').insert(paymentInserts);
    }
  }

  Future<void> upsertSubProfile(String id, ProfileData profileData) async {
    debugPrint('========================= upsertSubProfile called');

    final subProfileMap = profileData.subProfileMap;
    final subProfileTable = profileData.subProfileTable;

    debugPrint('========================= UPSERT subProfileMap $subProfileMap');

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

  Future<Object> fetchSubProfile(String userId, ProfileType profileType) async {
    debugPrint('========================= fetchSubProfile called');
    debugPrint('========================= userId: $userId');
    debugPrint('========================= profileType: $profileType');

    try {
      final subProfileTable = profileType.table;
      final subProfileRes =
          await _supabase
              .from(subProfileTable)
              .select()
              .eq('profile_id', userId)
              .single();

      debugPrint(
        '========================= ProfileDataService fetchSubProfile: $subProfileRes',
      );
      return switch (profileType) {
        ProfileType.architect => ArchitectProfileMapper.fromMap(subProfileRes),
        ProfileType.contractor => ContractorProfileMapper.fromMap(
          subProfileRes,
        ),
        ProfileType.supplier => SupplierProfileMapper.fromMap(subProfileRes),
        ProfileType.constructionTeam => ConstructionTeamProfileMapper.fromMap(
          subProfileRes,
        ),
      };
    } on PostgrestException catch (e) {
      debugPrint('Error at fetch sub profile: $e');
      return {};
    } catch (e) {
      debugPrint('Error at fetch sub profile: $e');
      return {};
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

    try {
      await upsertProfile(userId, profileData.profile);
    } catch (e) {
      debugPrint('Error at upsert Profile: $e');
      throw Exception('Error at upsert Profile: $e');
    }

    // await upsertSubProfile(userId, profileData);

    // await Future.delayed(const Duration(seconds: 5));
  }

  Future<Profile?> fetchProfile(String userId) async {
    debugPrint('========================= fetchProfile called');
    final response =
        await _supabase
            .from(SupabaseConstants.profilesTable)
            .select('*, ${SupabaseConstants.profileContactsTable}(contact)')
            .eq('user_id', userId)
            .maybeSingle();

    if (response == null) {
      debugPrint('Fetched profile but is null <<');
      return Profile.empty();
    }

    final contacts =
        (response['profile_contacts'] as List? ?? [])
            .map(
              (e) =>
                  ContactMapper.fromMap(e['contact'] as Map<String, dynamic>),
            )
            .toList();

    final domains =
        (response['profile_domains'] as List? ?? [])
            .map((e) => Domain.values.byName(e['domain']))
            .toList();

    final paymentMethods =
        (response['profile_payment_methods'] as List? ?? [])
            .map((e) => PaymentMethod.values.byName(e['payment_method']))
            .toList();

    final fullMap =
        Map<String, dynamic>.from(response)
          ..['contacts'] = contacts
          ..['domains'] = domains
          ..['payment_methods'] = paymentMethods;

    debugPrint(
      '========================= ProfileDataService fetchProfile: $fullMap',
    );
    return ProfileMapper.fromMap(fullMap);
  }

  @override
  Future<ProfileData?> getProfileData(String userId) async {
    // await Future.delayed(const Duration(seconds: 1));

    //
    debugPrint('========================= getProfileData called');
    // final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      debugPrint('Error at fetch: User ID is null, cannot fetch profile data.');
      throw Exception('Error at fetch: User ID is null');
    }

    // try {
    //   debugPrint('Hello!!');
    //   final profileDataRes =
    //       await _supabase
    //           .from(SupabaseConstants.profilesTable)
    //           .select()
    //           .eq('user_id', userId)
    //           .single();

    //   debugPrint('');
    //   debugPrint('');
    //   debugPrint(
    //     '%%%%%%%%%%%% *********============ ProfileDataService getProfileData: $profileDataRes',
    //   );
    //   debugPrint('');
    //   debugPrint('');
    //   // return ProfileDataMapper.fromMap(profileDataRes);
    //   return ProfileData.empty();
    // } on PostgrestException catch (e) {
    //   debugPrint('Error at fetch ProfileData: $e');
    //   return ProfileData.empty();
    // } catch (e) {
    //   debugPrint('Error at fetch ProfileData: $e');
    //   return ProfileData.empty();
    // }

    try {
      final fetchedProfile = await fetchProfile(userId);
      if (fetchedProfile == null) {
        debugPrint(
          '++++++++++++++++++++++++++++++++++++ Error at fetch ProfileData: Profile is null',
        );
        return ProfileData.empty();
      }
      final fetchedProfileData = ProfileData.empty().copyWith(
        profile: fetchedProfile,
      );

      return fetchedProfileData;
    } catch (e) {
      debugPrint('Error at fetch ProfileData: $e');
      return ProfileData.empty();
    }
  }
}
