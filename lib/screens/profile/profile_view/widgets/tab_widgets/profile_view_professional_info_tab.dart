import 'package:buildconnect/core/theme/theme.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:buildconnect/shared/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:buildconnect/models/profile_data/profile_data_model.dart';

import 'package:buildconnect/screens/profile/profile_view/widgets/tab_widgets/sub_profiles_widgets/architect_profile_view_widget.dart';
import 'package:buildconnect/screens/profile/profile_view/widgets/tab_widgets/sub_profiles_widgets/contractor_profile_view_widget.dart';
import 'package:buildconnect/screens/profile/profile_view/widgets/tab_widgets/sub_profiles_widgets/construction_team_profile_view_widget.dart';
import 'package:buildconnect/screens/profile/profile_view/widgets/tab_widgets/sub_profiles_widgets/supplier_profile_view_widget.dart';

class ProfileViewProfessionalInfoTab extends StatelessWidget {
  final ProfileData profileData;
  
  const ProfileViewProfessionalInfoTab({super.key, required this.profileData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildOperatingAreas(),
        const SizedBox(height: 16),
        _buildProfileTypeSpecificContent(),
      ],
    );
  }

  Widget _buildOperatingAreas() {
    return heightWidget(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Operating Areas', style: AppTextStyles.subheading),
          const SizedBox(height: 5),
          displayFilterChip(
            values: profileData.profile.operatingAreas,
            title: '',
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTypeSpecificContent() {
    return switch (profileData.profile.profileType) {
      ProfileType.architect => ArchitectProfileViewWidget(
          profileData: profileData,
        ),
      ProfileType.contractor => ContractorProfileViewWidget(
          profileData: profileData,
        ),
      ProfileType.constructionTeam => ConstructionTeamProfileViewWidget(
          profileData: profileData,
        ),
      ProfileType.supplier => SupplierProfileViewWidget(
          profileData: profileData,
        ),
    };
  }
}
