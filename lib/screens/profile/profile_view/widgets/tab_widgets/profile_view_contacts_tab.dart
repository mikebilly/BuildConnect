import 'package:buildconnect/core/theme/theme.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:buildconnect/shared/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:buildconnect/models/profile_data/profile_data_model.dart';

class ProfileViewContactsTab extends StatelessWidget {
  final ProfileData profileData;
  const ProfileViewContactsTab({super.key, required this.profileData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text('Bio', style: AppTextStyles.subheading),
        // const SizedBox(height: 5),
        // Text(profileData.profile.bio),
        // buildBoxContainer(
        //   widget: 
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   'Your contacts',
              //   style: TextStyle(fontWeight: FontWeight.bold),
              // ),
              // const SizedBox(height: 8),
              ...profileData.profile.contacts.map((contact) {
                return Card(
                  child: ListTile(
                    title: Text(contact.type.label),
                    subtitle: Text(contact.value),
                    leading: contact.type.icon(context),
                  ),
                );
              }),
              // const Divider(),
            ],
          ),
        // ),
      ],
    );
  }
}
