import 'package:buildconnect/features/auth/providers/auth_provider.dart';
import 'package:buildconnect/screens/profile/profile_view/widgets/profile_view_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buildconnect/features/profile_data/providers/profile_data_provider.dart';
import 'package:buildconnect/models/profile_data/profile_data_model.dart';
import 'package:buildconnect/core/theme/theme.dart';
import 'package:go_router/go_router.dart';

class ProfileViewScreen extends ConsumerStatefulWidget {
  final String? userId;

  const ProfileViewScreen({super.key, required this.userId});

  @override
  ConsumerState<ProfileViewScreen> createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends ConsumerState<ProfileViewScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

    if (widget.userId == null) {
      return const Center(child: Text('User ID is null'));
    }

    final profileDataByUserId = ref.watch(
      profileDataByUserIdProvider(widget.userId!),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile View'),
        actions: [
          if (widget.userId != null && widget.userId == auth.asData?.value?.id)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // Navigate to the edit screen
                context.push('/profile/edit');
              },
            ),
        ],
      ),
      body: profileDataByUserId.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (profileData) {
          if (profileData == null) {
            return const Center(child: Text('No profile data found'));
          } else {
            return Column(
              children: [
                Container(height: 70, color: AppColors.primary),
                Expanded(
                  child: _buildShiftedWidget(
                    context,
                    _buildBodySection(context, profileData),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

Widget _buildShiftedWidget(BuildContext context, Widget child) {
  return Transform.translate(offset: const Offset(0, -65), child: child);
}

Widget _buildBodySection(BuildContext context, ProfileData profileData) {
  return Column(
    children: [
      _buildAvatar(context, profileData),
      const SizedBox(height: 10),
      const Divider(height: 0.5, color: AppColors.greyBackground),
      Expanded(child: ProfileViewTabs(profileData: profileData)),
    ],
  );
}

Widget _buildAvatar(BuildContext context, ProfileData profileData) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 45,
            backgroundColor: AppColors.primary,
            child: Icon(
              profileData.profile.profileType.icon,
              size: 75,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(profileData.profile.displayName, style: AppTextStyles.title),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.greyBackground,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            profileData.profile.profileType.label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.location_on, color: AppColors.grey),
            SizedBox(width: 4),
            Text(
              'Ho Chi Minh city, Vietnam',
              style: TextStyle(color: AppColors.grey),
            ),
          ],
        ),
      ],
    ),
  );
}
