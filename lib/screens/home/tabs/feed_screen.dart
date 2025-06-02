import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buildconnect/features/posting/providers/posting_provider.dart';
import 'package:buildconnect/models/post/post_model.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:buildconnect/core/theme/theme.dart';

import 'package:go_router/go_router.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  // Helper method to get the color for the job type
  Color _getJobTypeColor(JobPostingType type) {
    switch (type) {
      case JobPostingType.hiring:
        return AppColors.primary;
      case JobPostingType.partnership:
        return AppColors.primary;

      case JobPostingType.materials:
        return AppColors.primary;

      case JobPostingType.other:
        return AppColors.primary;
        ;

      default:
        return Colors.grey;
    }
  }

  // Helper method to get the color for the deadline
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allPostsAsync = ref.watch(allPostsProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: allPostsAsync.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const Center(child: Text('Chưa có bài đăng nào.'));
          }
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              final duration = DateTime.now().difference(post.createdAt!);
              final timeAgo =
                  duration.inHours >= 24
                      ? '${duration.inDays} days ago'
                      : '${duration.inHours} hours ago';
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with activity info
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            // _getProfileTypeIcon(ProfileType.constructionTeam),
                            post.profileType!.icon,
                            color: AppColors.accent,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            post.profileType!.label,
                            style: TextStyle(
                              color: AppColors.text,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'Posted $timeAgo',
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Job posting info
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Job type tag
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getJobTypeColor(
                                post.jobPostingType,
                              ).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              post.jobPostingType.label,
                              style: TextStyle(
                                color: _getJobTypeColor(post.jobPostingType),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Job title
                          Text(
                            post.title, // Display actual job title
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          // Posted by & location
                          // Row(
                          //   children: [
                          //     // const Icon(
                          //     //   Icons.person,
                          //     //   size: 16,
                          //     //   color: Colors.grey,
                          //     // ),
                          //     // const SizedBox(width: 4),
                          //     // Text(
                          //     //   'Posted by ${post.authorId}', // Replace with actual author info
                          //     //   style: TextStyle(color: Colors.grey),
                          //     // ),
                          //     // const SizedBox(width: 16),
                          //     const Icon(
                          //       Icons.location_on,
                          //       size: 16,
                          //       color: Colors.grey,
                          //     ),
                          //     const SizedBox(width: 4),
                          //     Expanded(
                          //       child: Text(
                          //         post.location.label, // Display job location
                          //         style: TextStyle(color: Colors.grey),
                          //         maxLines: 1,
                          //         overflow: TextOverflow.ellipsis,
                          //       ),
                          //     ),
                          //     const SizedBox(width: 8),

                          //     // Working mode bên phải
                          //     if (post.workingMode != null) ...[
                          //       const Icon(
                          //         Icons.work_outline,
                          //         size: 16,
                          //         color: Colors.grey,
                          //       ),
                          //       const SizedBox(width: 4),
                          //       Text(
                          //         post.workingMode!.label,
                          //         style: TextStyle(color: Colors.grey),
                          //         overflow: TextOverflow.ellipsis,
                          //       ),
                          //     ],
                          //   ],
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Location bên trái
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      size: 16,
                                      color: AppColors.text,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      post.location.label,
                                      style: TextStyle(color: AppColors.text),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),

                                // Working mode bên phải
                                if (post.workingMode != null)
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.work_outline,
                                        size: 16,
                                        color: AppColors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        post
                                            .workingMode!
                                            .label, // Optional: viết hoa chữ cái đầu
                                        style: TextStyle(
                                          color: AppColors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),

                          // Description
                          Text(
                            post.description ??
                                'No description provided', // Display job description
                            style: TextStyle(color: AppColors.text),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                    // Actions
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (post.deadline != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _getDeadlineColor(
                                  post.deadline!,
                                ).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                post.deadline == null
                                    ? 'Unknown'
                                    : post.deadline!.isBefore(DateTime.now())
                                    ? 'Expired'
                                    : post.deadline!
                                            .difference(DateTime.now())
                                            .inDays >
                                        0
                                    ? 'Deadline in ${post.deadline!.difference(DateTime.now()).inDays} days'
                                    : 'Deadline today',

                                style: TextStyle(
                                  color: _getDeadlineColor(post.deadline!),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          TextButton.icon(
                            onPressed: () {
                              debugPrint(post.id);
                              context.push('/job-posting/view/${post.id}');
                            },

                            icon: const Icon(Icons.visibility, size: 16),
                            label: const Text('View Details'),
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.accent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Lỗi: $err')),
      ),
    );
  }
}
