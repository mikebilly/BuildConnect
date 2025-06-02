import 'package:flutter/material.dart';
import 'package:buildconnect/screens/search_post/search_post_screen.dart';
import 'package:buildconnect/screens/search_profile/search_profile_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tìm kiếm'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Bài đăng'),
            Tab(text: 'Hồ sơ'),
          ],
          labelColor: Colors.white,
          unselectedLabelColor: const Color.fromARGB(128, 255, 255, 255),
          indicatorColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          SearchPostScreen(),
          SearchProfileScreen(),
        ],
      ),
    );
  }
}
