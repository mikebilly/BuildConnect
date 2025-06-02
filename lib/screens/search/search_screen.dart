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
          title: const Text('Tìm kiếm'),
          backgroundColor: AppTheme.lightTheme.primaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          bottom: TabBar(
            labelStyle: AppTextStyles.labelTabScreen,
            labelColor: AppColors.background,
            unselectedLabelColor: AppColors.textLight,
            indicatorColor: AppColors.background,
            indicatorWeight: 3,
            tabs: const [Tab(text: 'Bài đăng'), Tab(text: 'Hồ sơ')],
          ),
        ),
        body: const TabBarView(
          children: [SearchPostScreen(), SearchProfileScreen()],
        ),
      ),
    );
  }
}
