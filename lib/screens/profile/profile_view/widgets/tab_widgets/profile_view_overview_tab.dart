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
        const SizedBox(height: 16),
        _buildInfoSection(),
      ],
    );
  }

  Widget _buildInfoSection() {
    return buildBoxContainer(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(
            title: profileData.profile.availabilityStatus.title,
            value: profileData.profile.availabilityStatus.label,
          ),
          _buildInfoRow(
            title: "Years Of Experience",
            value: '${profileData.profile.yearsOfExperience.toString()} years',
          ),
          _buildInfoRow(
            title: profileData.profile.workingMode.title,
            value: profileData.profile.workingMode.label,
          ),
          _buildInfoRow(
            title: profileData.profile.businessEntityType.title,
            value: profileData.profile.businessEntityType.label,
          ),
          _buildFilterChip(
            values: profileData.profile.domains,
            title: Domain.values.first.title,
          ),
          _buildFilterChip(
            values: profileData.profile.paymentMethods,
            title: PaymentMethod.values.first.title,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({required String title, required String value}) {
    return heightWidget(
      widget: buildInfoRow(
        title: title,
        value: value,
      ),
    );
  }

  Widget _buildFilterChip({required List<dynamic> values, required String title}) {
    return heightWidget(
      widget: displayFilterChip(
        values: values,
        title: title,
      ),
    );
  }
}
