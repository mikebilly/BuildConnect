import 'package:buildconnect/models/profile_data/profile_data_model.dart';
import 'package:buildconnect/screens/profile/profile_view/widgets/tab_widgets/profile_view_contacts_tab.dart';
import 'package:buildconnect/screens/profile/profile_view/widgets/tab_widgets/profile_view_overview_tab.dart';
import 'package:buildconnect/screens/profile/profile_view/widgets/tab_widgets/profile_view_professional_info_tab.dart';
import 'package:flutter/material.dart';

class ProfileViewTabs extends StatelessWidget {
  final ProfileData profileData;

  const ProfileViewTabs({super.key, required this.profileData});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'Overview'),
              Tab(text: 'Professional Info'),
              Tab(text: 'Contacts'),
            ],
          ),
          // Make sure this container gets a fixed height
          const Padding(padding: EdgeInsets.only(top: 8)),
          Expanded(
            child: TabBarView(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: ProfileViewOverviewTab(profileData: profileData),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: ProfileViewProfessionalInfoTab(
                    profileData: profileData,
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: ProfileViewContactsTab(profileData: profileData),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
