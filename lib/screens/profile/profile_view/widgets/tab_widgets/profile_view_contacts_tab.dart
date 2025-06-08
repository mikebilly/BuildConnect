import 'package:buildconnect/core/theme/theme.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:buildconnect/shared/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:buildconnect/models/profile_data/profile_data_model.dart';
import 'package:buildconnect/models/shared/shared_models.dart';

class ProfileViewContactsTab extends StatelessWidget {
  final ProfileData profileData;
  
  const ProfileViewContactsTab({super.key, required this.profileData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContactsList(context),
      ],
    );
  }

  Widget _buildContactsList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...profileData.profile.contacts.map((contact) => _buildContactCard(contact, context)),
      ],
    );
  }

  Widget _buildContactCard(Contact contact, BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(contact.type.label),
        subtitle: Text(contact.value),
        leading: contact.type.icon(context),
      ),
    );
  }
}
