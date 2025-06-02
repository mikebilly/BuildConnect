import 'package:buildconnect/screens/message/detail_message_screen.dart';
import 'package:buildconnect/screens/message/user_list_message_screen.dart';
import 'package:buildconnect/screens/notification/notification_screen.dart';
import 'package:buildconnect/screens/search/search_screen.dart';
import 'package:buildconnect/screens/search_post/search_post_screen.dart';
import 'package:buildconnect/screens/search_profile/search_profile_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

//auth
import 'package:buildconnect/screens/auth/login_screen.dart';
import 'package:buildconnect/screens/auth/register_screen.dart';
import 'package:buildconnect/screens/home/home_screen.dart';

//profile
import 'package:buildconnect/screens/profile/profile_edit/profile_edit_screen.dart';
import 'package:buildconnect/screens/profile/profile_view/profile_view_screen.dart';

// import 'package:flutter_masterclass/presentation/screens/home/home_screen.dart';
// import 'package:flutter_masterclass/presentation/screens/loading/loading_screen.dart';
// import 'package:flutter_masterclass/presentation/screens/error/error_screen.dart';
// import 'package:flutter_masterclass/presentation/screens/choose_location/choose_location_screen.dart';

//posting
import 'package:buildconnect/screens/posts/post_screen.dart';
import 'package:buildconnect/screens/posts/detail_post_screen.dart';

part 'router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  // final authState =

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    redirect: (context, state) {},
    routes: [
      // GoRoute(
      //   path: '/test',
      //   name: 'test',
      //   builder: (context, state) => const TestScreen(),
      // ),
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/profile/edit',
        name: 'profile_edit',
        builder: (context, state) => const ProfileEditScreen(),
      ),
      GoRoute(
        path: '/post',
        name: 'post',
        builder: (context, state) => const PostScreen(),
      ),
      GoRoute(
        path: '/job-posting/view/:jobPostingId',
        builder: (context, state) {
          final jobPostingId = state.pathParameters['jobPostingId']!;
          return JobPostingViewScreen(jobPostingId: jobPostingId);
        },
      ),
      GoRoute(
        path: '/profile/view/:userId',
        name: 'profile_view',
        builder: (context, state) {
          final userId = state.pathParameters['userId'];
          return ProfileViewScreen(userId: userId);
        },
      ),
      GoRoute(
        path: '/search',
        name: 'search',
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: '/search_profile',
        name: 'search_profile',
        builder: (context, state) => const SearchProfileScreen(),
      ),
      GoRoute(
        path: '/search_post',
        name: 'search_post',
        builder: (context, state) => const SearchPostScreen(),
      ),
      GoRoute(
        path: '/message/detail_view/:userId',
        name: 'message_detail',
        builder: (context, state) {
          final userId = state.pathParameters['userId'];
          return DetailMessageScreen(conversationPartnerId: userId!);
        },
      ),
      GoRoute(
        path: '/message/user_list_view',
        name: 'message_user_list',
        builder: (context, state) {
          return UserListMessagesScreen();
        },
      ),
      GoRoute(
        path: '/notification',
        builder: (context, state) => NotificationScreen(),
      ),
      // GoRoute(
      //   path: '/location',
      //   name: 'location',
      //   builder: (context, state) => const ChooseLocationScreen(),
      // ),
      // GoRoute(
      //   path: 'loading',
      //   name: 'loading',
      //   builder: (context, state) => const LoadingScreen(),
      // ),
    ],
    // errorBuilder: (context, state) => const ErrorScreen(),
  );
}
