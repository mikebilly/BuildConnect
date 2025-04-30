import 'package:buildconnect/features/posting/services/posting_service.dart';
import 'package:buildconnect/models/post/post_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:buildconnect/models/enums/enums.dart';

part 'posting_provider.g.dart';

@Riverpod()
class PostingNotifier extends _$PostingNotifier {
  @override
  FutureOr<void> build() {
    // return;
  }

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
    // 👉 Tạo object PostModel trước
    final postModel = PostModel(
      title: title,
      jobPostingType: jobPostingType,
      location: location,
      description: description,
      budget: budget,
      deadline: deadline,
      requiredSkills: requiredSkills,
      categories: categories,
      authorId: authorId,
    );

    // 👉 Truyền PostModel vào service
    final post = await ref
        .read(postingServiceProvider)
        .createPost(postModel: postModel);
    return post;
  }

  Future<void> createNewPost() async {
    final postModel = PostModel(
      title: 'Sample Post',
      jobPostingType: JobPostingType.hiring,
      location: 'New York',
      description: 'This is a sample post description.',
      budget: 1000.0,
      deadline: DateTime.now().add(const Duration(days: 7)),
      requiredSkills: ['Flutter', 'Dart'],
      categories: ['Software Development'],
      authorId: '12345',
    );

    await ref.read(postingServiceProvider).createPost(postModel: postModel);
  }
}
