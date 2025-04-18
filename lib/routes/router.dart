import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

import 'package:buildconnect/screens/auth/login_screen.dart';
import 'package:buildconnect/screens/auth/register_screen.dart';
import 'package:buildconnect/screens/home/home_screen.dart';

// import 'package:flutter_masterclass/presentation/screens/home/home_screen.dart';
// import 'package:flutter_masterclass/presentation/screens/loading/loading_screen.dart';
// import 'package:flutter_masterclass/presentation/screens/error/error_screen.dart';
// import 'package:flutter_masterclass/presentation/screens/choose_location/choose_location_screen.dart';

part 'router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  // final authState = 

  return GoRouter(
    initialLocation: '/login',
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
