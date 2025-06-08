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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(profileDataByUserIdProvider(widget.userId!));
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final bool isLoggedIn = auth.asData?.value != null;
    final bool isMe = widget.userId != null && widget.userId == auth.asData?.value?.id;

    if (widget.userId == null) {
      return const Center(child: Text('User ID is null'));
    }

    final profileDataByUserId = ref.watch(profileDataByUserIdProvider(widget.userId!));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile View'),
        actions: [
          if (isMe)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
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
            return Stack(
              children: [
                Container(height: 70, color: AppColors.primary),
                Column(
                  children: [
                    const SizedBox(height: 5),
                    _buildAvatar(
                      context,
                      profileData,
                      isLoggedIn,
                      widget.userId!,
                      isMe,
                    ),
                    const SizedBox(height: 10),
                    const Divider(height: 0.5, color: AppColors.greyBackground),
                    Expanded(child: ProfileViewTabs(profileData: profileData)),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

Widget _buildAvatar(
  BuildContext context,
  ProfileData profileData,
  bool isLoggedIn,
  String currentProfileUserId,
  bool isMe,
) {
  final address = [
    profileData.profile.mainAddress?.trim(),
    profileData.profile.mainCity.label.trim()
  ].where((e) => e != null && e.isNotEmpty).join(', ');

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
              size: 60,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(profileData.profile.displayName, style: AppTextStyles.title),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.greyBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                profileData.profile.profileType.label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(width: 5),
            if (!isMe)
              InkWell(
                onTap: () {
                  if (isLoggedIn) {
                    context.push('/message/detail_view/$currentProfileUserId');
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Notification'),
                          content: const Text('You need to login to send messages.'),
                          actions: [
                            TextButton(
                              onPressed: () => context.pop(),
                              child: const Text('Close'),
                            ),
                            TextButton(
                              onPressed: () {
                                context.pop();
                                context.push('/login');
                              },
                              child: const Text('Login'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: AppColors.greyBackground,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.message, size: 16),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        if (address.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, color: AppColors.grey),
              const SizedBox(width: 4),
              Text(address, style: const TextStyle(color: AppColors.grey)),
            ],
          ),
      ],
    ),
  );
}
