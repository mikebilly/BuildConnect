import 'package:buildconnect/models/profile_data/profile_data_model.dart';
import 'package:flutter/material.dart';
import 'package:buildconnect/core/theme/theme.dart';
import 'package:buildconnect/shared/common_widgets.dart';
import 'package:buildconnect/models/enums/enums.dart';

class SupplierProfileViewWidget extends StatelessWidget {
  final ProfileData profileData;
  const SupplierProfileViewWidget({super.key, required this.profileData});

  @override
  Widget build(BuildContext context) {
    final data = profileData.supplierProfile!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildBoxContainer(
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              heightWidget(
                widget: buildInfoRow(
                  title: SupplierType.values.first.title,
                  value: data.supplierType.label,
                ),
              ),

              heightWidget(
                widget: displayFilterChip(
                  values: data.materialCategories,
                  title: MaterialCategory.values.first.title,
                ),
              ),

              heightWidget(
                widget: buildInfoRow(
                  title: 'Delivery Radius',
                  value: '${data.deliveryRadius.toString()}km',
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}
