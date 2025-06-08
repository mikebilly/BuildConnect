import 'package:buildconnect/core/theme/theme.dart';
import 'package:buildconnect/features/search_profile/providers/search_profile_provider.dart';
import 'package:buildconnect/models/enums/enums.dart'; // Import Enums
import 'package:buildconnect/models/search_profile/search_profile_model.dart'; // Import Search Model
import 'package:buildconnect/models/profile/profile_model.dart'; // Import Profile Model
import 'package:buildconnect/features/search_profile/services/search_profile_service.dart'; // Import Service
import 'package:buildconnect/shared/widgets/form_widgets.dart';
import 'package:buildconnect/shared/widgets/search_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Import Supabase to get client

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
  bool _showSuggestionPanel = true;
  bool _locationFilterExpanded = false;
  bool _profileTypeFilterExpanded = false;
  bool _professionalFilterWithEachProfileTypeExpanded = false;
  List<City>? _selectedLocationList = [];
  List<ProfileType>? _selectedProfileTypeList = [];
  City? _selectedCity;
  Future<List<Profile>?>? _searchFuture;
  late final SearchPostService _searchProfileService;
  Map<ProfileType, bool> openFilterByProfileType = {
    ProfileType.architect: false,
    ProfileType.constructionTeam: false,
    ProfileType.contractor: false,
    ProfileType.supplier: false,
  };
  bool openDesignStyleFilter = false;
  bool openServiceTypeFilterOfConstructionTeam = false;
  bool openServiceTypeFilterOfContractor = false;
  bool openMaterialCategoryFilter = false;

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
    bool isLoggedIn =
        ref.read(searchProfileNotifierProvider.notifier).isLoggedIn();
    String profileTypeName =
        ref.read(searchProfileNotifierProvider.notifier).profileTypeName();
    List<ProfileType> profileTypeChoosingList =
        ref.watch(searchProfileNotifierProvider).profileType;
    ArchitectFilterModel? currentArchitectFilter =
        ref.watch(searchProfileNotifierProvider).architectFilterModel;
    ContractorFilterModel? currentContractorFilter =
        ref.watch(searchProfileNotifierProvider).contractorFilterModel;
    ConstructionTeamFilterModel? currentConstructionTeamFilter =
        ref.watch(searchProfileNotifierProvider).constructionTeamFilterModel;
    SupplierFilterModel? currentSupplierFilter =
        ref.watch(searchProfileNotifierProvider).supplierFilterModel;
    Map<ProfileType, bool> isSelectedProfileType =
        ref
            .watch(searchProfileNotifierProvider.notifier)
            .isSelectedProfileType();
    return Scaffold(
      // appBar: AppBar(title: const Text('Search Profiles')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            buildSearchBar(
              controller: _queryController,
              focusNode: _searchFocusNode,
              onQueryChanged: searchProfileNotifier.updateQuery,
              onSearchPressed: _triggerSearch,
              onToggleFilter:
                  () => setState(() => _showFilterPanel = !_showFilterPanel),
              showFilterHighlight: _showFilterPanel,
              hintText: 'Search profiles…',
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
                                                      searchProfileNotifier
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
                                                  searchProfileNotifier
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
                                        searchProfileNotifier
                                            .getProfileTypeChoosing(),
                                    onSelected: (v, selected) {
                                      setState(() {
                                        searchProfileNotifier.toggleProfileType(
                                          v,
                                        );
                                      });
                                    },
                                  ),
                                ),
                              ),

                              const Divider(height: 24),

                              // --- Filters by selected profile types ---
                              if (profileTypeChoosingList.isNotEmpty)
                                ...profileTypeChoosingList.map((element) {
                                  return buildExpandable(
                                    labelLevel: 1,
                                    label: element.label,
                                    expanded: openFilterByProfileType[element]!,
                                    onTap:
                                        () => setState(
                                          () =>
                                              openFilterByProfileType[element] =
                                                  !openFilterByProfileType[element]!,
                                        ),
                                    child: buildFilterByProfileType(
                                      element,
                                      currentArchitectFilter,
                                      currentContractorFilter,
                                      currentConstructionTeamFilter,
                                      currentSupplierFilter,
                                    ),
                                  );
                                }).toList(),
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
                                            searchProfileNotifierProvider
                                                .notifier,
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

            // --- Search Results (Using FutureBuilder) ---
            Expanded(
              child: FutureBuilder<List<Profile>?>(
                future: _searchFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData && _searchFuture == null) {
                    return const Center(
                      child: Text('Enter keyword or filters to search.'),
                    );
                  } else if (snapshot.hasData) {
                    return buildProfileListResult(
                      profiles: snapshot.data!,
                      context: context,
                      isLoggedIn: isLoggedIn,
                    );
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

  Widget buildFilterByProfileType(
    ProfileType element,
    ArchitectFilterModel? currentArchitectFilter,
    ContractorFilterModel? currentContractorFilter,
    ConstructionTeamFilterModel? currentConstructionTeamFilter,
    SupplierFilterModel? currentSupplierFilter,
  ) {
    Widget filterWidget;

    switch (element) {
      case ProfileType.architect:
        filterWidget = buildExpandable(
          labelLevel: 2,
          label: '  Design Style',
          expanded: openDesignStyleFilter,
          onTap: () {
            setState(() {
              openDesignStyleFilter = !openDesignStyleFilter;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: buildFilterSearchChip(
              values: DesignStyle.values,
              selectedValues: searchProfileNotifier.getDesignStyleChoosing(),
              onSelected: (v, selected) {
                setState(() {
                  searchProfileNotifier.toggleDesignStyle(v);
                });
              },
            ),
          ),
        );

        break;
      case ProfileType.constructionTeam:
        filterWidget = buildExpandable(
          labelLevel: 2,
          label: '  Service Type',
          expanded: openServiceTypeFilterOfConstructionTeam,
          onTap: () {
            setState(() {
              openServiceTypeFilterOfConstructionTeam =
                  !openServiceTypeFilterOfConstructionTeam;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: buildFilterSearchChip(
              values: ServiceType.values,
              selectedValues:
                  searchProfileNotifier
                      .getServiceTypeConstructionTeamChoosing(),
              onSelected: (v, selected) {
                setState(() {
                  searchProfileNotifier.toggleServiceTypeOfConstructionTeam(v);
                });
              },
            ),
          ),
        );
        break;
      case ProfileType.contractor:
        filterWidget = buildExpandable(
          labelLevel: 2,
          label: '  Service Type',
          expanded: openServiceTypeFilterOfContractor,
          onTap: () {
            setState(() {
              openServiceTypeFilterOfContractor =
                  !openServiceTypeFilterOfContractor;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: buildFilterSearchChip(
              values: ServiceType.values,
              selectedValues:
                  searchProfileNotifier.getServiceTypeContractorChoosing(),
              onSelected: (v, selected) {
                setState(() {
                  searchProfileNotifier.toggleServiceTypeOfContractor(v);
                });
              },
            ),
          ),
        );
        break;
      case ProfileType.supplier:
        filterWidget = buildExpandable(
          labelLevel: 2,
          label: '  Material Category',
          expanded: openMaterialCategoryFilter!,
          onTap: () {
            setState(() {
              openMaterialCategoryFilter = !openMaterialCategoryFilter;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: buildFilterSearchChip(
              values: MaterialCategory.values,
              selectedValues:
                  searchProfileNotifier.getMaterialCategoryChoosing(),
              onSelected: (v, selected) {
                setState(() {
                  searchProfileNotifier.toggleMaterialCategory(v);
                });
              },
            ),
          ),
        );
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Wrap(spacing: 8, runSpacing: 8, children: [filterWidget]),
    );
  }
}
