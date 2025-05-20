import 'package:buildconnect/core/constants/supabase_constants.dart';
import 'package:buildconnect/models/post/post_model.dart';
import 'package:buildconnect/models/search_post/search_post_model.dart';
import 'package:buildconnect/screens/search_post/search_post_screen.dart';
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
    // final query = model.query.nomalize();
    // Tìm kiếm theo title
    final titleQuery1 = await _supabaseClient
        .from(SupabaseConstants.postsTable)
        .select()
        .ilike('title', '%${model.query}%');
    final titleQuery2 = await _supabaseClient
        .from(SupabaseConstants.postsTable)
        .select()
        .ilike('title', '%${model.query.nomalize()}%');
    // Tìm kiếm theo description
    final descriptionQuery1 = await _supabaseClient
        .from(SupabaseConstants.postsTable)
        .select()
        .ilike('description', '%${model.query}%');
    final descriptionQuery2 = await _supabaseClient
        .from(SupabaseConstants.postsTable)
        .select()
        .ilike('description', '%${model.query.nomalize()}%');

    // Gộp kết quả và loại bỏ bản ghi trùng lặp theo id
    final allResults = [
      ...titleQuery1,
      ...titleQuery2,
      ...descriptionQuery1,
      ...descriptionQuery2,
    ];
    final uniqueResults =
        {for (var item in allResults) item['id']: item}.values.toList();

    final rawData = uniqueResults;
    // debugPrint(query);
    // final rawData = await queryBuilder as List<dynamic>;
    final postList =
        rawData.map((row) => PostModelMapper.fromMap(row)).toList();
    // var result = <Profile>[];
    debugPrint('-------------- postList.toString():${postList.toString()}');
    var result = List<PostModel>.from(postList);

    // 2. Lọc theo địa điểm (location)
    if (model.location.isNotEmpty) {
      result =
          result
              .where((post) => model.location.contains(post.location))
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
