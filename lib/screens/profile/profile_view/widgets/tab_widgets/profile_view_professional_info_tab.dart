import 'package:flutter/material.dart';
import 'package:buildconnect/models/profile_data/profile_data_model.dart';

class ProfileViewProfessionalInfoTab extends StatelessWidget {
  final ProfileData profileData;
  const ProfileViewProfessionalInfoTab({super.key, required this.profileData});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Professional Info'));
  }
}
