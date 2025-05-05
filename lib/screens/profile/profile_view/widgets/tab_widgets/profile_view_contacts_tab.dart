import 'package:flutter/material.dart';
import 'package:buildconnect/models/profile_data/profile_data_model.dart';

class ProfileViewContactsTab extends StatelessWidget {
  final ProfileData profileData;
  const ProfileViewContactsTab({super.key, required this.profileData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [const Text('Hi')]);
  }
}
