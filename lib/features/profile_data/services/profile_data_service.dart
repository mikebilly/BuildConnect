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

  Future<Profile> upsertProfile(String? userId, Profile profile) async {
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

    final profileId = profileResponse['id'];
    if (profileId == null) {
      throw Exception('Error at upsert Profile: Profile ID is null');
    }

    // 🔄 Replace old contacts
    await _supabase
        .from(SupabaseConstants.profileContactsTable)
        .delete()
        .eq('profile_id', profileId);

    final contacts = profile.contacts;
    final contactsInserts =
        contacts
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

    // 🔄 Replace old domains
    await _supabase
        .from('profile_domains')
        .delete()
        .eq('profile_id', profileId);
    final domains = profile.domains;
    final domainInserts =
        domains
            .map((domain) => {'profile_id': profileId, 'domain': domain.name})
            .toList();
    if (domainInserts.isNotEmpty) {
      await _supabase.from('profile_domains').insert(domainInserts);
    }

    // 🔄 Replace old payment methods
    await _supabase
        .from('profile_payment_methods')
        .delete()
        .eq('profile_id', profileId);
    final paymentMethods = profile.paymentMethods;
    final paymentInserts =
        paymentMethods
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

    // ✅ Return reconstructed Profile
    final fullMap = {
      ...profileResponse,
      'contacts': contacts,
      'domains': domains,
      'payment_methods': paymentMethods,
    };

    return ProfileMapper.fromMap(fullMap);
  }

  Future<void> upsertSubProfile(
    String profileId,
    ProfileData profileData,
  ) async {
    debugPrint('========================= upsertSubProfile called');

    try {
      switch (profileData.profile.profileType) {
        case ProfileType.architect:
          final architect = profileData.architectProfile;
          if (architect == null) return;

          await _supabase.from('architect_profiles').upsert({
            'profile_id': profileId,
            'architect_role': architect.architectRole.name,
            'design_philosophy': architect.designPhilosophy,
          }, onConflict: 'profile_id');

          await _supabase
              .from('architect_design_styles')
              .delete()
              .eq('profile_id', profileId);

          final designStyleInserts =
              architect.designStyles
                  .map(
                    (style) => {
                      'profile_id': profileId,
                      'design_style': style.name,
                    },
                  )
                  .toList();

          if (designStyleInserts.isNotEmpty) {
            await _supabase
                .from('architect_design_styles')
                .insert(designStyleInserts);
          }

          await _supabase
              .from('architect_portfolio_links')
              .delete()
              .eq('profile_id', profileId);

          final linkInserts =
              architect.portfolioLinks
                  .map(
                    (url) => {'profile_id': profileId, 'portfolio_link': url},
                  )
                  .toList();

          if (linkInserts.isNotEmpty) {
            await _supabase
                .from('architect_portfolio_links')
                .insert(linkInserts);
          }

          break;

        case ProfileType.contractor:
          final contractor = profileData.contractorProfile;
          if (contractor == null) return;

          await _supabase.from('contractor_profiles').upsert({
            'profile_id': profileId,
          }, onConflict: 'profile_id');

          await _supabase
              .from('contractor_services')
              .delete()
              .eq('profile_id', profileId);

          final contractorServices =
              contractor.services
                  .map((s) => {'profile_id': profileId, 'service_type': s.name})
                  .toList();

          if (contractorServices.isNotEmpty) {
            await _supabase
                .from('contractor_services')
                .insert(contractorServices);
          }

          break;

        case ProfileType.supplier:
          final supplier = profileData.supplierProfile;
          if (supplier == null) return;

          await _supabase.from('supplier_profiles').upsert({
            'profile_id': profileId,
            'supplier_type': supplier.supplierType.name,
            'delivery_radius': supplier.deliveryRadius,
          }, onConflict: 'profile_id');

          await _supabase
              .from('supplier_material_categories')
              .delete()
              .eq('profile_id', profileId);

          final materials =
              supplier.materialCategories
                  .map(
                    (m) => {
                      'profile_id': profileId,
                      'material_category': m.name,
                    },
                  )
                  .toList();

          if (materials.isNotEmpty) {
            await _supabase
                .from('supplier_material_categories')
                .insert(materials);
          }

          break;

        case ProfileType.constructionTeam:
          final team = profileData.constructionTeamProfile;
          if (team == null) return;

          await _supabase.from('construction_team_profiles').upsert({
            'profile_id': profileId,
            'representative_name': team.representativeName,
            'representative_phone': team.representativePhone,
            'team_size': team.teamSize,
          }, onConflict: 'profile_id');

          await _supabase
              .from('construction_team_services')
              .delete()
              .eq('profile_id', profileId);

          final teamServices =
              team.services
                  .map((s) => {'profile_id': profileId, 'service_type': s.name})
                  .toList();

          if (teamServices.isNotEmpty) {
            await _supabase
                .from('construction_team_services')
                .insert(teamServices);
          }

          break;
      }
    } catch (e) {
      debugPrint('❌ Error at upsert SUBPROFILE: $e');
      throw Exception('Error at upsert SUBPROFILE: $e');
    }
  }

  Future<Object> fetchSubProfile(
    String profileId,
    ProfileType profileType,
  ) async {
    debugPrint('========================= fetchSubProfile called');
    debugPrint('========================= profileId: $profileId');
    debugPrint('========================= profileType: $profileType');

    try {
      switch (profileType) {
        case ProfileType.architect:
          final architect =
              await _supabase
                  .from(SupabaseConstants.architectProfilesTable)
                  .select()
                  .eq('profile_id', profileId)
                  .maybeSingle();

          if (architect == null) {
            debugPrint('Architect profile is null');
            return ArchitectProfile.empty();
          }

          final designStylesRes = await _supabase
              .from(SupabaseConstants.architectDesignStylesTable)
              .select()
              .eq('profile_id', profileId);

          final portfolioLinksRes = await _supabase
              .from(SupabaseConstants.architectPortfolioLinksTable)
              .select()
              .eq('profile_id', profileId);

          return ArchitectProfileMapper.fromMap({
            ...architect,
            'design_styles':
                designStylesRes.map((e) => e['design_style']).toList(),
            'portfolio_links':
                portfolioLinksRes.map((e) => e['portfolio_link']).toList(),
          });

        case ProfileType.contractor:
          final contractor =
              await _supabase
                  .from(SupabaseConstants.contractorProfilesTable)
                  .select()
                  .eq('profile_id', profileId)
                  .maybeSingle();
          if (contractor == null) {
            debugPrint('Contractor profile is null');
            return ContractorProfile.empty();
          }

          final servicesRes = await _supabase
              .from(SupabaseConstants.contractorServicesTable)
              .select()
              .eq('profile_id', profileId);

          return ContractorProfileMapper.fromMap({
            ...contractor,
            'services': servicesRes.map((e) => e['service_type']).toList(),
          });

        case ProfileType.supplier:
          final supplier =
              await _supabase
                  .from(SupabaseConstants.supplierProfilesTable)
                  .select()
                  .eq('profile_id', profileId)
                  .maybeSingle();

          if (supplier == null) {
            debugPrint('Supplier profile is null');
            return SupplierProfile.empty();
          }

          final materialCategoriesRes = await _supabase
              .from(SupabaseConstants.supplierMaterialCategoriesTable)
              .select()
              .eq('profile_id', profileId);

          return SupplierProfileMapper.fromMap({
            ...supplier,
            'material_categories':
                materialCategoriesRes
                    .map((e) => e['material_category'])
                    .toList(),
          });

        case ProfileType.constructionTeam:
          final constructionTeam =
              await _supabase
                  .from(SupabaseConstants.constructionTeamProfilesTable)
                  .select()
                  .eq('profile_id', profileId)
                  .maybeSingle();

          if (constructionTeam == null) {
            debugPrint('Construction team profile is null');
            return ConstructionTeamProfile.empty();
          }

          final servicesRes = await _supabase
              .from(SupabaseConstants.constructionTeamServicesTable)
              .select()
              .eq('profile_id', profileId);

          return ConstructionTeamProfileMapper.fromMap({
            ...constructionTeam,
            'services': servicesRes.map((e) => e['service_type']).toList(),
          });
      }
    } catch (e) {
      debugPrint('Error at fetch SUBPROFILE: $e');
      throw Exception('Error at fetch SUBPROFILE: $e');
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
      final savedProfile = await upsertProfile(userId, profileData.profile);
      await upsertSubProfile(savedProfile.id!, profileData);
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
        debugPrint('❌ Error at fetch ProfileData: Profile is null');
        return ProfileData.empty();
      }

      final profile = ProfileMapper.fromMap(fetchedProfile.toMap());

      // Fetch subprofile depending on profile type
      Object? fetchedSubProfile;
      try {
        fetchedSubProfile = await fetchSubProfile(
          profile.id!,
          profile.profileType,
        );
      } catch (e) {
        debugPrint('⚠️ Failed to fetch subprofile: $e');
        // Continue without throwing to return base profile
      }

      // Compose result
      final profileData = switch (profile.profileType) {
        ProfileType.architect => ProfileData(
          profile: profile,
          architectProfile: fetchedSubProfile as ArchitectProfile?,
        ),
        ProfileType.contractor => ProfileData(
          profile: profile,
          contractorProfile: fetchedSubProfile as ContractorProfile?,
        ),
        ProfileType.supplier => ProfileData(
          profile: profile,
          supplierProfile: fetchedSubProfile as SupplierProfile?,
        ),
        ProfileType.constructionTeam => ProfileData(
          profile: profile,
          constructionTeamProfile:
              fetchedSubProfile as ConstructionTeamProfile?,
        ),
      };

      return profileData;
    } catch (e) {
      debugPrint('❌ Error at fetch ProfileData: $e');
      return ProfileData.empty();
    }
  }
}
