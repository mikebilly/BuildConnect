// providers/home_providers.dart
import 'package:buildconnect/features/home/services/new_service.dart';
import 'package:buildconnect/features/home/services/post_service.dart'
    show PostService;
import 'package:buildconnect/features/home/services/profile_service.dart';
import 'package:buildconnect/models/article/article_model.dart';
import 'package:buildconnect/models/post/post_model.dart';
import 'package:buildconnect/models/profile/profile_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Giả sử bạn có provider để lấy thông tin người dùng hiện tại, bao gồm thành phố
import 'package:buildconnect/features/auth/providers/auth_provider.dart'; // Giả sử có provider này

// Service Providers
final newsServiceProvider = Provider<NewsService>((ref) => NewsService());
final postServiceProvider = Provider<PostService>((ref) => PostService());
final profileServiceProvider = Provider<ProfileService>(
  (ref) => ProfileService(),
);

// Data Providers
final constructionNewsProvider = FutureProvider<List<ArticleModel>>((
  ref,
) async {
  final newsService = ref.watch(newsServiceProvider);
  return newsService.fetchBaoXayDungNews();
});

final recentPostsProvider = FutureProvider<List<PostModel>>((ref) async {
  final postService = ref.watch(postServiceProvider);
  return postService.fetchRecentPosts();
});

final suggestedConnectionsProvider = FutureProvider<List<Profile>>((ref) async {
  final profileService = ref.watch(profileServiceProvider);
  // Lấy thành phố của người dùng hiện tại. Cần có logic này.
  // Ví dụ:
  final authState = ref.watch(authProvider);
  return profileService.fetchRecentProfile();
});
