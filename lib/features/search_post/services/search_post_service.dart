import 'package:buildconnect/core/constants/supabase_constants.dart';
import 'package:buildconnect/models/post/post_model.dart';
import 'package:buildconnect/models/search_post/search_post_model.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SearchPostService {
  final SupabaseClient _supabaseClient;
  SearchPostService(this._supabaseClient);

  Future<List<PostModel>> searchPost(SearchPostModel model) async {
    if (model.isEmptyModel()) {
      debugPrint('SearchPostModel is empty, returning empty list.');
      return [];
    }

    debugPrint('Searching posts with model: ${model.toString()}');

    var queryBuilder =
        _supabaseClient.from(SupabaseConstants.postsTable).select();
    final rawData = await queryBuilder as List<dynamic>;
    final postList =
        rawData.map((row) => PostModelMapper.fromMap(row)).toList();
    // var result = <Profile>[];
    debugPrint('-------------- postList.toString():${postList.toString()}');
    var result = List<PostModel>.from(postList);

    if (model.query.trim().isNotEmpty) {
      result =
          result
              .where((post) => post.title.toLowerCase().contains(model.query))
              .toList();
    }

    // 2. Lọc theo địa điểm (location)
    if (model.location.trim().isNotEmpty) {
      result =
          result
              .where(
                (post) => post.location.toLowerCase().contains(model.location),
              )
              .toList();
    }

    if (model.jobType.isNotEmpty) {
      final jobPostingTypeNames =
          model.jobType.map((type) => type.name).toList();

      if (jobPostingTypeNames.isNotEmpty) {
        result =
            result
                .where(
                  (post) =>
                      jobPostingTypeNames.contains(post.jobPostingType.name),
                )
                .toList();
      }
    }

    return result;
  }
}
