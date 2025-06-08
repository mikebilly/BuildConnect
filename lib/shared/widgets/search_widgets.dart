import 'package:buildconnect/core/theme/theme.dart';
import 'package:buildconnect/models/profile/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget buildSearchBar({
  required TextEditingController controller,
  required FocusNode focusNode,
  required ValueChanged<String> onQueryChanged,
  required VoidCallback onSearchPressed,
  required VoidCallback onToggleFilter,
  bool showFilterHighlight = false,
  String hintText = 'Search…',
}) {
  return SizedBox(
    height: 40,
    child: Row(
      children: [
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: controller,
            // focusNode: focusNode,
            onChanged: onQueryChanged,
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => onSearchPressed(),
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              isDense: true,
              fillColor: Colors.grey[50],
              prefixIcon: const Icon(
                Icons.search,
                size: 20,
                color: AppColors.primary,
              ),
              hintText: hintText,

              // content is center aligned
              contentPadding: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 0,
              ),
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(4),
              //   borderSide: BorderSide(
              //     color: Colors.green[200]!
              //   ),
              // ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color:
                      AppColors.primary, // hoặc Theme.of(context).primaryColor
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.grey.shade50),
              ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    tooltip: 'Toggle Filters',
                    icon: Icon(
                      Icons.filter_list,
                      color:
                          showFilterHighlight
                              ? AppColors
                                  .primary // hoặc Theme.of(context).primaryColor
                              : null,
                    ),
                    onPressed: onToggleFilter,
                  ),
                  // IconButton(
                  //   tooltip: 'Perform Search',
                  //   icon: const Icon(Icons.search),
                  //   onPressed: onSearchPressed,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildExpandable({
  required String label,
  required bool expanded,
  required VoidCallback onTap,
  required Widget child,
  required int labelLevel,
}) {
  TextStyle getLabelStyle(int labelLevel) {
    switch (labelLevel) {
      case 1:
        return const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
      case 2:
        return const TextStyle(fontSize: 14, fontWeight: FontWeight.w700);
      default:
        return const TextStyle(fontSize: 12, fontWeight: FontWeight.normal);
    }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: getLabelStyle(labelLevel)),
              Icon(
                expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: Colors.grey.shade600,
              ),
            ],
          ),
        ),
      ),

      // Animated expansion
      AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        child:
            expanded
                ? ClipRect(
                  child: SizeTransition(
                    sizeFactor: const AlwaysStoppedAnimation(1.0),
                    axis: Axis.vertical,
                    child: child,
                  ),
                )
                : const SizedBox.shrink(),
      ),
    ],
  );
}

Widget buildProfileListResult({
  required List<Profile> profiles,
  required BuildContext context,
  required bool isLoggedIn,
}) {
  if (profiles.isEmpty) {
    return const Center(child: Text('No results found.'));
  }

  return ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: profiles.length,
    itemBuilder: (context, index) {
      final profile = profiles[index];
      return _buildProfileCard(
        context: context,
        profile: profile,
        isLoggedIn: isLoggedIn,
      );
    },
  );
}

Widget _buildProfileCard({
  required BuildContext context,
  required Profile profile,
  required bool isLoggedIn,
}) {
  return Card(
    elevation: 4,
    margin: const EdgeInsets.only(bottom: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          CircleAvatar(
            radius: 28,
            backgroundColor: AppTheme.lightTheme.primaryColor,
            child: Text(
              profile.displayName.isNotEmpty
                  ? profile.displayName[0].toUpperCase()
                  : '?',
              style: CardSearchStyle.avatar,
            ),
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(profile.displayName, style: CardSearchStyle.title),
                const SizedBox(height: 6),
                Text(
                  'Profile Type: ${profile.profileType.name}',
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  'Main City: ${profile.mainCity.label}',
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  'Experience: ${profile.yearsOfExperience} years',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          // Buttons
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  context.push('/profile/view/${profile.userId}');
                },
              ),
              IconButton(
                icon: const Icon(Icons.message),
                onPressed: () {
                  if (isLoggedIn) {
                    context.push('/message/detail_view/${profile.userId}');
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Notification'),
                          content: const Text(
                            'You need to login to send messages.',
                          ),
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
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Text bodyCardText({required String text}) {
  return Text(text, style: CardSearchStyle.body);
}

Widget buildFilterSearchChip<T>({
  double spacing = 5.0,
  double runSpacing = 3.0,
  required List<T> values,
  required Set<T> selectedValues,
  required void Function(T value, bool selected) onSelected,
  String? title,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Wrap(
        spacing: spacing,
        runSpacing: runSpacing,
        children:
            values.map((v) {
              final bool isSelected = selectedValues.contains(v);
              return FilterChip(
                label: Text((v as dynamic).label),
                selected: isSelected,
                onSelected: (selected) {
                  onSelected(v, selected);
                },
              );
            }).toList(),
      ),
    ],
  );
}

Widget buildDrowndownButtonFormFieldSearch<T>({
  required List<T> values,
  required void Function(T?) onChanged,
  String? title,
  String? labelText,
  double gap = 0,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: gap),
      DropdownButtonFormField<T>(
        value: null,
        decoration: InputDecoration(labelText: labelText),
        items:
            values.map((v) {
              return DropdownMenuItem<T>(
                value: v,
                child: Text((v as dynamic).label),
              );
            }).toList(),
        onChanged: onChanged,
      ),
    ],
  );
}
