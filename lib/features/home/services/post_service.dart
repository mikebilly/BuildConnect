// services/post_service.dart (Placeholder)// Điều chỉnh

import 'package:buildconnect/core/constants/supabase_constants.dart';
import 'package:buildconnect/models/post/post_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PostService {
  SupabaseClient _supabaseClient = Supabase.instance.client;
  String? userId = Supabase.instance.client.auth.currentUser!.id;
  Future<List<PostModel>> fetchRecentPosts() async {
    debugPrint('---------------begin fetch recent posts-----------');
    final rawData = await _supabaseClient
        .from(SupabaseConstants.postsTable)
        .select()
        .order('created_at', ascending: false)
        .limit(20);

    final postList =
        rawData.map((row) => PostModelMapper.fromMap(row)).toList();
    // var result = <Profile>[];
    debugPrint(
      '--------------Trung--------------- postList.toString():${postList.toString()}',
    );
    var result = List<PostModel>.from(postList);
    debugPrint(
      '-----------------end fetch recent post with ${result.toString()}',
    );
    // if (userId != null) {
    //   // lấy các post có thành phố trong operating areas của bạn
    //   // lấy ra profiles id từ bảng profile
    //   final profileId = await _supabaseClient
    //       .from(SupabaseConstants.profilesTable)
    //       .select('id')
    //       .eq('user_id', userId!);
    //   // lấy ra operating areas từ bảng profile_operating_areas
    //   final operatingAreas = await _supabaseClient
    //       .from(SupabaseConstants.profileOperatingAreasTable)
    //       .select('city')
    //       .eq('profile_id', profileId);
    //   debugPrint(operatingAreas.toString());
    //   // lọc các post có trùng operating areas
    // }
    return result;
  }
}
