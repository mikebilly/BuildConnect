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
class SearchProfileScreen extends ConsumerStatefulWidget {
  const SearchProfileScreen({super.key});

  @override
  _SearchProfileScreenState createState() => _SearchProfileScreenState();
}

class _SearchProfileScreenState extends ConsumerState<SearchProfileScreen> {
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
                      maxHeight: MediaQuery.of(context).size.height * 0.5,
                    ),
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
                            child: Column(
                              children: [
                                // all citys are selected
                                if (current_location_list!.isNotEmpty)
                                  Row(
                                    spacing: 10,
                                    children:
                                        current_location_list
                                            .map(
                                              (city) => Chip(
                                                label: Text(city.label),
                                                onDeleted: () {
                                                  setState(() {
                                                    current_location_list
                                                        .remove(city);
                                                    searchProfileNotifier
                                                        .setLocation(
                                                          current_location_list,
                                                        );
                                                  });
                                                },
                                              ),
                                            )
                                            .toList(),
                                  ),
                                Row(
                                  spacing: 10,
                                  children: [
                                    // add button and if click then set _addLocation to true
                                    ElevatedButton(
                                      onPressed:
                                          () => setState(
                                            () {
                                              _addLocation = !_addLocation;
                                              searchProfileNotifier
                                                  .toggleLocation(
                                                    _selectedCity!,
                                                  );
                                              _selectedCity = null;
                                            },
                                          ), // Gọi triggerSearch để áp dụng và tìm kiếm
                                      child: const Icon(Icons.add),
                                      style: ElevatedButton.styleFrom(
                                        // disable border cicular
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        textStyle: TextStyle(fontSize: 12),
                                        minimumSize: const Size(40, 40),
                                      ),
                                    ),

                                    Expanded(
                                      child: DropdownButtonFormField<City>(
                                        value:
                                            _selectedCity, // ② show the currently selected city
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          hintText: 'Select city…',
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 10,
                                              ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                        ),

                                        // ③ build the list of options from your enum
                                        items:
                                            City.values.map((city) {
                                              return DropdownMenuItem(
                                                value: city,
                                                child: Text(
                                                  city.label,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              );
                                            }).toList(),

                                        // ④ when the user picks a city, update our local state
                                        onChanged: (city) {
                                          setState(() {
                                            _selectedCity = city;
                                            _addLocation =
                                                true; // optionally open the dropdown UI
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
                        _buildExpandable(
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
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children:
                                  ProfileType.values.map((type) {
                                    final isSelected = searchProfileNotifier
                                        .isSelectedProfileType(type);
                                    return ChoiceChip(
                                      label: Text(type.label),
                                      selected: isSelected,
                                      onSelected: (selected) {
                                        Icon(
                                          Icons.check,
                                          size: 16,
                                          color:
                                              AppTheme.lightTheme.primaryColor,
                                        );
                                        searchProfileNotifier.toggleProfileType(
                                          type,
                                        );
                                        setState(() {});
                                      },
                                      selectedColor: Color.fromARGB(
                                        255,
                                        207,
                                        235,
                                        210,
                                      ),

                                      checkmarkColor:
                                          AppTheme.lightTheme.primaryColor,
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

                        // TODO: Thêm _buildExpandable cho Experience Level
                        const Divider(height: 24),
                        // Nút áp dụng filters và tìm kiếm
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(
                                      searchProfileNotifierProvider.notifier,
                                    )
                                    .clearAllFilters();
                                setState(() {});
                              },
                              child: const Text('Clear All Filters'),
                              style: ElevatedButton.styleFrom(
                                textStyle: TextStyle(fontSize: 12),
                                backgroundColor: Colors.red[500],
                                minimumSize: const Size(50, 40),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: _triggerSearch,
                              child: const Text('Apply Filters & Search'),
                              style: ElevatedButton.styleFrom(
                                textStyle: TextStyle(fontSize: 12),
                                minimumSize: const Size(50, 40),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // --- Search Results (Using FutureBuilder) ---
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
