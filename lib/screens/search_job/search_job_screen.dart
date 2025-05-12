import 'package:buildconnect/core/theme/theme.dart';
import 'package:buildconnect/features/search_profile/providers/search_profile_provider.dart';
import 'package:buildconnect/models/enums/enums.dart'; // Import Enums
import 'package:buildconnect/models/search_profile/search_profile_model.dart'; // Import Search Model
import 'package:buildconnect/models/profile/profile_model.dart'; // Import Profile Model
import 'package:buildconnect/features/search_profile/services/search_profile_service.dart'; // Import Service
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Import Supabase để lấy client

// Widget màn hình Search Profile (sử dụng StatefulWidget)
class SearchJobScreen extends ConsumerStatefulWidget {
  const SearchJobScreen({super.key});

  @override
  _SearchJobScreenState createState() => _SearchJobScreenState();
}

class _SearchJobScreenState extends ConsumerState<SearchJobScreen> {
  late final SearchProfileNotifier searchProfileNotifier;
  final TextEditingController _queryController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  // State cục bộ cho filter UI
  bool _showFilterPanel = false;
  bool _locationFilterExpanded = false;
  bool _profileTypeFilterExpanded = false;
  bool _addLocation = false;
  List<City>? _selectedLocationList = [];
  List<ProfileType>? _selectedProfileTypeList = [];
  City? _selectedCity;
  Future<List<Profile>?>? _searchFuture;
  late final SearchProfileService _searchProfileService;

  @override
  void initState() {
    super.initState();
    searchProfileNotifier = ref.read(searchProfileNotifierProvider.notifier);

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

  // void clearAllFilters() {
  //   setState(() {
  //     searchProfileNotifier.setLocation(null);
  //     searchProfileNotifier.setProfileType(null);
  //   });
  // }

  // Hàm thực hiện tìm kiếm và cập nhật _searchFuture
  void _triggerSearch() {
    // Lấy thông tin từ các controller và state
    final query = _queryController.text.trim();
    searchProfileNotifier.updateQuery(query);
    final profileType = _selectedProfileTypeList;
    searchProfileNotifier.setLocation(_selectedLocationList);
    searchProfileNotifier.setProfileType(_selectedProfileTypeList);
    setState(() {
      _showFilterPanel = false;
      debugPrint('Search with ${profileType.toString()}');
      if (query.isNotEmpty ||
          _selectedLocationList!.isNotEmpty ||
          profileType != null) {
        _searchFuture = searchProfileNotifier.searchProfile();
      } else {
        // Nếu không có query hoặc filter, đặt future về null hoặc Future trả về list rỗng
        _searchFuture = Future.value([]);
      }
    });

    // Đóng bàn phím
    _searchFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final panelWidth = MediaQuery.of(context).size.width * 0.9;
    final current_location_list =
        ref.read(searchProfileNotifierProvider).cityList;
    return Scaffold(
      appBar: AppBar(title: const Text('Search Profiles')),
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
                      onChanged: searchProfileNotifier.updateQuery,
                      controller: _queryController,
                      focusNode: _searchFocusNode,
                      textInputAction: TextInputAction.search,
                      onSubmitted:
                          (_) =>
                              _triggerSearch(), // Gọi triggerSearch khi nhấn Enter
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Search profiles...',
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
                              onPressed:
                                  _triggerSearch, // Gọi triggerSearch khi nhấn icon Search
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

            // --- Filter Panel (Animated Visibility) ---
            Expanded(
              child: FutureBuilder<List<Profile>?>(
                future: _searchFuture, // FutureBuilder sẽ lắng nghe Future này
                builder: (context, snapshot) {
                  // 1. Xử lý trạng thái ConnectionState.waiting (đang load)
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  // 2. Xử lý trạng thái lỗi
                  else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  // 3. Xử lý khi chưa có Future được trigger (trạng thái ban đầu)
                  else if (!snapshot.hasData && _searchFuture == null) {
                    // Hiển thị Lịch sử tìm kiếm hoặc Tìm kiếm phổ biến ở đây
                    // Vì bạn chưa có logic cho lịch sử tìm kiếm ở đây, hiển thị text
                    return const Center(
                      child: Text('Enter keyword or filters to search.'),
                    );
                  }
                  // 4. Xử lý khi có dữ liệu (Future hoàn thành và có data)
                  else if (snapshot.hasData) {
                    final profiles =
                        snapshot.data!; // ! an toàn vì đã check hasData

                    if (profiles.isEmpty) {
                      // Không tìm thấy kết quả
                      return const Center(child: Text('No profiles found.'));
                    }

                    // Hiển thị danh sách kết quả
                    return showProfileListResult(profiles, context);
                  }
                  // 5. Trạng thái không xác định (hiếm gặp)
                  else {
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

  // Widget helper cho phần filter có thể mở rộng (giữ nguyên)
  Widget _buildExpandable({
    required String label,
    required bool expanded,
    required VoidCallback onTap,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
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

  addCity(String city) {
    city = city.nomalize();
    for (final c in City.values) {
      if (c.normalize_label == city) {
        searchProfileNotifier.toggleLocation(c);
        break;
      }
    }
  }
}

extension on String {
  nomalize() {
    return this.toLowerCase().replaceAll(RegExp(r'\s+'), '');
  }
}

Widget showProfileListResult(List<Profile> profiles, BuildContext context) {
  if (profiles.isEmpty) {
    return const Center(child: Text('Không có kết quả nào.'));
  }

  return ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: profiles.length,
    itemBuilder: (context, index) {
      final profile = profiles[index];

      return Card(
        elevation: 4,
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar/Icon
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.blueAccent,
                child: Text(
                  profile.displayName.isNotEmpty
                      ? profile.displayName[0].toUpperCase()
                      : '?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Thông tin chi tiết
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.displayName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Loại hồ sơ: ${profile.profileType.name}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      'Thành phố chính: ${profile.mainCity.label}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      'Kinh nghiệm: ${profile.yearsOfExperience} năm',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              // Nút hoặc icon hành động
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  // TODO: Navigate to Profile detail page
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

// Xóa extension String.nomalize() nếu không còn dùng ở màn hình này
/*
extension on String {
  nomalize() {
    return this.toLowerCase().replaceAll(RegExp(r'\s+'), '');
  }
}
*/
