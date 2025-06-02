import 'package:buildconnect/core/theme/theme.dart';
import 'package:buildconnect/features/search_post/providers/search_post_provider.dart';
import 'package:buildconnect/models/enums/enums.dart'; // Import Enums (cần JobPostingType)
import 'package:buildconnect/models/post/post_model.dart'; // Import PostModel
import 'package:buildconnect/shared/widgets/search_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// import 'package:buildconnect/core/theme/theme.dart'; // Import theme nếu cần

// Widget màn hình Search Post
class SearchPostScreen extends ConsumerStatefulWidget {
  const SearchPostScreen({super.key});

  @override
  ConsumerState<SearchPostScreen> createState() => _SearchPostScreenState();
}

class _SearchPostScreenState extends ConsumerState<SearchPostScreen> {
  late final SearchPostNotifier searchPostNotifier;
  final TextEditingController _queryController = TextEditingController();
  final TextEditingController _locationController =
      TextEditingController(); // Cho filter location
  final FocusNode _searchFocusNode = FocusNode();
  Future<List<PostModel>?>? _searchPost;
  // State cục bộ cho filter UI
  bool _showFilterPanel = false;
  bool _locationFilterExpanded = false;
  bool _profileTypeFilterExpanded = false;
  bool _jobTypeFilterExpanded = false;
  bool _domainFilterExpanded = false;
  List<City>? _selectedLocationList = [];
  City? _selectedCity;
  List<ProfileType>? _selectedProfileTypeList = [];

  // State cục bộ lưu trữ giá trị filter được chọn (sẽ được đồng bộ với Notifier)
  // List<City>? _selectedLocationList = []; // Nếu location là list City
  List<JobPostingType> _selectedJobTypeList = [];

  @override
  void initState() {
    super.initState();

    // Đồng bộ TextField với keyword từ provider khi màn hình load
    searchPostNotifier = ref.read(searchPostNotifierProvider.notifier);
    // Tự động focus
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _queryController.dispose();
    _locationController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _triggerSearch() {
    final query = _queryController.text.trim();
    searchPostNotifier.updateQuery(query);
    // final profileType = _selectedProfileTypeList;
    setState(() {
      _showFilterPanel = false;
      _searchPost = searchPostNotifier.searchPost();
      if (query.isNotEmpty || _selectedLocationList!.isNotEmpty) {
        _searchPost = searchPostNotifier.searchPost();
      } else {
        // Nếu không có query hoặc filter, đặt future về null hoặc Future trả về list rỗng
        _searchPost = Future.value([]);
      }
    });
    _searchFocusNode.unfocus();
    setState(() {
      _showFilterPanel = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final panelWidth = MediaQuery.of(context).size.width * 0.9;
    List<JobPostingType> selectedJobPostingType =
        ref.read(searchPostNotifierProvider).jobType;
    final current_location_list = ref.read(searchPostNotifierProvider).location;
    List<ProfileType> profileTypeChoosingList =
        ref.watch(searchPostNotifierProvider).profileType;
    return Scaffold(
      // appBar: AppBar(title: const Text('Search Posts')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            buildSearchBar(
              controller: _queryController,
              focusNode: _searchFocusNode,
              onQueryChanged: searchPostNotifier.updateQuery,
              onSearchPressed: _triggerSearch,
              onToggleFilter:
                  () => setState(() => _showFilterPanel = !_showFilterPanel),
              showFilterHighlight: _showFilterPanel,
              hintText: 'Search profiles…',
            ),
            const SizedBox(height: 12),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Visibility(
                visible: _showFilterPanel,
                child: Center(
                  child: Container(
                    width: panelWidth,
                    margin: const EdgeInsets.only(bottom: 12.0),
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.35,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      border: Border.all(color: AppColors.boxBackground),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.boxShadow,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Scrollable filter content
                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.all(16),
                            children: [
                              // --- Location Filter ---
                              buildExpandable(
                                labelLevel: 1,
                                label: 'Location',
                                expanded: _locationFilterExpanded,
                                onTap:
                                    () => setState(
                                      () =>
                                          _locationFilterExpanded =
                                              !_locationFilterExpanded,
                                    ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    0,
                                    8,
                                    0,
                                    0,
                                  ),
                                  child: Column(
                                    children: [
                                      if (current_location_list!.isNotEmpty)
                                        Wrap(
                                          spacing: 8,
                                          runSpacing: 5,
                                          children:
                                              current_location_list.map((city) {
                                                return Chip(
                                                  label: Text(city.label),
                                                  deleteIconColor:
                                                      AppColors.delete,
                                                  onDeleted: () {
                                                    setState(() {
                                                      current_location_list
                                                          .remove(city);
                                                      searchPostNotifier
                                                          .setLocation(
                                                            current_location_list,
                                                          );
                                                    });
                                                  },
                                                );
                                              }).toList(),
                                        ),

                                      const SizedBox(height: 8),

                                      Row(
                                        children: [
                                          ElevatedButton(
                                            onPressed:
                                                () => setState(() {
                                                  searchPostNotifier
                                                      .toggleLocation(
                                                        _selectedCity!,
                                                      );
                                                  _selectedCity = null;
                                                }),
                                            child: const Icon(Icons.add),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              minimumSize: const Size(40, 40),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child:
                                                buildDrowndownButtonFormFieldSearch(
                                                  values: City.values,
                                                  onChanged: (v) {
                                                    setState(() {
                                                      _selectedCity = v;
                                                    });
                                                  },
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const Divider(height: 24),

                              // --- Profile Type Filter ---
                              buildExpandable(
                                labelLevel: 1,
                                label: 'Profile Type',
                                expanded: _profileTypeFilterExpanded,
                                onTap:
                                    () => setState(
                                      () =>
                                          _profileTypeFilterExpanded =
                                              !_profileTypeFilterExpanded,
                                    ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: buildFilterSearchChip(
                                    // title: '',
                                    values: ProfileType.values,
                                    selectedValues:
                                        searchPostNotifier
                                            .getProfileTypeChoosing(),
                                    onSelected: (v, selected) {
                                      setState(() {
                                        searchPostNotifier.toggleProfileType(v);
                                      });
                                    },
                                  ),
                                ),
                              ),

                              const Divider(height: 24),
                              buildExpandable(
                                labelLevel: 1,
                                label: 'Job Posting Type',
                                expanded: _jobTypeFilterExpanded,
                                onTap:
                                    () => setState(
                                      () =>
                                          _jobTypeFilterExpanded =
                                              !_jobTypeFilterExpanded,
                                    ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: buildFilterSearchChip(
                                    // title: '',
                                    values: JobPostingType.values,
                                    selectedValues:
                                        searchPostNotifier
                                            .getJobPostingTypeChoosing(),
                                    onSelected: (v, selected) {
                                      setState(() {
                                        searchPostNotifier.toggleJobPostingType(
                                          v,
                                        );
                                      });
                                    },
                                  ),
                                ),
                              ),
                              const Divider(height: 24),
                              buildExpandable(
                                labelLevel: 1,
                                label: 'Domain',
                                expanded: _domainFilterExpanded,
                                onTap:
                                    () => setState(
                                      () =>
                                          _domainFilterExpanded =
                                              !_domainFilterExpanded,
                                    ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: buildFilterSearchChip(
                                    // title: '',
                                    values: Domain.values,
                                    selectedValues:
                                        searchPostNotifier.getDomainChoosing(),
                                    onSelected: (v, selected) {
                                      setState(() {
                                        searchPostNotifier.toggleDomain(v);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Fixed bottom buttons
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      ref
                                          .read(
                                            searchPostNotifierProvider.notifier,
                                          )
                                          .clearAllFilters();
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.delete,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                  ),
                                  child: const Text('Clear All'),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: _triggerSearch,
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                  ),
                                  child: const Text('Apply & Search'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // --- Filter Panel ---

            // --- Search Results ---
            Expanded(
              child: FutureBuilder<List<PostModel>?>(
                future: _searchPost,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData && _searchPost == null) {
                    return const Center(
                      child: Text('Enter keyword or filters to search.'),
                    );
                  } else if (snapshot.hasData) {
                    return _buildPostListResult(snapshot.data!, context);
                  } else {
                    return const Center(
                      child: Text('Enter keyword or filters to search.'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget helper cho phần filter có thể mở rộng
  // Tách widget hiển thị danh sách kết quả Post
  Widget _buildPostListResult(List<PostModel> posts, BuildContext context) {
    if (posts.isEmpty) {
      return const Center(child: Text('Không có kết quả nào.'));
    }
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
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
                      'Posted ${-post.createdAt!.difference(DateTime.now()).inHours} hours ago',
                      style: TextStyle(color: AppColors.grey, fontSize: 12),
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
                                  style: TextStyle(color: AppColors.grey),
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
  }
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
    default:
      return Icons.person;
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
    default:
      return 'Unknown';
  }
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

// Extension để chuẩn hóa chuỗi (giữ lại nếu cần cho việc so sánh location)
extension StringNormalizePost on String {
  String nomalize() {
    // Một cách đơn giản, bạn có thể cần thư viện phức tạp hơn cho tiếng Việt
    return trim()
        .toLowerCase()
        .replaceAll('đ', 'd')
        .replaceAll(RegExp(r'[àáạảãâầấậẩẫăằắặẳẵ]'), 'a')
        .replaceAll(RegExp(r'[èéẹẻẽêềếệểễ]'), 'e')
        .replaceAll(RegExp(r'[ìíịỉĩ]'), 'i')
        .replaceAll(RegExp(r'[òóọỏõôồốộổỗơờớợởỡ]'), 'o')
        .replaceAll(RegExp(r'[ùúụủũưừứựửữ]'), 'u')
        .replaceAll(RegExp(r'[ỳýỵỷỹ]'), 'y'); // Bỏ hết khoảng trắng
  }
}
