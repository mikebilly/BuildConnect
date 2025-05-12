import 'package:buildconnect/features/search_post/providers/search_post_provider.dart';
import 'package:buildconnect/models/enums/enums.dart'; // Import Enums (cần JobPostingType)
import 'package:buildconnect/models/post/post_model.dart'; // Import PostModel
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
  final TextEditingController _queryController = TextEditingController();
  final TextEditingController _locationController =
      TextEditingController(); // Cho filter location
  final FocusNode _searchFocusNode = FocusNode();

  // State cục bộ cho filter UI
  bool _showFilterPanel = false;
  bool _locationFilterExpanded = false;
  bool _jobTypeFilterExpanded = false;

  // State cục bộ lưu trữ giá trị filter được chọn (sẽ được đồng bộ với Notifier)
  // List<City>? _selectedLocationList = []; // Nếu location là list City
  List<JobPostingType> _selectedJobTypeList = [];

  @override
  void initState() {
    super.initState();

    // Đồng bộ TextField với keyword từ provider khi màn hình load
    final initialSearchModel =
        ref.read(searchPostNotifierProvider).value?.currentSearchModel;
    if (initialSearchModel != null) {
      _queryController.text = initialSearchModel.query;
      _locationController.text =
          initialSearchModel.location; // Đồng bộ location
      _selectedJobTypeList = List.from(
        initialSearchModel.jobType,
      ); // Đồng bộ jobType
    }

    // Lắng nghe thay đổi text và cập nhật query vào provider
    _queryController.addListener(_onQueryChanged);

    // Tự động focus
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _queryController.removeListener(_onQueryChanged);
    _queryController.dispose();
    _locationController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onQueryChanged() {
    // Cập nhật query vào provider
    ref
        .read(searchPostNotifierProvider.notifier)
        .updateQuery(_queryController.text);
    // TODO: Debounce và tự động search nếu cần
  }

  // Hàm thực hiện tìm kiếm (gọi Notifier)
  void _triggerSearch() {
    // Lấy notifier
    final notifier = ref.read(searchPostNotifierProvider.notifier);

    // Cập nhật các filter vào Notifier trước khi search
    notifier.updateLocation(_locationController.text.trim());
    // Notifier đã quản lý _selectedJobTypeList thông qua toggleJobType

    // Gọi phương thức thực hiện search trên Notifier
    notifier.performSearch();

    // Đóng bàn phím và filter panel (tùy chọn)
    _searchFocusNode.unfocus();
    setState(() {
      _showFilterPanel = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final panelWidth = MediaQuery.of(context).size.width * 0.9;

    // Watch các phần state cần thiết từ searchPostNotifierProvider
    final searchStateAsync = ref.watch(searchPostNotifierProvider);
    final currentSearchModel = searchStateAsync.value?.currentSearchModel;
    final selectedJobTypes =
        currentSearchModel?.jobType ??
        []; // Lấy từ SearchPostModel của Notifier

    final AsyncValue<List<PostModel>> searchResultsAsync =
        searchStateAsync.value?.searchResults ?? const AsyncValue.data([]);
    final bool isSearching =
        searchStateAsync.isLoading && searchStateAsync.value == null;
    final bool isPerformingSearch = searchResultsAsync.isLoading;

    return Scaffold(
      // appBar: AppBar(title: const Text('Search Posts')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            // --- Search Row ---
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _queryController,
                      focusNode: _searchFocusNode,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (_) => _triggerSearch(),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Search posts (e.g., "Tuyển thợ hồ")...',
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              tooltip: 'Toggle Filters',
                              icon: Icon(
                                Icons.filter_list,
                                color:
                                    _showFilterPanel
                                        ? Theme.of(context).primaryColor
                                        : null,
                              ),
                              onPressed:
                                  () => setState(
                                    () => _showFilterPanel = !_showFilterPanel,
                                  ),
                            ),
                            IconButton(
                              tooltip: 'Perform Search',
                              icon: const Icon(Icons.search),
                              onPressed: _triggerSearch,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // --- Filter Panel ---
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
                      maxHeight: MediaQuery.of(context).size.height * 0.4,
                    ), // Giảm chiều cao panel
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      shrinkWrap: true,
                      children: [
                        // --- Location Filter ---
                        _buildExpandable(
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
                            padding: const EdgeInsets.only(top: 8),
                            child: TextField(
                              // Đơn giản hóa thành TextField cho location
                              controller: _locationController,
                              decoration: InputDecoration(
                                hintText: 'Enter location (e.g., Hà Nội)...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                              ),
                              // onChanged: (value) {
                              //   ref.read(searchPostNotifierProvider.notifier).updateLocation(value);
                              // }, // Cập nhật trực tiếp vào provider nếu muốn
                            ),
                          ),
                        ),
                        const Divider(height: 24),

                        // --- Job Posting Type Filter ---
                        _buildExpandable(
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
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children:
                                  JobPostingType.values.map((type) {
                                    // Sử dụng JobPostingType enum
                                    final isSelected = selectedJobTypes
                                        .contains(type);
                                    return ChoiceChip(
                                      label: Text(
                                        type.label,
                                      ), // Sử dụng .label từ enum nếu có
                                      selected: isSelected,
                                      onSelected: (selected) {
                                        ref
                                            .read(
                                              searchPostNotifierProvider
                                                  .notifier,
                                            )
                                            .toggleJobType(type);
                                        // setState không cần thiết ở đây vì UI sẽ rebuild khi provider thay đổi
                                      },
                                      selectedColor: Theme.of(
                                        context,
                                      ).primaryColor.withOpacity(0.1),
                                      checkmarkColor:
                                          Theme.of(context).primaryColor,
                                      labelStyle: TextStyle(
                                        color:
                                            isSelected
                                                ? Theme.of(context).primaryColor
                                                : Colors.black87,
                                      ),
                                      backgroundColor: Colors.grey.shade100,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(
                                          color:
                                              isSelected
                                                  ? Theme.of(
                                                    context,
                                                  ).primaryColor
                                                  : Colors.grey.shade300,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ),
                        ),
                        const Divider(height: 24),
                        ElevatedButton(
                          onPressed:
                              _triggerSearch, // Áp dụng filters và tìm kiếm
                          child: const Text('Apply Filters & Search'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 40),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // --- Search Results ---
            Expanded(
              child:
                  (isSearching ||
                          isPerformingSearch) // Hiển thị loading nếu đang search hoặc provider đang load ban đầu
                      ? const Center(child: CircularProgressIndicator())
                      : searchResultsAsync.when(
                        loading:
                            () =>
                                const SizedBox.shrink(), // Đã xử lý bằng isPerformingSearch
                        error:
                            (error, st) => Center(
                              child: Text('Error: ${error.toString()}'),
                            ),
                        data: (posts) {
                          if (posts.isEmpty &&
                              _queryController.text.isNotEmpty) {
                            return const Center(
                              child: Text(
                                'No posts found matching your criteria.',
                              ),
                            );
                          }
                          if (posts.isEmpty &&
                              _queryController.text.isEmpty &&
                              (currentSearchModel?.location.isNotEmpty ==
                                      true ||
                                  currentSearchModel?.jobType.isNotEmpty ==
                                      true)) {
                            return const Center(
                              child: Text(
                                'No posts found with the selected filters.',
                              ),
                            );
                          }
                          if (posts.isEmpty &&
                              _queryController.text.isEmpty &&
                              currentSearchModel?.location.isEmpty == true &&
                              currentSearchModel?.jobType.isEmpty == true) {
                            // Trạng thái ban đầu hoặc khi xóa hết query và filter
                            // TODO: Hiển thị Lịch sử tìm kiếm post hoặc Tìm kiếm phổ biến post
                            return const Center(
                              child: Text(
                                'Enter keyword or filters to search posts.',
                              ),
                            );
                          }
                          // Hiển thị danh sách kết quả
                          return _buildPostListResult(posts, context);
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget helper cho phần filter có thể mở rộng
  Widget _buildExpandable({
    required String label,
    required int labelLevel, // Giữ lại nếu bạn dùng
    required bool expanded,
    required VoidCallback onTap,
    required Widget child,
  }) {
    // ... (Giữ nguyên code _buildExpandable của bạn) ...
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
                  expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
          child: Visibility(visible: expanded, child: child),
        ),
      ],
    );
  }

  // Tách widget hiển thị danh sách kết quả Post
  Widget _buildPostListResult(List<PostModel> posts, BuildContext context) {
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
                  color: Colors.grey[50],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _getProfileTypeIcon(ProfileType.constructionTeam),
                      color: Colors.blue,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _getProfileTypeLabel(ProfileType.constructionTeam),
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Posted 2 hours ago', // Placeholder, replace with actual time
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
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
                          JobPostingType.hiring,
                        ).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Full-time', // Placeholder, replace with actual job type
                        style: TextStyle(
                          color: _getJobTypeColor(JobPostingType.hiring),
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
                    Row(
                      children: [
                        const Icon(Icons.person, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          'Posted by ${post.authorId}', // Replace with actual author info
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(width: 16),
                        const Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            post.location, // Display job location
                            style: TextStyle(color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Description
                    Text(
                      post.description ??
                          'No description provided', // Display job description
                      style: TextStyle(color: Colors.black54),
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
                          ).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Deadline in 3 days', // Placeholder, replace with actual deadline
                          style: TextStyle(
                            color: _getDeadlineColor(post.deadline!),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    TextButton.icon(
                      onPressed: () {
                        print('post id in search_post_screen is: ${post.id}');
                        context.push('/job-posting/view/${post.id}');
                      },

                      icon: const Icon(Icons.visibility, size: 16),
                      label: const Text('View Details'),
                      style: TextButton.styleFrom(foregroundColor: Colors.blue),
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
        .replaceAll(RegExp(r'[ỳýỵỷỹ]'), 'y')
        .replaceAll(RegExp(r'\s+'), ''); // Bỏ hết khoảng trắng
  }
}
