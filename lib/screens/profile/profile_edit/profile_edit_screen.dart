import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:buildconnect/features/profile_data/providers/profile_data_provider.dart';

import 'package:buildconnect/models/enums/enums.dart';

import 'package:buildconnect/screens/profile/profile_edit/tab_screens/basic_info_tab_screen.dart';
import 'package:buildconnect/screens/profile/profile_edit/tab_screens/professional_info_tab_screen.dart';
import 'package:buildconnect/screens/profile/profile_edit/tab_screens/contacts_tab_screen.dart';

class ProfileEditScreen extends ConsumerStatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  ConsumerState<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<ProfileEditScreen> {
  final basicInfoKey = GlobalKey<BasicInfoTabScreenState>();
  final professionalInfoKey = GlobalKey<ProfessionalInfoTabScreenState>();
  final contactsKey = GlobalKey<ContactsTabScreenState>();

  Future<void> _submit() async {
    debugPrint('submit called');
    debugPrint('Dumping all controllers from all screens');
    await _dumpAllTabControllers();

    // await Future.delayed(const Duration(milliseconds: 100)).then((_) {
    //   debugPrint('Dumped all controllers from all screens');
    // });

    final profileDataNotifier = ref.read(profileDataNotifierProvider.notifier);
    try {
      await profileDataNotifier.updateProfileData();
      if (mounted) {
        debugPrint('Profile updated successfully');
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('Profile updated successfully')),
        // );
      }
    } catch (e) {
      if (mounted) {
        debugPrint('Error');
        // ScaffoldMessenger.of(
        //   context,
        // ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  void _navigateToHomeScreen() {
    context.go('/');
  }

  Future<void> _dumpAllTabControllers() async {
    await basicInfoKey.currentState?.dumpFromControllers();
    await professionalInfoKey.currentState?.dumpFromControllers();
    await contactsKey.currentState?.dumpFromControllers();
  }

  @override
  void initState() {
    super.initState();

    // ✅ This ensures fresh data is fetched when entering the screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(profileDataNotifierProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileDataNotifier = ref.read(profileDataNotifierProvider.notifier);
    final profileData = ref.watch(profileDataNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile Edit')),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Basic Info'),
                Tab(text: 'Professional Info'),
                Tab(text: 'Contacts'),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: profileData.when(
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error:
                      (error, stack) => Center(
                        child: Text('Error at loading profile: $error'),
                      ),
                  data: (data) {
                    if (data == null) {
                      return const Center(
                        // child: Text('No profile data available'),
                        child: CircularProgressIndicator(),
                      );
                    }

                    return TabBarView(
                      children: [
                        BasicInfoTabScreen(key: basicInfoKey),
                        ProfessionalInfoTabScreen(
                          key: professionalInfoKey,
                          profileType: data.profile.profileType,
                        ),
                        ContactsTabScreen(key: contactsKey),
                      ],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                // height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint('Hit the button');
                    if (profileData.isLoading) {
                      debugPrint('Loading...');
                      return;
                    } else {
                      debugPrint('About to call _submit');
                      _submit();
                    }
                  },
                  child:
                      profileData.isLoading
                          ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                              backgroundColor: Colors.transparent,
                            ),
                          )
                          : const Text('Save Changes'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
