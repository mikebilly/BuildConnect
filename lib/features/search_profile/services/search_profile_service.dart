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
    if (model.cityList!.isEmpty) {
      debugPrint('no location choose');
    }
    if (model.profileType == null) {
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

    var result = profileList;

    // 2) Nếu có cityList và không rỗng → lọc theo city
    if (model.cityList != null && model.cityList!.isNotEmpty) {
      result =
          result.where((profile) {
            // Có ít nhất 1 city trong model.cityList khớp với profile.operatingAreas
            return model.cityList!.any(
              (city) => profile.operatingAreas.contains(city),
            );
          }).toList();
    }

    // 3) Nếu có profileType và không rỗng → lọc theo profileType
    if (model.profileType != null && model.profileType!.isNotEmpty) {
      result =
          result.where((profile) {
            return model.profileType!.contains(profile.profileType);
          }).toList();
    }

    return result;
  }
}
