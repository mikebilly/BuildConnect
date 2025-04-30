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

  void _navigateToPosts() {
    Future.microtask(() {
      if (mounted) context.push('/post');
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
        actions: [
          _buildMenu(
            context,
            onProfileTap: () {
              context.push('/profile_edit');
            },
            onLogoutTap: () {
              _signOut();
            },
          ),
        ],
      ),
      body: auth.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (user) {
          // if (user == null) {
          //   _navigateToLogin();
          //   return const SizedBox.shrink();
          // }

          // return Center(child: Text('Welcome ${user.email}'));
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToPosts,
        icon: const Icon(Icons.post_add),
        label: const Text('Post'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Widget _buildMenu(
  BuildContext context, {
  required VoidCallback onProfileTap,
  required VoidCallback onLogoutTap,
}) {
  return PopupMenuButton<String>(
    offset: const Offset(0, 50),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    itemBuilder:
        (context) => [
          PopupMenuItem(
            value: 'profile',
            child: Row(
              children: [
                Icon(Icons.person, color: Theme.of(context).iconTheme.color),
                const SizedBox(width: 8),
                Text('Profile'),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'logout',
            child: Row(
              children: [
                Icon(Icons.logout, color: Theme.of(context).iconTheme.color),
                const SizedBox(width: 8),
                Text('Logout'),
              ],
            ),
          ),
        ],
    onSelected: (value) {
      if (value == 'profile') {
        onProfileTap();
      } else if (value == 'logout') {
        onLogoutTap();
      }
    },
    child: CircleAvatar(
      radius: 20,
      backgroundColor: Colors.transparent,
      child: Icon(Icons.menu, color: Colors.white),
    ),
  );
}
