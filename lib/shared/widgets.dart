import 'package:flutter/material.dart';
import 'package:buildconnect/models/enums/enum.dart';

import 'package:buildconnect/core/theme/theme.dart';

class ProfileCard extends StatelessWidget {
  final ProfileModel profile;
  final VoidCallback onTap;

  const ProfileCard({super.key, required this.profile, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child:
                          profile.projectImages.isNotEmpty
                              ? Image.network(
                                profile.projectImages.first,
                                fit: BoxFit.cover,
                                loadingBuilder: (
                                  context,
                                  child,
                                  loadingProgress,
                                ) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    color: Colors.grey[200],
                                    child: const Icon(
                                      Icons.person,
                                      size: 40,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                                errorBuilder:
                                    (context, error, stackTrace) => Container(
                                      color: Colors.grey[200],
                                      child: const Icon(
                                        Icons.error,
                                        size: 40,
                                        color: AppColors.error,
                                      ),
                                    ),
                              )
                              : Container(
                                color: Colors.grey[200],
                                child: Icon(
                                  _getProfileTypeIcon(profile.type),
                                  size: 40,
                                  color: Colors.grey,
                                ),
                              ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.name,
                          style: AppTextStyles.subheading,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getProfileTypeLabel(profile.type),
                          style: AppTextStyles.caption,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 16,
                              color: AppColors.textLight,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                profile.location,
                                style: AppTextStyles.small.copyWith(
                                  color: AppColors.textLight,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Text(
                profile.description,
                style: AppTextStyles.body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      RatingDisplay(rating: profile.averageRating),
                      const SizedBox(width: 8),
                      Text(
                        '(${profile.reviews.length})',
                        style: AppTextStyles.small.copyWith(
                          color: AppColors.textLight,
                        ),
                      ),
                    ],
                  ),
                  TextButton.icon(
                    onPressed: onTap,
                    icon: const Icon(Icons.visibility, size: 16),
                    label: const Text('View Profile'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.accent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getProfileTypeIcon(ProfileType type) {
    switch (type) {
      case ProfileType.architect:
        return Icons.architecture;
      case ProfileType.contractor:
        return Icons.business;
      case ProfileType.constructionTeam:
        return Icons.people;
      case ProfileType.supplier:
        return Icons.inventory;
    }
  }

  String _getProfileTypeLabel(ProfileType type) {
    switch (type) {
      case ProfileType.architect:
        return 'Architect';
      case ProfileType.contractor:
        return 'Contractor';
      case ProfileType.constructionTeam:
        return 'Construction Team';
      case ProfileType.supplier:
        return 'Material Supplier';
    }
  }
}

class JobPostingCard extends StatelessWidget {
  final JobPostingModel jobPosting;
  final VoidCallback onTap;

  const JobPostingCard({
    super.key,
    required this.jobPosting,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getJobTypeColor(
                    jobPosting.type,
                  ).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  jobPosting.typeLabel,
                  style: AppTextStyles.small.copyWith(
                    color: _getJobTypeColor(jobPosting.type),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              Text(
                jobPosting.title,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              Text(
                jobPosting.location.address,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),

              Text(
                jobPosting.description,
                style: AppTextStyles.body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (jobPosting.budget.isNotEmpty) ...[
                        const Icon(
                          Icons.monetization_on,
                          size: 16,
                          color: AppColors.textLight,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          jobPosting.budget,
                          style: AppTextStyles.small.copyWith(
                            color: AppColors.textLight,
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                      const Icon(
                        Icons.access_time,
                        size: 16,
                        color: AppColors.textLight,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        jobPosting.postedTimeAgo,
                        style: AppTextStyles.small.copyWith(
                          color: AppColors.textLight,
                        ),
                      ),
                    ],
                  ),
                  if (jobPosting.deadline != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getDeadlineColor(
                          jobPosting.deadline!,
                        ).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        jobPosting.remainingTime,
                        style: AppTextStyles.small.copyWith(
                          color: _getDeadlineColor(jobPosting.deadline!),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
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
}

class RatingDisplay extends StatelessWidget {
  final double rating;
  final double size;

  const RatingDisplay({super.key, required this.rating, this.size = 16});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor()
              ? Icons.star
              : (index == rating.floor() && rating % 1 != 0)
              ? Icons.star_half
              : Icons.star_border,
          color: AppColors.secondary,
          size: size,
        );
      }),
    );
  }
}

class ReviewWidget extends StatelessWidget {
  final Review review;

  const ReviewWidget({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      elevation: 0,
      color: Colors.grey[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  review.reviewerName,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(review.date, style: AppTextStyles.caption),
              ],
            ),
            const SizedBox(height: 8),
            RatingDisplay(rating: review.rating),
            const SizedBox(height: 8),
            Text(review.comment, style: AppTextStyles.body),
          ],
        ),
      ),
    );
  }
}

class CustomFormField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController controller;
  final bool isRequired;
  final TextInputType keyboardType;
  final int maxLines;
  final int? maxLength;
  final Widget? suffix;
  final String? Function(String?)? validator;

  const CustomFormField({
    super.key,
    required this.label,
    this.hintText,
    required this.controller,
    this.isRequired = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.maxLength,
    this.suffix,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: AppTextStyles.body.copyWith(color: AppColors.text),
            children: [
              TextSpan(text: label),
              if (isRequired)
                TextSpan(text: ' *', style: TextStyle(color: AppColors.error)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffix,
            filled: true,
            fillColor: Colors.grey[100],
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.primary, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.error, width: 1),
            ),
          ),
          keyboardType: keyboardType,
          maxLines: maxLines,
          maxLength: maxLength,
          validator:
              validator ??
              (isRequired
                  ? (value) =>
                      value?.isEmpty ?? true ? 'This field is required' : null
                  : null),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class CustomDropdownField<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  final bool isRequired;
  final String? Function(T?)? validator;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.isRequired = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: AppTextStyles.body.copyWith(color: AppColors.text),
            children: [
              TextSpan(text: label),
              if (isRequired)
                TextSpan(text: ' *', style: TextStyle(color: AppColors.error)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          value: value,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.primary, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.error, width: 1),
            ),
          ),
          items: items,
          onChanged: onChanged,
          validator:
              validator ??
              (isRequired
                  ? (value) => value == null ? 'Please select an option' : null
                  : null),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isLoading;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppColors.primary : Colors.transparent,
          foregroundColor: isPrimary ? Colors.white : AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          elevation: isPrimary ? 2 : 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side:
                isPrimary
                    ? BorderSide.none
                    : BorderSide(color: AppColors.primary),
          ),
          disabledBackgroundColor:
              isPrimary
                  ? AppColors.primary.withValues(alpha: 0.5)
                  : Colors.transparent,
          disabledForegroundColor:
              isPrimary
                  ? Colors.white.withValues(alpha: 0.7)
                  : AppColors.primary.withValues(alpha: 0.5),
        ),
        child:
            isLoading
                ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isPrimary ? Colors.white : AppColors.primary,
                    ),
                  ),
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: 18),
                      const SizedBox(width: 8),
                    ],
                    Text(text),
                  ],
                ),
      ),
    );
  }
}

class ImageCarousel extends StatefulWidget {
  final List<String> images;
  final double height;

  const ImageCarousel({super.key, required this.images, this.height = 200});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return Container(
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Icon(Icons.image, size: 64, color: Colors.grey),
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.images[index],
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey[200],
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(
                            Icons.error,
                            size: 40,
                            color: AppColors.error,
                          ),
                        ),
                      ),
                ),
              );
            },
          ),
        ),
        if (widget.images.length > 1) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.images.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      _currentPage == index
                          ? AppColors.primary
                          : Colors.grey.withValues(alpha: 0.3),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class CategoryChips extends StatelessWidget {
  final List<String> categories;
  final Function(String)? onTap;
  final bool isScrollable;

  const CategoryChips({
    super.key,
    required this.categories,
    this.onTap,
    this.isScrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    if (isScrollable) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: _buildChips()),
      );
    } else {
      return Wrap(spacing: 8, runSpacing: 8, children: _buildChips());
    }
  }

  List<Widget> _buildChips() {
    return categories.map((category) {
      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: InkWell(
          onTap: onTap != null ? () => onTap!(category) : null,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Text(
              category,
              style: AppTextStyles.small.copyWith(color: AppColors.text),
            ),
          ),
        ),
      );
    }).toList();
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const SectionHeader({super.key, required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.heading),
          if (onSeeAll != null)
            TextButton(
              onPressed: onSeeAll,
              child: Text(
                'See All',
                style: AppTextStyles.body.copyWith(color: AppColors.accent),
              ),
            ),
        ],
      ),
    );
  }
}

class EmptyStateWidget extends StatelessWidget {
  final String message;
  final IconData icon;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const EmptyStateWidget({
    super.key,
    required this.message,
    this.icon = Icons.search_off,
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.body.copyWith(color: Colors.grey[600]),
            ),
            if (buttonText != null && onButtonPressed != null) ...[
              const SizedBox(height: 24),
              CustomButton(
                text: buttonText!,
                onPressed: onButtonPressed!,
                isPrimary: true,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class SearchInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final String hintText;
  final FocusNode? focusNode;
  final VoidCallback? onFilterTap;

  const SearchInputField({
    super.key,
    required this.controller,
    required this.onSearch,
    this.hintText = 'Search...',
    this.focusNode,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Icon(Icons.search, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
              onSubmitted: (_) => onSearch(),
            ),
          ),
          if (onFilterTap != null) ...[
            IconButton(
              icon: Icon(Icons.filter_list, color: Colors.grey[600]),
              onPressed: onFilterTap,
            ),
          ],
          const SizedBox(width: 8),
          Container(width: 1, height: 30, color: Colors.grey[300]),
          IconButton(
            icon: Icon(Icons.search, color: AppColors.primary),
            onPressed: onSearch,
          ),
        ],
      ),
    );
  }
}

class UserAvatar extends StatelessWidget {
  final String? userName;
  final String? photoUrl;
  final VoidCallback onProfileTap;
  final VoidCallback onLogoutTap;

  const UserAvatar({
    super.key,
    this.userName,
    this.photoUrl,
    required this.onProfileTap,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      itemBuilder:
          (context) => [
            PopupMenuItem(
              value: 'profile',
              child: Row(
                children: [
                  const Icon(Icons.person, size: 20, color: AppColors.primary),
                  const SizedBox(width: 8),
                  const Text('Profile'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'logout',
              child: Row(
                children: [
                  const Icon(Icons.logout, size: 20, color: AppColors.primary),
                  const SizedBox(width: 8),
                  const Text('Logout'),
                ],
              ),
            ),
          ],
      onSelected: (value) {
        if (value == 'profile') {
          onProfileTap();
        } else if (value == 'logout') {
          onLogoutTap();
        }
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              photoUrl != null
                  ? null
                  : AppColors.primary.withValues(alpha: 0.2),
          image:
              photoUrl != null
                  ? DecorationImage(
                    image: NetworkImage(photoUrl!),
                    fit: BoxFit.cover,
                  )
                  : null,
        ),
        child:
            photoUrl == null
                ? Center(
                  child: const Icon(Icons.menu, color: Colors.white, size: 24),
                )
                : null,
      ),
    );
  }
}
