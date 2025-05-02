import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buildconnect/features/profile_data/providers/profile_data_provider.dart';

class ProfileViewScreen extends ConsumerStatefulWidget {
  final String? userId;

  const ProfileViewScreen({super.key, required this.userId});

  @override
  ConsumerState<ProfileViewScreen> createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends ConsumerState<ProfileViewScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.userId == null) {
      return const Center(child: Text('User ID is null'));
    }

    final profileDataByUserId = ref.watch(
      profileDataByUserIdProvider(widget.userId!),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Profile View')),
      body: profileDataByUserId.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (profileData) {
          if (profileData == null) {
            return const Center(child: Text('No profile data found'));
          } else {
            return SingleChildScrollView(
              child: Center(
                child: Text('Profile Data: ${profileData.toString()}'),
              ),
            );
          }
        },
      ),
    );
  }
}
