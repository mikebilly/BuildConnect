import 'package:buildconnect/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:buildconnect/models/profile_data/profile_data_model.dart';


class ProfileViewOverviewTab extends StatelessWidget {
  final ProfileData profileData;
  const ProfileViewOverviewTab({super.key, required this.profileData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bio',
          style: AppTextStyles.subheading,
        ),
        const SizedBox(height: 8),
        Text(
          profileData.profile.bio,
          // style: AppTextStyles.subheading,
        ),
      ],
    );
  }
}
