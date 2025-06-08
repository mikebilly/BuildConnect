// services/post_service.dart (Placeholder)// Điều chỉnh

import 'package:buildconnect/core/constants/supabase_constants.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:buildconnect/models/post/post_model.dart';
import 'package:buildconnect/models/profile/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  SupabaseClient _supabaseClient = Supabase.instance.client;
  
  Future<List<Profile>> fetchRecentProfile() async {
    try {
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
      final profileList = rawData.map((row) => ProfileMapperExt.fromSupabaseMap(row)).toList();
      var result = List<Profile>.from(profileList);

      // Only try to filter by user profile if there is an authenticated user
      final currentUser = _supabaseClient.auth.currentUser;
      if (currentUser != null) {
        final myProfile = await _supabaseClient
            .from(SupabaseConstants.profilesTable)
            .select('profile_type, main_city')
            .eq('user_id', currentUser.id)
            .maybeSingle();
        
        debugPrint('-----------currentUser: ${myProfile.toString()}');

        if (myProfile != null) {
          final myProfileType = myProfile['profile_type'];
          final myMainCity = myProfile['main_city'];

          result = result.where((profile) {
            final matchType = profile.profileType.name == myProfileType;
            final matchCity = profile.mainCity.name == myMainCity;
            final isMe = profile.userId == currentUser.id;
            return (matchType || matchCity) && !isMe;
          }).toList();
        }
      }

      return result;
    } catch (e) {
      debugPrint('Error fetching recent profiles: $e');
      return [];
    }
  }
}
