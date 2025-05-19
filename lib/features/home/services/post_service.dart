// services/post_service.dart (Placeholder)// Điều chỉnh

import 'package:buildconnect/core/constants/supabase_constants.dart';
import 'package:buildconnect/models/post/post_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PostService {
  SupabaseClient _supabaseClient = Supabase.instance.client;
  Future<List<PostModel>> fetchRecentPosts() async {
    debugPrint('---------------begin fetch recent posts-----------');
    final rawData = await _supabaseClient
        .from(SupabaseConstants.postsTable)
        .select()
        .limit(5);

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
    return result;
  }
}
