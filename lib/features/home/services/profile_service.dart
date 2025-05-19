// services/post_service.dart (Placeholder)// Điều chỉnh

import 'package:buildconnect/core/constants/supabase_constants.dart';
import 'package:buildconnect/models/post/post_model.dart';
import 'package:buildconnect/models/profile/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  SupabaseClient _supabaseClient = Supabase.instance.client;
  Future<List<Profile>> fetchRecentProfile() async {
    final builder = _supabaseClient
        .from(SupabaseConstants.profilesTable)
        .select('''
      *,
      profile_operating_areas(city),
      profile_contacts(contact),
      profile_domains(domain),
      profile_payment_methods(payment_method)
    ''')
        .limit(5);

    final rawData = await builder as List<dynamic>;
    final profileList =
        rawData.map((row) => ProfileMapperExt.fromSupabaseMap(row)).toList();
    // var result = <Profile>[];

    var result = List<Profile>.from(profileList);
    return result;
  }
}
