import 'package:buildconnect/core/constants/supabase_constants.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:buildconnect/models/profile/profile_model.dart';
import 'package:buildconnect/models/search_profile/search_profile_model.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:math' as Math;

class SearchProfileService {
  final SupabaseClient _supabaseClient;
  SearchProfileService(this._supabaseClient);

  Future<List<Profile>?> searchProfile(SearchProfileModel model) async {
    debugPrint('Going to search profile with ${model.toString()}');

    // Log filter configuration
    if (model.cityList.isEmpty) {
      debugPrint('No location chosen - accepting all locations');
    }
    if (model.profileType.isEmpty) {
      debugPrint('No profile type chosen - accepting all profile types');
    }

    // 1. Fetch all profiles from Supabase (without name filtering)
    var query = '''
      *,
      profile_operating_areas(city),
      profile_contacts(contact),
      profile_domains(domain),
      profile_payment_methods(payment_method)
    ''';
    
    var builder = _supabaseClient
        .from(SupabaseConstants.profilesTable)
        .select(query);

    final rawData = await builder as List<dynamic>;
    debugPrint('Initial query returned ${rawData.length} profiles');
    
    final allProfiles =
        rawData.map((row) => ProfileMapperExt.fromSupabaseMap(row)).toList();
    
    var result = List<Profile>.from(allProfiles);
    
    // 1.b Filter by display name in Dart code if query is not empty
    if (model.query.isNotEmpty) {
      final searchQuery = model.query.toLowerCase();
      debugPrint('Filtering for display_name containing: "$searchQuery" (in Dart)');
      
      result = result.where((profile) => 
        profile.displayName != null && 
        profile.displayName!.toLowerCase().contains(searchQuery)
      ).toList();
      
      debugPrint('After display name filtering: ${result.length} profiles');
      
      // Debug: Print first few profile display names to verify search worked
      if (result.isNotEmpty) {
        debugPrint('Sample matched display names:');
        for (int i = 0; i < Math.min(3, result.length); i++) {
          debugPrint('- "${result[i].displayName}"');
        }
      }
    }

    // 2. Filter by city if cityList is not empty
    if (model.cityList.isNotEmpty) {
      result = result.where((profile) {
        return model.cityList.any(
          (city) => profile.operatingAreas.contains(city),
        );
      }).toList();
      debugPrint('After city filtering: ${result.length} profiles');
    }

    // 3. Filter by profileType if not empty
    if (model.profileType.isNotEmpty) {
      result = result.where((profile) {
        return model.profileType.contains(profile.profileType);
      }).toList();
      debugPrint('After profile type filtering: ${result.length} profiles');
    }

    // If no profile-specific filtering needed, return current results
    if (model.profileType.isEmpty ||
        (!_hasSpecificFilters(model.architectFilterModel) &&
         !_hasSpecificFilters(model.constructionTeamFilterModel) &&
         !_hasSpecificFilters(model.contractorFilterModel) &&
         !_hasSpecificFilters(model.supplierFilterModel))) {
      return result;
    }

    // 4. Create a set of valid profile IDs for each type
    Map<ProfileType, Set<String>> validProfileIds = {
      ProfileType.architect: _getProfileIdsForType(result, ProfileType.architect),
      ProfileType.contractor: _getProfileIdsForType(result, ProfileType.contractor),
      ProfileType.constructionTeam: _getProfileIdsForType(result, ProfileType.constructionTeam),
      ProfileType.supplier: _getProfileIdsForType(result, ProfileType.supplier),
    };
    
    // Track which profile types need specific filtering
    Map<ProfileType, bool> needsSpecificFiltering = {
      ProfileType.architect: model.profileType.contains(ProfileType.architect) &&
          model.architectFilterModel != null &&
          model.architectFilterModel!.designStyle.isNotEmpty,
      ProfileType.constructionTeam: model.profileType.contains(ProfileType.constructionTeam) &&
          model.constructionTeamFilterModel != null &&
          model.constructionTeamFilterModel!.serviceType.isNotEmpty,
      ProfileType.contractor: model.profileType.contains(ProfileType.contractor) &&
          model.contractorFilterModel != null &&
          model.contractorFilterModel!.serviceType.isNotEmpty,
      ProfileType.supplier: model.profileType.contains(ProfileType.supplier) &&
          model.supplierFilterModel != null &&
          model.supplierFilterModel!.materialCategory.isNotEmpty,
    };

    // 5. Apply specific filters for each profile type
    
    // Filter architects by design style
    if (needsSpecificFiltering[ProfileType.architect]!) {
      final designStyles = model.architectFilterModel!.designStyle.map((e) => e.name).toList();
      debugPrint('Filtering architects by design styles: $designStyles');
      
      final profileIdsArchitect = await _supabaseClient
          .from(SupabaseConstants.architectDesignStylesTable)
          .select('profile_id, design_style');
      
      Set<String> filteredArchitectIds = {};
      for (final p in profileIdsArchitect) {
        if (designStyles.contains(p['design_style']) && 
            validProfileIds[ProfileType.architect]!.contains(p['profile_id'])) {
          filteredArchitectIds.add(p['profile_id']);
        }
      }
      
      validProfileIds[ProfileType.architect] = filteredArchitectIds;
      debugPrint('After design style filtering: ${filteredArchitectIds.length} architects');
    }
    
    // Filter construction teams by service type
    if (needsSpecificFiltering[ProfileType.constructionTeam]!) {
      final serviceTypes = model.constructionTeamFilterModel!.serviceType
          .map((e) => e.name)
          .toList();
      debugPrint('Filtering construction teams by service types: $serviceTypes');
      
      final profileIdsTeam = await _supabaseClient
          .from(SupabaseConstants.constructionTeamServicesTable)
          .select('profile_id, service_type');
      
      Set<String> filteredTeamIds = {};
      for (final p in profileIdsTeam) {
        if (serviceTypes.contains(p['service_type']) &&
            validProfileIds[ProfileType.constructionTeam]!.contains(p['profile_id'])) {
          filteredTeamIds.add(p['profile_id']);
        }
      }
      
      validProfileIds[ProfileType.constructionTeam] = filteredTeamIds;
      debugPrint('After service type filtering: ${filteredTeamIds.length} construction teams');
    }
    
    // Filter contractors by service type
    if (needsSpecificFiltering[ProfileType.contractor]!) {
      final serviceTypes = model.contractorFilterModel!.serviceType
          .map((e) => e.name)
          .toList();
      debugPrint('Filtering contractors by service types: $serviceTypes');
      
      final profileIdsContractor = await _supabaseClient
          .from(SupabaseConstants.contractorServicesTable)
          .select('profile_id, service_type');
      
      Set<String> filteredContractorIds = {};
      for (final p in profileIdsContractor) {
        if (serviceTypes.contains(p['service_type']) &&
            validProfileIds[ProfileType.contractor]!.contains(p['profile_id'])) {
          filteredContractorIds.add(p['profile_id']);
        }
      }
      
      validProfileIds[ProfileType.contractor] = filteredContractorIds;
      debugPrint('After service type filtering: ${filteredContractorIds.length} contractors');
    }
    
    // Filter suppliers by material category
    if (needsSpecificFiltering[ProfileType.supplier]!) {
      final materialCategories = model.supplierFilterModel!.materialCategory
          .map((e) => e.name)
          .toList();
      debugPrint('Filtering suppliers by material categories: $materialCategories');
      
      final profileIdsSupplier = await _supabaseClient
          .from(SupabaseConstants.supplierMaterialCategoriesTable)
          .select('profile_id, material_category');
      
      Set<String> filteredSupplierIds = {};
      for (final p in profileIdsSupplier) {
        if (materialCategories.contains(p['material_category']) &&
            validProfileIds[ProfileType.supplier]!.contains(p['profile_id'])) {
          filteredSupplierIds.add(p['profile_id']);
        }
      }
      
      validProfileIds[ProfileType.supplier] = filteredSupplierIds;
      debugPrint('After material category filtering: ${filteredSupplierIds.length} suppliers');
    }

    // 6. Combine all valid profile IDs
    Set<String> finalProfileIds = {};
    for (final type in ProfileType.values) {
      // Only include profile types that were requested or all if none requested
      if (model.profileType.isEmpty || model.profileType.contains(type)) {
        // For types that need specific filtering, use the filtered IDs
        // For types that don't need specific filtering, use all IDs of that type
        if (needsSpecificFiltering[type] == true) {
          finalProfileIds.addAll(validProfileIds[type] ?? {});
        } else {
          finalProfileIds.addAll(_getProfileIdsForType(result, type));
        }
      }
    }
    
    // 7. Filter profiles to include only those with IDs in the final set
    if (finalProfileIds.isNotEmpty) {
      result = result.where((profile) => 
        profile.id != null && finalProfileIds.contains(profile.id)
      ).toList();
    }
    
    // Final debug output
    debugPrint('Final result count: ${result.length} profiles');
    if (result.isNotEmpty) {
      debugPrint('Sample results display names:');
      for (int i = 0; i < Math.min(3, result.length); i++) {
        debugPrint('- "${result[i].displayName}"');
      }
    }
    
    return result;
  }
  
  // Helper method to check if specific filters are applied
  bool _hasSpecificFilters(dynamic filterModel) {
    if (filterModel == null) return false;
    
    if (filterModel is ArchitectFilterModel) {
      return filterModel.designStyle.isNotEmpty;
    } else if (filterModel is ConstructionTeamFilterModel) {
      return filterModel.serviceType.isNotEmpty;
    } else if (filterModel is ContractorFilterModel) {
      return filterModel.serviceType.isNotEmpty;
    } else if (filterModel is SupplierFilterModel) {
      return filterModel.materialCategory.isNotEmpty;
    }
    
    return false;
  }
  
  // Helper to get profile IDs of a specific type from a list
  Set<String> _getProfileIdsForType(List<Profile> profiles, ProfileType type) {
    return profiles
        .where((profile) => profile.profileType == type && profile.id != null)
        .map((profile) => profile.id!)
        .toSet();
  }
}