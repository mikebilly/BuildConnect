import 'package:buildconnect/features/posting/services/posting_service.dart';
import 'package:buildconnect/models/post/post_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:buildconnect/models/enums/enums.dart';

part 'posting_provider.g.dart';

@Riverpod(keepAlive: true)
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
    // List<String>? categories,
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
      // categories: categories,
      authorId: authorId,
    );

    final post = await ref
        .read(postingServiceProvider)
        .createNewPost(postModel: postModel);
    return post;
  }

  String get authorId {
    // final profileDataAsync = ref.watch(profileDataNotifierProvider);

    // return profileDataAsync.when(
    //   data: (data) => data.profile.id,
    //   loading: () => 'loading',
    //   error: (e, _) => 'error',
    // );
    return 'authorId'; // Replace with actual logic to get authorId
  }

  Future<void> createNewPost(PostModel postModel) async {
    await ref.read(postingServiceProvider).createNewPost(postModel: postModel);
  }
}

@riverpod
Future<List<PostModel>> allPosts(Ref ref) async {
  final service = ref.read(postingServiceProvider);
  return service.fetchAllPosts();
}

// @riverpod
// Future<List<PostModel>> allPosts(Ref ref) async {
//   await Future.delayed(Duration(seconds: 1)); // Giả lập delay

//   return [
//     // Hiring Job Posting
//     PostModel(
//       id: "1",
//       title: 'Tuyển kỹ sư backend',
//       jobPostingType: JobPostingType.hiring,
//       location: 'Đà Nẵng',
//       description: 'Làm việc với NodeJS và PostgreSQL.',
//       budget: 1200.0,
//       deadline: DateTime.now().add(Duration(days: 7)),
//       requiredSkills: ['NodeJS', 'PostgreSQL'],
//       categories: ['Backend'],
//       authorId: 'admin01',
//     ),
//     // Partnership Job Posting
//     PostModel(
//       id: "2",
//       title: 'Tìm đối tác phát triển phần mềm',
//       jobPostingType: JobPostingType.partnership,
//       location: 'Hồ Chí Minh',
//       description: 'Cần tìm đối tác hợp tác phát triển phần mềm quản lý dự án.',
//       budget: 5000.0,
//       deadline: DateTime.now().add(Duration(days: 14)),
//       requiredSkills: ['Flutter', 'NodeJS'],
//       categories: ['Mobile', 'Software Development'],
//       authorId: 'admin02',
//     ),
//     // Materials Job Posting
//     PostModel(
//       id: "3",
//       title: 'Cung cấp vật liệu xây dựng',
//       jobPostingType: JobPostingType.materials,
//       location: 'Hà Nội',
//       description:
//           'Cung cấp các loại vật liệu xây dựng chất lượng cao, bao gồm gạch, cát, xi măng.',
//       budget: 10000.0,
//       deadline: DateTime.now().add(Duration(days: 30)),
//       requiredSkills: ['Vật liệu xây dựng', 'Giao hàng'],
//       categories: ['Construction Materials'],
//       authorId: 'admin03',
//     ),
//     // Other Job Posting
//     PostModel(
//       id: "4",
//       title: 'Dịch vụ tư vấn xây dựng',
//       jobPostingType: JobPostingType.other,
//       location: 'Cần Thơ',
//       description:
//           'Cung cấp dịch vụ tư vấn thiết kế và xây dựng cho các công trình dân dụng.',
//       budget: 2000.0,
//       deadline: DateTime.now().add(Duration(days: 21)),
//       requiredSkills: ['Tư vấn', 'Thiết kế', 'Xây dựng'],
//       categories: ['Consulting'],
//       authorId: 'admin04',
//     ),
//   ];
// }

@riverpod
Future<PostModel?> postById(Ref ref, String id) async {
  final posts = await ref.watch(allPostsProvider.future);
  try {
    return posts.firstWhere((post) => post.id == id);
  } catch (_) {
    return null;
  }
}
