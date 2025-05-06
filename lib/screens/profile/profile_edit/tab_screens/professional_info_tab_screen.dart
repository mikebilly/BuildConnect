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
      ProfessionalInfoTabScreenState();
}

class ProfessionalInfoTabScreenState
    extends ConsumerState<ProfessionalInfoTabScreen> {
  final architectProfileKey = GlobalKey<ArchitectProfileEditScreenState>();
  final contractorProfileKey = GlobalKey<ContractorProfileEditScreenState>();
  final constructionTeamKey = GlobalKey<ConstructionTeamProfileEditScreenState>();
  final supplierProfileKey = GlobalKey<SupplierProfileEditScreenState>();

  Future<void> dumpFromControllers() async {
    await architectProfileKey.currentState?.dumpFromControllers();
    await contractorProfileKey.currentState?.dumpFromControllers();
    await constructionTeamKey.currentState?.dumpFromControllers();
    await supplierProfileKey.currentState?.dumpFromControllers();
  }

  @override
  Widget build(BuildContext context) {
    return switch (widget.profileType as ProfileType) {
      ProfileType.architect => ArchitectProfileEditScreen(key: architectProfileKey),
      ProfileType.contractor => ContractorProfileEditScreen(key: contractorProfileKey),
      ProfileType.constructionTeam => ConstructionTeamProfileEditScreen(key: constructionTeamKey),
      ProfileType.supplier => SupplierProfileEditScreen(key: supplierProfileKey),
    };
  }
}
