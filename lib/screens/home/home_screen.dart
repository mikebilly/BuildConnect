import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// import 'package:buildconnect/shared/common_widgets.dart';
import 'package:buildconnect/features/auth/providers/auth_provider.dart';
import 'package:buildconnect/screens/home/tabs/feed_screen.dart';
import 'package:buildconnect/screens/home/tabs/hometab_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
    final auth = ref.watch(authProvider);
    auth.when(
      loading: () => null,
      error: (e, _) => null,
      data: (user) {
        if (user != null) {
          context.push('/post');
        } else {
          context.push('/login');
        }
      },
    );
    // Future.microtask(() {
    //   if (mounted) context.push('/post');
    // });
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Build Connect'),
        automaticallyImplyLeading: false,
        actions: [
          _buildMenu(
            context,
            onProfileTap: () {
              // context.push('/profile_edit');
              auth.when(
                loading: () => null,
                error: (e, _) => null,
                data: (user) {
                  if (user != null) {
                    context.push('/profile/view/${user.id}');
                  } else {
                    context.push('/login');
                  }
                },
              );
            },
            onLogoutTap: () {
              _signOut();
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: 'Home'), Tab(text: 'Feeds')],
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          unselectedLabelColor: const Color.fromARGB(128, 255, 255, 255),
        ),
      ),
      body: auth.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (user) {
          return TabBarView(
            controller: _tabController,
            children: const [HomeTabScreen(), FeedScreen()],
          );
          // return Center(child: Text('$auth'));
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: SizedBox(
          height: 50,
          child: FloatingActionButton.extended(
            onPressed: _navigateToPosts,
            elevation: 6,
            backgroundColor: Theme.of(context).primaryColor,
            icon: const Icon(Icons.post_add, size: 18, color: Colors.white),
            label: const Text('Post', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white)),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
