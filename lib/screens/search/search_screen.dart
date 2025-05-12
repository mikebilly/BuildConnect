import 'package:buildconnect/core/theme/theme.dart';
import 'package:buildconnect/screens/search_post/search_post_screen.dart';
import 'package:buildconnect/screens/search_profile/search_profile_screen.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Tìm kiếm',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: AppTheme.lightTheme.primaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          bottom: const TabBar(
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.amber,
            indicatorWeight: 3,
            tabs: [Tab(text: 'Bài đăng'), Tab(text: 'Hồ sơ')],
          ),
        ),
        body: const TabBarView(
          children: [SearchPostScreen(), SearchProfileScreen()],
        ),
      ),
    );
  }
}
