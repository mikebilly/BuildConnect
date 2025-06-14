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
          const Padding(padding: EdgeInsets.only(top: 8)),
          Expanded(
            child: TabBarView(
              physics: const BouncingScrollPhysics(),
              children: [
                _TabContent(
                  child: ProfileViewOverviewTab(profileData: profileData),
                ),
                _TabContent(
                  child: ProfileViewProfessionalInfoTab(profileData: profileData),
                ),
                _TabContent(
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

class _TabContent extends StatefulWidget {
  final Widget child;

  const _TabContent({required this.child});

  @override
  State<_TabContent> createState() => _TabContentState();
}

class _TabContentState extends State<_TabContent> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: widget.child,
    );
  }
}
