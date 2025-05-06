import 'package:buildconnect/models/enums/enums.dart';
import 'package:buildconnect/models/profile_data/profile_data_model.dart';
import 'package:flutter/material.dart';
import 'package:buildconnect/core/theme/theme.dart';
import 'package:buildconnect/shared/common_widgets.dart';

class ArchitectProfileViewWidget extends StatelessWidget {
  final ProfileData profileData;
  const ArchitectProfileViewWidget({super.key, required this.profileData});

  @override
  Widget build(BuildContext context) {
    final data = profileData.architectProfile!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Design Philosophy', style: AppTextStyles.subheading),
        const SizedBox(height: 5),
        Text(data.designPhilosophy),

        buildBoxContainer(
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightWidget(
                widget: buildInfoRow(
                  title: data.architectRole.title,
                  value: data.architectRole.label,
                ),
              ),

              heightWidget(
                widget: displayFilterChip(
                  values: data.designStyles,
                  title: DesignStyle.values.first.title,
                ),
              ),

              heightWidget(
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Portfolio Links',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 0),
                    ...data.portfolioLinks.map((link) {
                      return Card(
                        child: ListTile(
                          title: Text(link),
                          leading: const Icon(Icons.link),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
