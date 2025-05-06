import 'package:buildconnect/core/theme/theme.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:buildconnect/shared/common_widgets.dart';
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
        Text('Bio', style: AppTextStyles.subheading),
        const SizedBox(height: 5),
        Text(profileData.profile.bio),

        buildBoxContainer(
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightWidget(
                widget: buildInfoRow(
                  title: profileData.profile.availabilityStatus.title,
                  value: profileData.profile.availabilityStatus.label,
                ),
              ),
              heightWidget(
                widget: buildInfoRow(
                  title: "Years Of Experience",
                  value: '${profileData.profile.yearsOfExperience.toString()} years',
                ),
              ),
              heightWidget(
                widget: buildInfoRow(
                  title: profileData.profile.workingMode.title,
                  value: profileData.profile.workingMode.label,
                ),
              ),
              heightWidget(
                widget: buildInfoRow(
                  title: profileData.profile.businessEntityType.title,
                  value: profileData.profile.businessEntityType.label,
                ),
              ),
              heightWidget(
                widget: displayFilterChip(
                  values: profileData.profile.domains,
                  title: Domain.values.first.title,
                ),
              ),

              heightWidget(
                widget: displayFilterChip(
                  values: profileData.profile.paymentMethods,
                  title: PaymentMethod.values.first.title,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
