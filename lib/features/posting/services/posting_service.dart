// lib/features/posting/services/posting_service.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:buildconnect/core/constants/supabase_constants.dart';
import 'package:buildconnect/models/post/post_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
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

  Future<PostModel> createPost({
    required String title,
    required JobPostingType jobPostingType,
    required String location,
    required String description,
    double? budget,
    DateTime? deadline,
    List<String>? requiredSkills,
    List<String>? categories,
    required String authorId,
  }) async {
    final post = PostModel(
      id: const Uuid().v4(),
      title: title,
      jobPostingType: jobPostingType,
      location: location,
      description: description,
      budget: budget,
      deadline: deadline,
      requiredSkills: requiredSkills,
      categories: categories,
      authorId: authorId,
      createdAt: DateTime.now(),
    );

    final data = post.toMap();
    final response = await _client.from('posts').insert(data).select();
    return PostModelMapper.fromMap(response[0]);
  }
}
