// lib/features/posting/services/posting_service.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:buildconnect/core/constants/supabase_constants.dart';
import 'package:buildconnect/models/post/post_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buildconnect/core/services/supabase/supabase_client_provider.dart';

part 'posting_service.g.dart';

@riverpod
PostingService postingService(Ref ref) {
  return PostingService(ref.read(supabaseClientProvider));
}

class PostingService {
  final SupabaseClient _client;

  PostingService(this._client);

  Future<PostModel> createNewPost({required PostModel postModel}) async {
    final data = postModel.toJson();
    final response = await _client.from('posts').insert(data).select();
    return PostModelMapper.fromMap(response[0]);
  }

  Future<List<PostModel>> fetchAllPosts() async {
    try {
      final response = await _client
          .from(SupabaseConstants.postsTable)
          .select()
          .order('created_at', ascending: false);
      if (response.isEmpty) {
        debugPrint('No posts found');
        return [];
      }
      if (response is! List) {
        debugPrint('Invalid response type: ${response.runtimeType}');
        throw Exception('Invalid response type: ${response.runtimeType}');
      }
      debugPrint('Fetched posts: $response');
      return (response as List).map((e) => PostModelMapper.fromMap(e)).toList();
    } on PostgrestException catch (e) {
      debugPrint('Error fetching posts: $e');
      throw Exception('Error fetching posts: $e');
    } catch (e) {
      debugPrint('Error fetching posts: $e');
      throw Exception('Error fetching posts: $e');
    }
  }

  Future<void> deleteJobPosting(String postId) async {
    await _client.from(SupabaseConstants.postsTable).delete().eq('id', postId);
  }

  Future<void> toggleJobPostingActive(String jobPostingId) async {
    final response = await _client
        .from(SupabaseConstants.postsTable)
        .update({'is_active': true})
        .eq('id', jobPostingId);
    if (response.error != null) {
      throw Exception('Failed to toggle job posting active status');
    }
  }
}
