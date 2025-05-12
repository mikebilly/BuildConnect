import 'package:buildconnect/models/profile_data/profile_data_model.dart';
import 'package:flutter/material.dart';
import 'package:buildconnect/core/theme/theme.dart';
import 'package:buildconnect/shared/common_widgets.dart';
import 'package:buildconnect/models/enums/enums.dart';

class ConstructionTeamProfileViewWidget extends StatelessWidget {
  final ProfileData profileData;
  const ConstructionTeamProfileViewWidget({
    super.key,
    required this.profileData,
  });

  @override
  Widget build(BuildContext context) {
    final data = profileData.constructionTeamProfile!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildBoxContainer(
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightWidget(
                widget: buildInfoRow(
                  title: 'Representative Name',
                  value: data.representativeName,
                ),
              ),

              heightWidget(
                widget: buildInfoRow(
                  title: 'Representative Phone',
                  value: data.representativePhone,
                ),
              ),

              heightWidget(
                widget: displayFilterChip(
                  values: data.services,
                  title: ServiceType.values.first.title,
                ),
              ),

              heightWidget(
                widget: buildInfoRow(
                  title: 'Team Size',
                  value: '${data.teamSize.toString()} people',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
