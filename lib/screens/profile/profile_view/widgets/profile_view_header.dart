import 'package:buildconnect/models/enums/enums.dart';
import 'package:buildconnect/models/profile_data/profile_data_model.dart';
import 'package:flutter/material.dart';
import 'package:buildconnect/core/theme/theme.dart';

class ProfileViewHeader extends StatelessWidget {
  final ProfileData profileData;

  const ProfileViewHeader({super.key, required this.profileData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(height: 140, color: AppColors.primary),
        Transform.translate(
          offset: const Offset(30, -65), //-50
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: AppColors.primary,
                  child: Icon(
                    profileData.profile.profileType.icon,
                    size: 75,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Text(profileData.profile.displayName, style: AppTextStyles.heading),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.greyBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(profileData.profile.profileType.label, style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                )),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.location_on, color: AppColors.grey),
                  const SizedBox(width: 4),
                  const Text('City', style: TextStyle(color: AppColors.grey)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
