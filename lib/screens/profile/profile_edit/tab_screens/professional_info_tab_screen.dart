import 'package:buildconnect/features/profile_data/providers/profile_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfessionalInfoTabScreen extends ConsumerStatefulWidget {
  const ProfessionalInfoTabScreen({super.key});

  @override
  ConsumerState<ProfessionalInfoTabScreen> createState() => _ProfessionalInfoTabScreenState();
}

class _ProfessionalInfoTabScreenState extends ConsumerState<ProfessionalInfoTabScreen> {
  late final ProfileDataNotifier _profileDataNotifier;

  @override
  void initState() {
    super.initState();
    _profileDataNotifier = ref.read(profileDataNotifierProvider.notifier);
  }

  @override
  void dispose() {
    Future(() {
      // _profileDataNotifier.dumpFromControllers();
    });

    // _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileData = ref.watch(profileDataNotifierProvider);

    // Bind controller only once when data is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final data = profileData.valueOrNull;
      if (data != null) {
        // _email.text = data.email;
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Professional Info"),
          ],
        ),
      ),
    );
  }
}
