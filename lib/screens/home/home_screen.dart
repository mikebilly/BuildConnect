import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:buildconnect/features/auth/providers/auth_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  Future<void> _signOut() async {
    final authNotifier = ref.read(authProvider.notifier);
    await authNotifier.signOut();

    if (mounted) {
      context.go('/login');
    }
  }

  void _navigateToLogin() {
    Future.microtask(() {
      if (mounted) context.go('/login');
    });
  }


  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _signOut();
            }
          ),
        ],
      ),
      body: auth.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (user) {
          if (user == null) {
            _navigateToLogin();
            return const SizedBox.shrink();
          }

          return Center(
            child: Text('Welcome ${user.email}'),
          );
        }
      ),
    );
  }
}