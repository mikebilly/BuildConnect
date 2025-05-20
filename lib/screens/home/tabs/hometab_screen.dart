// features/home/screens/home_tab_screen.dart (Hoặc tên file mới là home_screen.dart)
import 'package:buildconnect/core/theme/theme.dart'; // Import theme của bạn
import 'package:buildconnect/features/auth/providers/auth_provider.dart';
import 'package:buildconnect/features/auth/providers/auth_service_provider.dart'; // Giữ lại nếu vẫn dùng
import 'package:buildconnect/features/auth/services/auth_service.dart';
import 'package:buildconnect/features/home/providers/home_provider.dart';
import 'package:buildconnect/models/article/article_model.dart';
import 'package:buildconnect/models/post/post_model.dart';
import 'package:buildconnect/models/profile/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart'; // Để format ngày tháng

class HomeTabScreen extends ConsumerWidget {
  const HomeTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AuthService _authService = ref.watch(authServiceProvider);
    bool isLoggedIn = _authService.isLoggedIn;
    String? currentUserId = _authService.currentUserId;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          kToolbarHeight + 10,
        ), // Thêm padding nếu cần
        child: SafeArea(
          // Đảm bảo nội dung không bị che bởi notch
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap:
                        () => context.pushNamed(
                          'search',
                        ), // Điều hướng đến trang search
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color:
                            theme.inputDecorationTheme.fillColor ??
                            AppColors.greyBackground,
                        borderRadius: BorderRadius.circular(
                          InputDecorationConstants.borderRadiusCircular,
                        ),
                        // border: Border.all(color: theme.inputDecorationTheme.enabledBorder?.borderSide.color ?? AppColors.chipBorder)
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: theme.iconTheme.color),
                          const SizedBox(width: 8),
                          Text(
                            'Tìm kiếm hồ sơ, bài viết...',
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppColors.textLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(
                    Icons.message_outlined,
                    color: theme.iconTheme.color,
                  ),
                  tooltip: 'Tin nhắn',
                  onPressed: () {
                    if (isLoggedIn) {
                      context.push('/message/user_list_view/$currentUserId');
                    } else {
                      _showLoginRequiredDialog(context);
                    }
                  },
                ),
                IconButton(
                  icon: Stack(
                    // Để hiển thị badge thông báo (ví dụ)
                    children: [
                      Icon(
                        Icons.notifications_outlined,
                        color: theme.iconTheme.color,
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: const Text(
                            '1',
                            style: TextStyle(color: Colors.white, fontSize: 8),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  tooltip: 'Thông báo',
                  onPressed: () {
                    // TODO: Navigate to notifications screen
                    context.push('/notification'); // Ví dụ
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        // Cho phép kéo để làm mới
        onRefresh: () async {
          ref.invalidate(constructionNewsProvider);
          ref.invalidate(recentPostsProvider);
          ref.invalidate(suggestedConnectionsProvider);
          // Chờ một chút để đảm bảo các provider được refresh trước khi FutureBuilder rebuild
          await Future.delayed(const Duration(milliseconds: 500));
        },
        child: ListView(
          padding: EdgeInsets.all(8),
          children: [
            // Phần "Đề nghị đăng nhập" có thể hiển thị ở đây nếu muốn
            // if (!isLoggedIn) _buildLoginPrompt(context, theme),
            _buildSectionTitle(context, 'Tin tức Xây dựng mới nhất', () {
              // TODO: Navigate to full news list screen
            }),
            _buildHorizontalList<ArticleModel>(
              context: context,
              asyncValue: ref.watch(constructionNewsProvider),
              itemBuilder: (article) => _buildArticleCard(context, article),
              placeholderMessage: "Đang tải tin tức...",
              emptyMessage: "Không có tin tức nào.",
              height: 260, // Điều chỉnh chiều cao cho phù hợp
            ),
            const SizedBox(height: 16), // Sử dụng padding từ theme

            _buildSectionTitle(context, 'Bài viết gần đây', () {
              // TODO: Navigate to full posts list screen
            }),
            _buildHorizontalList<PostModel>(
              context: context,
              asyncValue: ref.watch(recentPostsProvider),
              itemBuilder: (post) => _buildPostCard(context, post),
              placeholderMessage: "Đang tải bài viết...",
              emptyMessage: "Chưa có bài viết nào.",
              height: 180, // Điều chỉnh chiều cao
            ),
            const SizedBox(height: 16),

            _buildSectionTitle(context, 'Bạn có thể biết', () {
              // TODO: Navigate to full connections list screen
            }),
            _buildHorizontalList<Profile>(
              context: context,
              asyncValue: ref.watch(suggestedConnectionsProvider),
              itemBuilder:
                  (user) => _buildConnectionCard(context, user, isLoggedIn),
              placeholderMessage: "Đang tìm gợi ý...",
              emptyMessage: "Không tìm thấy gợi ý kết nối.",
              height: 150, // Điều chỉnh chiều cao
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showLoginRequiredDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Yêu cầu đăng nhập'),
            content: const Text('Bạn cần đăng nhập để sử dụng chức năng này.'),
            actions: [
              TextButton(
                child: const Text('Để sau'),
                onPressed: () => Navigator.of(ctx).pop(),
              ),
              TextButton(
                child: const Text('Đăng nhập'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  context.push('/login');
                },
              ),
            ],
          ),
    );
  }

  Widget _buildSectionTitle(
    BuildContext context,
    String title,
    VoidCallback onViewMore,
  ) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 8, left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.textTheme.headlineSmall?.copyWith(fontSize: 18),
          ),
          // TextButton(
          //   onPressed: onViewMore,
          //   child: Text('Xem thêm', style: TextStyle(color: theme.colorScheme.primary)),
          // ),
        ],
      ),
    );
  }

  Widget _buildHorizontalList<T>({
    required BuildContext context,
    required AsyncValue<List<T>> asyncValue,
    required Widget Function(T item) itemBuilder,
    required String placeholderMessage,
    required String emptyMessage,
    double height = 200,
  }) {
    final theme = Theme.of(context);
    return asyncValue.when(
      data: (items) {
        if (items.isEmpty) {
          return SizedBox(
            height: height / 2, // Chiều cao nhỏ hơn cho thông báo
            child: Center(
              child: Text(emptyMessage, style: theme.textTheme.bodyMedium),
            ),
          );
        }
        return SizedBox(
          height: height,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 8 : 0,
                  right: 8 / 2,
                ), // Thêm padding cho item đầu và giữa các item
                child: itemBuilder(items[index]),
              );
            },
          ),
        );
      },
      loading:
          () => SizedBox(
            height: height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 8),
                  Text(placeholderMessage, style: theme.textTheme.bodySmall),
                ],
              ),
            ),
          ),
      error:
          (err, stack) => SizedBox(
            height: height / 2,
            child: Center(
              child: Text(
                'Lỗi: ${err.toString()}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ),
          ),
    );
  }

  Widget _buildArticleCard(BuildContext context, ArticleModel article) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    Future<void> _launchArticleUrl() async {
      if (article.url == null || article.url!.isEmpty) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Không tìm thấy đường dẫn bài báo.')),
          );
        }
        return;
      }

      final Uri uriToLaunch = Uri.parse(article.url!);

      if (await canLaunchUrl(uriToLaunch)) {
        try {
          // Mở URL
          await launchUrl(uriToLaunch, mode: LaunchMode.externalApplication);
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Không thể mở đường dẫn: $e')),
            );
          }
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Không thể mở đường dẫn: ${article.url}')),
          );
        }
      }
    }

    return InkWell(
      onTap: () {
        debugPrint(article.url);
        _launchArticleUrl();
      },
      child: Card(
        elevation: 2, // Card theme sẽ quản lý
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(InputDecorationConstants.profileCardBorderRadius)),
        child: SizedBox(
          width: 200, // Chiều rộng card
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Image.network(
                  article.imageUrl,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        height: 120,
                        color: AppColors.greyBackground,
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: AppColors.grey,
                            size: 40,
                          ),
                        ),
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: textTheme.titleMedium?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      article.description,
                      style: textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        color: AppColors.textLight,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            article.sourceName,
                            style: textTheme.bodySmall?.copyWith(
                              fontSize: 10,
                              fontStyle: FontStyle.italic,
                              color: theme.colorScheme.primary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          DateFormat('dd/MM/yyyy').format(article.publishedAt),
                          style: textTheme.bodySmall?.copyWith(
                            fontSize: 10,
                            color: AppColors.textLight,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, PostModel post) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return InkWell(
      onTap: () {
        // TODO: Navigate to post detail screen
        context.push('/job-posting/view/${post.id}'); // Ví dụ
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 12,
            left: 12,
            right: 12,
            bottom: 8,
          ),
          child: SizedBox(
            width: 280,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1) Title và “x ngày trước”
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.people),
                          SizedBox(width: 5),
                          Text(
                            post.title,
                            style: textTheme.titleMedium?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      // tính số ngày
                      post.createdAt != null
                          ? timeAgo(post.createdAt!)
                          : 'Không rõ',
                      style: textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // 2) Deadline
                Row(
                  children: [
                    Icon(Icons.watch_later_outlined),
                    SizedBox(width: 5),
                    Text(
                      post.deadline != null
                          ? 'Deadline: ${DateFormat.yMMMd().format(post.deadline!)}'
                          : 'Deadline: Không có',
                      style: textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // 3) Mô tả ngắn
                Text(
                  post.description,
                  style: textTheme.bodySmall?.copyWith(fontSize: 13),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(), // <<<< THÊM SPACER Ở ĐÂY
                // --- Footer: Skills và Job Type ---
                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.end, // Căn các item trong Row theo đáy
                  children: [
                    // Phần Yêu cầu kỹ năng (bên trái)
                    Expanded(
                      // Để skills chiếm không gian còn lại và wrap nếu cần
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize:
                            MainAxisSize.min, // Để Column chỉ cao bằng nội dung
                        children: [
                          Text(
                            'Domain:', // Rút gọn label
                            style: textTheme.labelMedium?.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textLight,
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (post.requiredSkills == null ||
                              post.requiredSkills!.isEmpty)
                            Text(
                              'Không yêu cầu cụ thể',
                              style: textTheme.bodySmall?.copyWith(
                                fontSize: 11,
                                color: AppColors.textLight,
                              ),
                            )
                          else
                            Wrap(
                              spacing: 6.0,
                              runSpacing: 4.0,
                              children:
                                  post.requiredSkills!
                                      .take(
                                        3,
                                      ) // Giới hạn số lượng skill hiển thị
                                      .map(
                                        (skill) => Chip(
                                          label: Text(skill.label),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 2,
                                          ), // Điều chỉnh padding chip
                                          labelStyle: textTheme.bodySmall
                                              ?.copyWith(
                                                fontSize: 10,
                                                color:
                                                    AppTheme
                                                        .lightTheme
                                                        .primaryColor,
                                                // Màu chữ từ theme
                                              ),
                                          backgroundColor: AppTheme
                                              .lightTheme
                                              .primaryColor
                                              .withOpacity(
                                                0.1,
                                              ), // Màu nền từ theme
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                            side: BorderSide.none,
                                          ),
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                      )
                                      .toList(),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      width: 8,
                    ), // Khoảng cách giữa skills và job type
                    // Phần Loại hình công việc (bên phải)
                    if (post.jobPostingType != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.primaryColor.withOpacity(
                            0.15,
                          ), // Sử dụng secondary color từ theme
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          post
                              .jobPostingType!
                              .label, // Giả sử jobPostingType có thuộc tính label
                          style: textTheme.bodySmall?.copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color:
                                AppTheme
                                    .lightTheme
                                    .primaryColor, // Màu chữ từ theme
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConnectionCard(
    BuildContext context,
    Profile profile,
    bool isLoggedIn,
  ) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return InkWell(
      onTap: () {
        // TODO: Navigate to user profile screen
        context.push('/profile/view/${profile.userId}'); // Ví dụ
      },
      child: Card(
        elevation: 2,
        child: Container(
          width: 190,
          height: 120,
          padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Avatar
              CircleAvatar(
                radius: 16,
                backgroundColor: AppTheme.lightTheme.primaryColor,
                child: Text(
                  profile.displayName.isNotEmpty
                      ? profile.displayName[0].toUpperCase()
                      : '?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 8), // khoảng cách dọc
              // Thông tin text, co dãn nếu cần
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      profile.displayName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.badge_outlined),
                        SizedBox(width: 5),
                        Text(
                          'Loại: ${profile.profileType.name}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_city_outlined),
                        SizedBox(width: 5),
                        Text(
                          'TP: ${profile.mainCity.label}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.star_border_outlined),
                        SizedBox(width: 5),
                        Text(
                          'Kinh nghiệm: ${profile.yearsOfExperience} năm',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Nút hành động: đặt trong Wrap để khi hẹp nó xuống dòng
              // Wrap(
              //   spacing: 8,
              //   runSpacing: 4,
              //   alignment: WrapAlignment.center,
              //   children: [
              //     IconButton(
              //       icon: const Icon(Icons.arrow_forward_ios, size: 16),
              //       onPressed: () {
              //         context.push('/profile/view/${profile.userId}');
              //       },
              //     ),
              //     IconButton(
              //       icon: const Icon(Icons.message, size: 16),
              //       onPressed: () {
              //         if (isLoggedIn) {
              //           context.push('/message/detail_view/${profile.userId}');
              //         } else {
              //           showDialog(
              //             context: context,
              //             builder: (context) {
              //               return AlertDialog(
              //                 title: const Text('Thông báo'),
              //                 content: const Text(
              //                   'Bạn cần đăng nhập để gửi tin nhắn.',
              //                 ),
              //                 actions: [
              //                   TextButton(
              //                     onPressed: () {
              //                       context.pop();
              //                     },
              //                     child: const Text('Đóng'),
              //                   ),
              //                   TextButton(
              //                     onPressed: () {
              //                       context.pop();
              //                       context.push('/login');
              //                     },
              //                     child: const Text('Đăng nhập'),
              //                   ),
              //                 ],
              //               );
              //             },
              //           );
              //         }
              //       },
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

String timeAgo(DateTime dt) {
  final days = DateTime.now().difference(dt).inDays;
  return days == 0 ? 'Hôm nay' : '$days ngày trước';
}
