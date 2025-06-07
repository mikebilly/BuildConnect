// services/post_service.dart (Placeholder)// Điều chỉnh

import 'package:buildconnect/core/constants/supabase_constants.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:buildconnect/models/post/post_model.dart';
import 'package:buildconnect/models/profile/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  SupabaseClient _supabaseClient = Supabase.instance.client;
  String? userId = Supabase.instance.client.auth.currentUser!.id;
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
        .limit(20);

    final rawData = await builder as List<dynamic>;
    final profileList =
        rawData.map((row) => ProfileMapperExt.fromSupabaseMap(row)).toList();
    // var result = <Profile>[];
    // lấy ra các profiles có cùng profileType hoặc ở cùng mainAddress
    var result = List<Profile>.from(profileList);
    if (userId != null) {
      final myProfile =
          await _supabaseClient
              .from(SupabaseConstants.profilesTable)
              .select('profile_type, main_city')
              .eq('user_id', userId!)
              .maybeSingle();
      debugPrint('-----------currentUser: ${myProfile.toString()}');

      if (myProfile != null) {
        final myProfileType = myProfile['profile_type'];
        final myMainCity = myProfile['main_city'];

        result =
            result.where((profile) {
              final matchType = profile.profileType.name == myProfileType;
              final matchCity = profile.mainCity.name == myMainCity;
              final isMe = profile.userId! == userId!;
              return (matchType || matchCity) && !isMe;
            }).toList();
      }
    }

    return result;
  }
}
