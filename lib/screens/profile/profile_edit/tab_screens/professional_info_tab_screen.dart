import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buildconnect/models/enums/enums.dart';

import 'package:buildconnect/screens/profile/profile_edit/tab_screens/sub_profiles_screens/architect_profile_edit_screen.dart';
import 'package:buildconnect/screens/profile/profile_edit/tab_screens/sub_profiles_screens/contractor_profile_edit_screen.dart';
import 'package:buildconnect/screens/profile/profile_edit/tab_screens/sub_profiles_screens/construction_team_profile_edit_screen.dart';
import 'package:buildconnect/screens/profile/profile_edit/tab_screens/sub_profiles_screens/supplier_profile_edit_screen.dart';

class ProfessionalInfoTabScreen extends ConsumerStatefulWidget {
  final Enum profileType;
  const ProfessionalInfoTabScreen({super.key, required this.profileType});

  @override
  ConsumerState<ProfessionalInfoTabScreen> createState() =>
      _ProfessionalInfoTabScreenState();
}

class _ProfessionalInfoTabScreenState
    extends ConsumerState<ProfessionalInfoTabScreen> {

  @override
  Widget build(BuildContext context) {
    return switch (widget.profileType as ProfileType) {
      ProfileType.architect => const ArchitectProfileEditScreen(),
      ProfileType.contractor => const ContractorProfileEditScreen(),
      ProfileType.constructionTeam => const ConstructionTeamProfileEditScreen(),
      ProfileType.supplier => const SupplierProfileEditScreen(),
    };
  }
}
