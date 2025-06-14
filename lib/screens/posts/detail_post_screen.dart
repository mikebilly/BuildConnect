import 'package:buildconnect/features/profile_data/providers/profile_data_provider.dart';
import 'package:buildconnect/features/profile_data/providers/profile_data_service_provider.dart';
import 'package:buildconnect/features/profile_data/services/profile_data_service.dart';
import 'package:buildconnect/models/profile/profile_model.dart';
import 'package:buildconnect/models/profile_data/profile_data_model.dart';
import 'package:intl/intl.dart';

import 'package:buildconnect/features/posting/services/posting_service.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buildconnect/features/posting/providers/posting_provider.dart';
import 'package:buildconnect/models/post/post_model.dart';
import 'package:buildconnect/core/theme/theme.dart';
import 'package:buildconnect/shared/common_widgets.dart';
import 'package:buildconnect/shared/widgets/map_widgets.dart';
import 'package:buildconnect/shared/widgets/edit_post_widget.dart';
import 'package:buildconnect/features/auth/providers/auth_provider.dart';

import 'package:go_router/go_router.dart';
// import 'package:intl/intl.dart';

class JobPostingViewScreen extends ConsumerStatefulWidget {
  final String jobPostingId;

  const JobPostingViewScreen({super.key, required this.jobPostingId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _JobPostingViewScreenState();
  }
}

class _JobPostingViewScreenState extends ConsumerState<JobPostingViewScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final postAsync = ref.watch(postByIdProvider(widget.jobPostingId));

    return Scaffold(
      appBar: AppBar(title: const Text('Post details')),
      body: postAsync.when(
        data: (post) {
          if (post == null) {
            return const Center(child: Text("Không tìm thấy bài đăng."));
          }

          final profileDataByUserId = ref.watch(
            profileDataByUserIdProvider(post.authorId),
          );

          return profileDataByUserId.when(
            data: (profile) {
              return _buildJobPostingDetails(context, post, profile!);
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Lỗi tải dữ liệu: $e')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Lỗi tải dữ liệu: $e')),
      ),
    );
  }

  Widget _buildJobPostingDetails(
    BuildContext context,
    PostModel jobPosting,
    ProfileData profileDataByUserId,
    // WidgetRef ref,
    // PostingService jobProvider,
  ) {
    late final ProfileDataService _profileDataService = ref.read(
      profileDataServiceProvider,
    );

    final userProvider = ref.watch(authProvider);
    final isOwnJobPosting = userProvider.value?.id == jobPosting.authorId;
    final jobProvider = ref.watch(postingServiceProvider);

    // final ownerPost = _profileDataService.fetchProfile(jobPosting.authorId);
    debugPrint(
      'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx - Profile: ${isOwnJobPosting}',
    );
    debugPrint(profileDataByUserId.toString());
    // debugPrint(
    //   'vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvOwner Post: ${profileDataByUserId.profile.displayName}',
    // );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Job type tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _getJobTypeColor(
                jobPosting.jobPostingType,
              ).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              jobPosting.jobPostingType.label,
              style: TextStyle(
                color: _getJobTypeColor(jobPosting.jobPostingType),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Job title
          Text(
            jobPosting.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                // _getProfileTypeIcon(ProfileType.constructionTeam),
                jobPosting.profileType!.icon,
                color: AppColors.accent,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                jobPosting.profileType!.label,
                style: TextStyle(
                  color: AppColors.text,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 16),

          // Posted info & location
          Row(
            children: [
              const Icon(Icons.access_time, size: 16, color: AppColors.grey),
              const SizedBox(width: 4),
              Text(
                'Posted ${postedTimeAgo(jobPosting.createdAt)}',
                style: TextStyle(color: AppColors.text),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.location_on, size: 16, color: AppColors.grey),
              const SizedBox(width: 4),
              Text(
                jobPosting.location.label,
                style: TextStyle(color: AppColors.text),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Deadline if available
          if (jobPosting.deadline != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getDeadlineColor(
                  jobPosting.deadline!,
                ).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _getDeadlineColor(
                    jobPosting.deadline!,
                  ).withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.event,
                    color: _getDeadlineColor(jobPosting.deadline!),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deadline',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _getDeadlineColor(jobPosting.deadline!),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${DateFormat('MMM d, yyyy').format(jobPosting.deadline!)} (${remainingTime(jobPosting.deadline)})',
                        style: TextStyle(
                          color: _getDeadlineColor(jobPosting.deadline!),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Description
          const Text(
            'Description',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            jobPosting.description,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),

          const SizedBox(height: 24),

          // Budget
          if ((jobPosting.budget?.toString() ?? '').isNotEmpty) ...[
            const Text(
              'Budget',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.monetization_on,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    jobPosting.budget.toString() + " VNĐ",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],

          // Required skills
          if (jobPosting.requiredSkills?.isNotEmpty ?? false) ...[
            const Text(
              'Domain',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  (jobPosting.requiredSkills ?? []).map((skill) {
                    return Chip(
                      label: Text(skill.label),
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      labelStyle: TextStyle(color: AppColors.text),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 24),
          ],

          // Categories
          // if (jobPosting.categories.isNotEmpty) ...[
          //   const Text(
          //     'Categories',
          //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //   ),
          //   const SizedBox(height: 8),
          //   Wrap(
          //     spacing: 8,
          //     runSpacing: 8,
          //     children:
          //         jobPosting.categories.map((category) {
          //           return Chip(
          //             label: Text(category),
          //             backgroundColor: AppColors.accent.withValues(alpha: 0.1),
          //             labelStyle: TextStyle(color: AppColors.text),
          //           );
          //         }).toList(),
          //   ),
          //   const SizedBox(height: 24),
          // ],

          // Location Map
          const Text(
            'Location',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          LocationMapView(location: jobPosting.location.normalize_label),

          const SizedBox(height: 24),

          // Posted by
          const Text(
            'Posted By',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () {
              // Navigate to poster's profile
              context.push(
                // context,
                '/profile/view/${jobPosting.authorId}',
                //   arguments: {'profileId': jobPosting.authorId},
              );
            },
            borderRadius: BorderRadius.circular(8),
            child: Card(
              elevation: 0,
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        profileDataByUserId.profile.profileType.icon,
                        size: 30,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // jobPosting.authorId,
                            "${profileDataByUserId.profile.displayName}", // Replace with actual author name
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'View Profile',
                            style: TextStyle(color: AppColors.accent),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: AppColors.grey),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),
          // Posted by
          // const Text(
          //   'Posted By',
          //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          // ),
          // const SizedBox(height: 8),

          // FutureBuilder<Profile>(
          //   future: _profileDataService.fetchProfile(jobPosting.authorId),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const CircularProgressIndicator();
          //     } else if (snapshot.hasError) {
          //       return Text(
          //         'Lỗi khi tải thông tin người đăng: ${snapshot.error}',
          //       );
          //     } else if (!snapshot.hasData) {
          //       return const Text('Không tìm thấy thông tin người đăng');
          //     }
          //     debugPrint(
          //       'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx - Profile: ${snapshot}',
          //     );

          //     final profile = snapshot.data!;

          //     return InkWell(
          //       onTap: () {
          //         // Navigate to poster's profile
          //         Navigator.pushNamed(
          //           context,
          //           '/profile/view',
          //           arguments: {'profileId': jobPosting.authorId},
          //         );
          //       },
          //       borderRadius: BorderRadius.circular(8),
          //       child: Card(
          //         elevation: 0,
          //         color: Colors.grey[50],
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(8),
          //         ),
          //         child: Padding(
          //           padding: const EdgeInsets.all(12),
          //           child: Row(
          //             children: [
          //               Container(
          //                 width: 50,
          //                 height: 50,
          //                 decoration: BoxDecoration(
          //                   color: AppColors.primary.withOpacity(0.1),
          //                   shape: BoxShape.circle,
          //                 ),
          //                 child: const Icon(
          //                   Icons.person,
          //                   color: AppColors.primary,
          //                 ),
          //               ),
          //               const SizedBox(width: 16),
          //               Expanded(
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text(
          //                       profile.displayName ?? 'No name',
          //                       style: const TextStyle(
          //                         fontWeight: FontWeight.bold,
          //                       ),
          //                     ),
          //                     const SizedBox(height: 4),
          //                     Text(
          //                       'View Profile',
          //                       style: TextStyle(color: AppColors.accent),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //               const Icon(Icons.chevron_right, color: Colors.grey),
          //             ],
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // ),

          // const SizedBox(height: 24),

          // Contact information
          const Text(
            'Contact Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Card(
          //   elevation: 0,
          //   color: Colors.grey[50],
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(8),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.all(12),
          //     child: Column(
          //       children: [
          //         _buildContactRow(
          //           Icons.phone,
          //           'Phone',
          //           // jobPosting.contactPhone,
          //           'NumberPhone Virtual',
          //         ),
          //         const Divider(),
          //         _buildContactRow(
          //           Icons.email,
          //           'Email',
          //           // jobPosting.contactEmail,
          //           'Email Virtual',
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          heightWidget(
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...profileDataByUserId.profile.contacts.map((contact) {
                  return Card(
                    child: ListTile(
                      title: Text(contact.type.label),
                      subtitle: Text(contact.value),
                      leading: contact.type.icon(context),
                    ),
                  );
                }),
              ],
            ),
          ),

          // Edit/Delete buttons if own job posting
          if (isOwnJobPosting) ...[
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Edit',
                    onPressed: () async {
                      final result = await showDialog<bool>(
                        context: context,
                        builder:
                            (context) => EditPostDialog(
                              post: jobPosting,
                              onSave: (updatedPost) async {
                                debugPrint('Updated post: ${updatedPost}');
                                await jobProvider.updatePost(updatedPost);
                                // invalidate data riêng trong onSave để cập nhật provider bên dưới
                                ref.invalidate(
                                  postByIdProvider(updatedPost.id!),
                                );
                              },
                            ),
                      );

                      if (result == true) {
                        // Nếu edit thành công (dialog trả về true),
                        // invalidate thêm toàn bộ danh sách hoặc dữ liệu cần thiết ở màn hình cha
                        ref.invalidate(
                          allPostsProvider,
                        ); // hoặc provider bạn dùng để lấy list post

                        // Nếu bạn cần rebuild UI ở đây:
                        setState(() {});
                      }
                    },
                    isPrimary: false,
                    icon: Icons.edit,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    text: 'Delete',
                    onPressed: () {
                      // final jobProvider = Ref.watch<PostingService>();
                      _handleDeleteJobPosting(
                        context,
                        jobProvider,
                        jobPosting.id!,
                      );
                    },
                    // () => {print("Delete")},
                    isPrimary: false,
                    icon: Icons.delete,
                  ),
                ),
              ],
            ),
          ] else ...[
            // Contact button for others
            // const SizedBox(height: 32),
            // CustomButton(
            //   text: 'Contact Now',
            //   onPressed: () {
            //     // In a real app, this might open messaging or calling functionality
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       const SnackBar(
            //         content: Text(
            //           'Use the contact information above to reach out directly.',
            //         ),
            //       ),
            //     );
            //   },
            //   icon: Icons.chat,
            // ),
          ],
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: AppColors.text, fontSize: 14),
                ),
                Text(value, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getJobTypeColor(JobPostingType type) {
    switch (type) {
      case JobPostingType.hiring:
        return Colors.blue;
      case JobPostingType.partnership:
        return Colors.green;
      case JobPostingType.materials:
        return Colors.orange;
      case JobPostingType.other:
        return Colors.purple;
    }
  }

  Color _getDeadlineColor(DateTime deadline) {
    final now = DateTime.now();
    final difference = deadline.difference(now);

    if (difference.isNegative) {
      return Colors.red;
    } else if (difference.inDays < 3) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  Future<bool> _showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder:
              (dialogContext) => AlertDialog(
                title: const Text('Delete Job Posting'),
                content: const Text(
                  'Are you sure you want to delete this job posting? This action cannot be undone.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext, false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext, true),
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
        ) ??
        false;
  }

  // Separate method to handle job deletion
  Future<void> _handleDeleteJobPosting(
    BuildContext context,
    PostingService jobProvider,
    String jobPostingId,
  ) async {
    // Hiển thị hộp thoại xác nhận
    final bool shouldDelete = await _showDeleteConfirmationDialog(context);

    if (!shouldDelete) return;
    if (!mounted) return;

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    setState(() {
      _isLoading = true;
    });

    try {
      // debugPrint('Deleting job posting with ID: $jobPostingId');
      await _performJobDeletion(
        jobPostingId,
        jobProvider,
        scaffoldMessenger,
        navigator,
      );
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Failed to delete post: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Helper method to handle the actual deletion operation
  Future<void> _performJobDeletion(
    String jobPostingId,
    PostingService jobProvider,
    ScaffoldMessengerState scaffoldMessenger,
    NavigatorState navigator,
  ) async {
    try {
      // debugPrint('Deleting job posting with ID: $jobPostingId');
      await jobProvider.deleteJobPosting(jobPostingId);

      if (!mounted) return;

      // scaffoldMessenger.showSnackBar(
      //   const SnackBar(content: Text('Job posting deleted')),
      // );
      ref.invalidate(allPostsProvider);
      navigator.pop(true);
      // context.push('/feed'); // Navigate back to posts list
    } catch (e) {
      if (!mounted) return;

      // scaffoldMessenger.showSnackBar(
      //   SnackBar(content: Text('Error deleting job: $e')),
      // );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Separate method to handle toggling job active status to avoid BuildContext async gap issues
  Future<void> _handleToggleJobPostingActive(
    BuildContext context,
    PostingService jobProvider,
    String jobPostingId,
    bool isCurrentlyActive,
  ) async {
    final String successMessage =
        isCurrentlyActive ? 'Job marked as filled' : 'Job reactivated';

    // Create local references to avoid context issues
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    setState(() {
      _isLoading = true;
    });

    try {
      await jobProvider.toggleJobPostingActive(jobPostingId);

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      scaffoldMessenger.showSnackBar(SnackBar(content: Text(successMessage)));
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      scaffoldMessenger.showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  String _getTypeLabel(JobPostingType type) {
    switch (type) {
      case JobPostingType.hiring:
        return 'Hiring';
      case JobPostingType.partnership:
        return 'Partnership';
      case JobPostingType.materials:
        return 'Materials Needed';
      case JobPostingType.other:
        return 'Other';
    }
  }

  String postedTimeAgo(DateTime? datePosted) {
    if (datePosted == null) {
      return 'Unknown';
    }

    final now = DateTime.now();
    final difference = now.difference(datePosted);

    if (difference.inDays > 7) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  String remainingTime(DateTime? deadline) {
    if (deadline == null) return 'No deadline';

    final now = DateTime.now();
    final difference = deadline!.difference(now);

    if (difference.isNegative) {
      return 'Expired';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days left';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours left';
    } else {
      return 'Closing soon';
    }
  }
}
// class JobPostingDetailScreen extends StatelessWidget {
//   final String jobPostingId;

//   JobPostingDetailScreen({required this.jobPostingId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Job Posting Details')),
//       body: Center(child: Text('Job Posting ID: $jobPostingId')),
//     );
//   }
// }
