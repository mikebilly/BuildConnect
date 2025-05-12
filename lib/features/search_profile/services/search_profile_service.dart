import 'package:buildconnect/core/constants/supabase_constants.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:buildconnect/models/profile/profile_model.dart';
import 'package:buildconnect/models/search_profile/search_profile_model.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SearchProfileService {
  final SupabaseClient _supabaseClient;
  SearchProfileService(this._supabaseClient);

  Future<List<Profile>?> searchProfile(SearchProfileModel model) async {
    if (model.cityList.isEmpty) {
      debugPrint('no location choose');
    }
    if (model.profileType.isEmpty) {
      debugPrint('no profile type choose');
    }
    debugPrint(model.profileType.toString());
    debugPrint('going to search profile with ${model.toString()}');
    final builder = _supabaseClient
        .from(SupabaseConstants.profilesTable)
        .select('''
      *,
      profile_operating_areas(city),
      profile_contacts(contact),
      profile_domains(domain),
      profile_payment_methods(payment_method)
    ''')
        .ilike('display_name', '%${model.query}%');

    final rawData = await builder as List<dynamic>;
    final profileList =
        rawData.map((row) => ProfileMapperExt.fromSupabaseMap(row)).toList();
    // var result = <Profile>[];

    var result = List<Profile>.from(profileList);

    // 2) Nếu có cityList và không rỗng → lọc theo city
    if (model.cityList.isNotEmpty) {
      result =
          result.where((profile) {
            // Có ít nhất 1 city trong model.cityList khớp với profile.operatingAreas
            return model.cityList.any(
              (city) => profile.operatingAreas.contains(city),
            );
          }).toList();
    }

    // 3) Nếu có profileType và không rỗng → lọc theo profileType
    if (model.profileType.isNotEmpty) {
      result =
          result.where((profile) {
            return model.profileType.contains(profile.profileType);
          }).toList();
    }
    debugPrint('result length is : ${result.length}');
    Map<ProfileType, Set<String>> resultByEachProfileType = {
      ProfileType.architect: {},
      ProfileType.contractor: {},
      ProfileType.constructionTeam: {},
      ProfileType.supplier: {},
    };

    for (final p in result) {
      debugPrint('p in result: ${p.profileType}: ${p.id}');
      // nếu profileType của profile nằm trong list model.profileType thì thêm vào resultByEachProfileType
      if (model.profileType.contains(p.profileType)) {
        debugPrint('profile type ${p.profileType} is in model.profileType');
        if (p.id != null) {
          resultByEachProfileType[p.profileType]!.add(p.id!);
          debugPrint('add successfully');
        }
      }
      debugPrint(' oke more than 1 profile type');
    }
    // print map
    debugPrint('resultByEachProfileType: $resultByEachProfileType');
    Set<String> eachProfileIds = {};
    // lấy unique profile_id của bảng architect_design_style với cột design_style chứa một trong các design_style của model.architectFilterModel.designStyle
    if (model.architectFilterModel != null &&
        model.architectFilterModel!.designStyle.isNotEmpty) {
      debugPrint(
        'Chuẩn bị lọc với design style: ${model.architectFilterModel!.designStyle.toString()}',
      );
      final designStyles =
          model.architectFilterModel!.designStyle.map((e) => e.name).toList();
      debugPrint(designStyles.toString());
      final profileIds_architect = await _supabaseClient
          .from(SupabaseConstants.architectDesignStylesTable)
          .select('profile_id, design_style');

      // Set<String> profile_Ids_architect = {};
      for (final p in profileIds_architect) {
        if (designStyles.contains(p['design_style']) &&
            result.any((profile) => profile.id == p['profile_id'])) {
          debugPrint(
            'designStyle of profile_id ${p['profile_id']} is ${p['design_style']}',
          );
          eachProfileIds.add(p['profile_id']);
        }
      }
      debugPrint(
        'profile_id của architect trước khi lọc: ${resultByEachProfileType[ProfileType.architect]}',
      );

      // có list chứa các profile_id lọc thành công, có map<architect, List<String>> chứa các profile_id theo architect, giờ lọc tiếp
      resultByEachProfileType[ProfileType.architect] = eachProfileIds;
      debugPrint(
        'profile_id của map sau khi lọc với architect: ${resultByEachProfileType[ProfileType.architect]}',
      );
    }
    debugPrint(
      'profile after filter with design style: ${eachProfileIds.length}',
    );
    eachProfileIds = {};
    if (model.constructionTeamFilterModel != null &&
        model.constructionTeamFilterModel!.serviceType.isNotEmpty) {
      final serviceTypes =
          model.constructionTeamFilterModel!.serviceType
              .map((e) => e.name)
              .toList();

      final profileIds_construction_team = await _supabaseClient
          .from(SupabaseConstants.constructionTeamServicesTable)
          .select('profile_id, service_type');
      // Set<String> profile_Ids_construction_team = {};
      for (final p in profileIds_construction_team) {
        if (serviceTypes.contains(p['service_type'])) {
          eachProfileIds.add(p['profile_id']);
        }
      }
    }
    eachProfileIds = {};
    if (model.contractorFilterModel != null &&
        model.contractorFilterModel!.serviceType.isNotEmpty) {
      final serviceTypes =
          model.contractorFilterModel!.serviceType.map((e) => e.name).toList();

      final profileIds_contractor = await _supabaseClient
          .from(SupabaseConstants.contractorServicesTable)
          .select('profile_id, service_type');
      // Set<String> profile_Ids_contractor = {};
      for (final p in profileIds_contractor) {
        if (serviceTypes.contains(p['service_type'])) {
          eachProfileIds.add(p['profile_id']);
        }
      }
      debugPrint('profile_id list sau khi lọc với contractor: $eachProfileIds');
    }
    eachProfileIds = {};
    if (model.supplierFilterModel != null &&
        model.supplierFilterModel!.materialCategory.isNotEmpty) {
      final materialCategories =
          model.supplierFilterModel!.materialCategory
              .map((e) => e.name)
              .toList();

      final profileIds_supplier = await _supabaseClient
          .from(SupabaseConstants.supplierMaterialCategoriesTable)
          .select('profile_id, material_category');
      // Set<String> profile_Ids_supplier = {};
      for (final p in profileIds_supplier) {
        if (materialCategories.contains(p['material_category'])) {
          eachProfileIds.add(p['profile_id']);
        }
      }
    }
    var final_profile_ids = [];
    for (final entry in resultByEachProfileType.entries) {
      final profileIds = entry.value;
      final_profile_ids.addAll(profileIds);
    }
    result =
        result
            .where((profile) => final_profile_ids.contains(profile.id))
            .toList();
    return result;
  }
}
