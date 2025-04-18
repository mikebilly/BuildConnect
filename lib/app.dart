import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buildconnect/routes/router.dart';
import 'package:buildconnect/core/theme/theme.dart';
class BuildConnectApp extends ConsumerWidget {
  const BuildConnectApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Build Connect",
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
