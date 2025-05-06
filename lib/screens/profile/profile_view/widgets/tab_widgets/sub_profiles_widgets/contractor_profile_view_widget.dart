import 'package:buildconnect/models/enums/enums.dart';
import 'package:buildconnect/models/profile_data/profile_data_model.dart';
import 'package:flutter/material.dart';
import 'package:buildconnect/core/theme/theme.dart';
import 'package:buildconnect/shared/common_widgets.dart';

class ContractorProfileViewWidget extends StatelessWidget {
  final ProfileData profileData;
  const ContractorProfileViewWidget({super.key, required this.profileData});

@override
  Widget build(BuildContext context) {
    final data = profileData.contractorProfile!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        buildBoxContainer(
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              heightWidget(
                widget: displayFilterChip(
                  values: data.services,
                  title: ServiceType.values.first.title,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}