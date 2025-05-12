import 'package:buildconnect/features/search_post/providers/search_post_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../models/post/post_model.dart';
import '../../../models/search_post/search_post_model.dart';
import '../../../models/enums/enums.dart';

part 'search_post_provider.g.dart';

class SearchPostStateInternal {
  final SearchPostModel currentSearchModel;
  final AsyncValue<List<PostModel>> searchResults;

  SearchPostStateInternal({
    required this.currentSearchModel,
    required this.searchResults,
  });

  SearchPostStateInternal copyWith({
    SearchPostModel? currentSearchModel,
    AsyncValue<List<PostModel>>? searchResults,
  }) {
    return SearchPostStateInternal(
      currentSearchModel: currentSearchModel ?? this.currentSearchModel,
      searchResults: searchResults ?? this.searchResults,
    );
  }
}

@Riverpod(keepAlive: true)
class SearchPostNotifier extends _$SearchPostNotifier {
  @override
  Future<SearchPostStateInternal> build() async {
    final initialSearchModel = SearchPostModel(
      budget: 0,
      startDate: DateTime.now().subtract(const Duration(days: 30)),
      endDate: DateTime.now(),
    );

    return SearchPostStateInternal(
      currentSearchModel: initialSearchModel,
      searchResults: const AsyncValue.data([]),
    );
  }

  void updateQuery(String newQuery) {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncData(
      currentState.copyWith(
        currentSearchModel: currentState.currentSearchModel.copyWith(
          query: newQuery,
        ),
      ),
    );
  }

  void updateLocation(String newLocation) {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncData(
      currentState.copyWith(
        currentSearchModel: currentState.currentSearchModel.copyWith(
          location: newLocation,
        ),
      ),
    );
  }

  void toggleJobType(JobPostingType type) {
    final currentState = state.value;
    if (currentState == null) return;

    final currentJobTypes = List<JobPostingType>.from(
      currentState.currentSearchModel.jobType,
    );
    if (currentJobTypes.contains(type)) {
      currentJobTypes.remove(type);
    } else {
      currentJobTypes.add(type);
    }
    state = AsyncData(
      currentState.copyWith(
        currentSearchModel: currentState.currentSearchModel.copyWith(
          jobType: currentJobTypes,
        ),
      ),
    );
  }

  Future<void> performSearch() async {
    final currentState = state.value;
    if (currentState == null) {
      return;
    }

    final searchModelToUse = currentState.currentSearchModel;

    if (searchModelToUse.isEmptyModel()) {
      state = AsyncData(
        currentState.copyWith(searchResults: const AsyncValue.data([])),
      );
      return;
    }

    state = AsyncData(
      currentState.copyWith(searchResults: const AsyncValue.loading()),
    );

    try {
      // final service = ref.read(searchPostServiceProvider);
      final results = await ref
          .read(searchPostServiceProvider)
          .searchPost(searchModelToUse);
      state = AsyncData(
        currentState.copyWith(searchResults: AsyncValue.data(results)),
      );
    } catch (e, st) {
      state = AsyncData(
        currentState.copyWith(searchResults: AsyncValue.error(e, st)),
      );
    }
  }

  SearchPostModel get currentSearchModel =>
      state.value?.currentSearchModel ??
      SearchPostModel(
        budget: 0,
        startDate: DateTime.now(),
        endDate: DateTime.now(),
      );

  AsyncValue<List<PostModel>> get searchResultsState =>
      state.value?.searchResults ?? const AsyncValue.data([]);
  List<PostModel> get searchResultsList => searchResultsState.value ?? [];
  bool get isSearchResultsLoading => searchResultsState.isLoading;
  bool get hasSearchResultsError => searchResultsState.hasError;

  bool get showRecentOrPopular =>
      currentSearchModel.query.trim().isEmpty &&
      currentSearchModel.location.trim().isEmpty &&
      currentSearchModel.jobType.isEmpty &&
      !isSearchResultsLoading &&
      searchResultsList.isEmpty;
}
