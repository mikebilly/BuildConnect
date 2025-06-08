import 'package:buildconnect/core/theme/theme.dart';
import 'package:buildconnect/features/auth/providers/auth_provider.dart';
import 'package:buildconnect/features/auth/providers/auth_service_provider.dart';
import 'package:buildconnect/features/auth/services/auth_service.dart';
import 'package:buildconnect/features/conversation/providers/conversation_provider.dart';
import 'package:buildconnect/features/home/providers/home_provider.dart';
import 'package:buildconnect/features/message/providers/message_provider.dart';
import 'package:buildconnect/features/notification/providers/notification_provider.dart';
import 'package:buildconnect/models/article/article_model.dart';
import 'package:buildconnect/models/post/post_model.dart';
import 'package:buildconnect/models/profile/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeTabScreen extends ConsumerStatefulWidget {
  const HomeTabScreen({super.key});

  @override
  ConsumerState<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends ConsumerState<HomeTabScreen> {
  @override
  void initState() {
    super.initState();
    // You can initialize any necessary data here if needed
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = ref.watch(authServiceProvider);
    bool isLoggedIn = authService.isLoggedIn;
    String? currentUserId = authService.currentUserId;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    int unreadNotifications = ref.watch(unreadNotificationCountProvider);
    // final totalUnreadAsync = ref.watch(totalUnreadMessagesCountProvider);
    final totalUnreadAsync = ref.watch(totalUnreadMessagesCountStreamProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 10),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => context.pushNamed('search'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: theme.inputDecorationTheme.fillColor,
                        borderRadius: BorderRadius.circular(
                          InputDecorationConstants.borderRadiusCircular,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: theme.iconTheme.color),
                          const SizedBox(width: 8),
                          Text(
                            'Search now...',
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
                  icon: Stack(
                    children: [
                      Icon(
                        Icons.message_outlined,
                        color: theme.iconTheme.color,
                      ),
                      if (totalUnreadAsync.value != null &&
                          totalUnreadAsync.value! > 0)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: AppColors.notification,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 12,
                              minHeight: 12,
                            ),
                            child: Text(
                              totalUnreadAsync.value.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                  tooltip: 'Messages',
                  onPressed: () {
                    if (isLoggedIn) {
                      context.push('/message/user_list_view');
                    } else {
                      _showLoginRequiredDialog(context);
                    }
                  },
                ),
                IconButton(
                  icon: Stack(
                    children: [
                      Icon(
                        Icons.notifications_outlined,
                        color: theme.iconTheme.color,
                      ),
                      if (unreadNotifications > 0)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: AppColors.notification,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 12,
                              minHeight: 12,
                            ),
                            child: Text(
                              unreadNotifications.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                  tooltip: 'Notifications',
                  onPressed: () {
                    context.push('/notification');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(constructionNewsProvider);
          ref.invalidate(recentPostsProvider);
          ref.invalidate(suggestedConnectionsProvider);
          await Future.delayed(const Duration(milliseconds: 500));
        },
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            _buildSectionTitle(context, 'Latest Construction News', () {}),
            _buildHorizontalList<ArticleModel>(
              context: context,
              asyncValue: ref.watch(constructionNewsProvider),
              itemBuilder: (article) => _buildArticleCard(context, article),
              placeholderMessage: "Loading news...",
              emptyMessage: "No news available.",
              height: 260,
            ),
            const SizedBox(height: 16),
            _buildSectionTitle(context, 'Recent Posts', () {}),
            _buildHorizontalList<PostModel>(
              context: context,
              asyncValue: ref.watch(recentPostsProvider),
              itemBuilder: (post) => _buildPostCard(context, post),
              placeholderMessage: "Loading posts...",
              emptyMessage: "No posts available.",
              height: 180,
            ),
            const SizedBox(height: 16),
            _buildSectionTitle(context, 'Similar Profiles', () {}),
            _buildHorizontalList<Profile>(
              context: context,
              asyncValue: ref.watch(suggestedConnectionsProvider),
              itemBuilder:
                  (user) => _buildConnectionCard(context, user, isLoggedIn),
              placeholderMessage: "Finding suggestions...",
              emptyMessage: "No connection suggestions found.",
              height: 150,
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
            title: const Text('Login Required'),
            content: const Text('You need to login to use this feature.'),
            actions: [
              TextButton(
                child: const Text('Later'),
                onPressed: () => Navigator.of(ctx).pop(),
              ),
              TextButton(
                child: const Text('Login'),
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
            height: height / 2,
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
                ),
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
                'Error: ${err.toString()}',
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
            const SnackBar(content: Text('Article URL not found.')),
          );
        }
        return;
      }

      final Uri uriToLaunch = Uri.parse(article.url!);

      try {
        final launched = await launchUrl(
          uriToLaunch,
          mode: LaunchMode.externalApplication,
        );

        if (!launched && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not open URL: ${article.url}')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error opening URL: $e')));
        }
      }
    }

    return InkWell(
      onTap: () {
        debugPrint(article.url);
        _launchArticleUrl();
      },
      child: Card(
        elevation: 2,
        child: SizedBox(
          width: 200,
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
                padding: const EdgeInsets.all(8),
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
        context.push('/job-posting/view/${post.id}');
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.people, size: 20),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              post.title,
                              style: textTheme.titleMedium?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      post.createdAt != null
                          ? timeAgo(post.createdAt!)
                          : 'Unknown',
                      style: textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.watch_later_outlined),
                    const SizedBox(width: 5),
                    Text(
                      post.deadline != null
                          ? 'Deadline: ${DateFormat.yMMMd().format(post.deadline!)}'
                          : 'Deadline: None',
                      style: textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  post.description,
                  style: textTheme.bodySmall?.copyWith(fontSize: 13),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Domain:',
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
                              'No specific requirements',
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
                                      .take(2)
                                      .map(
                                        (skill) => Chip(
                                          label: Text(skill.label),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 2,
                                          ),
                                          labelStyle: textTheme.bodySmall
                                              ?.copyWith(
                                                fontSize: 10,
                                                color:
                                                    AppTheme
                                                        .lightTheme
                                                        .primaryColor,
                                              ),
                                          backgroundColor: AppTheme
                                              .lightTheme
                                              .primaryColor
                                              .withOpacity(0.1),
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
                    const SizedBox(width: 8),
                    if (post.jobPostingType != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.primaryColor.withOpacity(
                            0.15,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          post.jobPostingType!.label,
                          style: textTheme.bodySmall?.copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.lightTheme.primaryColor,
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
        context.push('/profile/view/${profile.userId}');
      },
      child: Card(
        elevation: 2,
        child: Container(
          width: 190,
          height: 120,
          padding: const EdgeInsets.only(left: 9, top: 9, bottom: 9, right: 9),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: AppTheme.lightTheme.primaryColor,
                child: Icon(
                  profile.profileType.icon,
                  color: AppColors.background,
                ),
              ),
              const SizedBox(height: 8),
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
                      children: [
                        const Icon(Icons.badge_outlined),
                        const SizedBox(width: 5),
                        Text(
                          'Type: ${profile.profileType.label}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_city_outlined),
                        const SizedBox(width: 5),
                        Text(
                          'City: ${profile.mainCity.label}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star_border_outlined),
                        const SizedBox(width: 5),
                        Text(
                          'YoE: ${profile.yearsOfExperience} Years',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
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
}

String timeAgo(DateTime dt) {
  final days = DateTime.now().difference(dt).inDays;
  if (days == 0) return 'Today';
  if (days == 1) return 'Yesterday';
  return '$days days ago';
}
