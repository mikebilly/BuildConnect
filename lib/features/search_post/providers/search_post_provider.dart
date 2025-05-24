import 'package:buildconnect/features/search_post/providers/search_post_service_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../models/post/post_model.dart';
import '../../../models/search_post/search_post_model.dart';
import '../../../models/enums/enums.dart';

part 'search_post_provider.g.dart';

@Riverpod(keepAlive: true)
class SearchPostNotifier extends _$SearchPostNotifier {
  @override
  SearchPostModel build() {
    return SearchPostModel();
  }

  void updateQuery(String newQuery) {
    state = state.copyWith(query: newQuery);
  }

  void updateLocation(City newLocation) {}

  void toggleJobType(JobPostingType type) {}

  Future<List<PostModel>?> searchPost() async {
    debugPrint('---------------------------');
    debugPrint(state.toString());
    debugPrint('---------------------------');
    final model = state;
    if (model.isEmptyModel()) {
      debugPrint('Search model is empty');
      return null;
    }
    final service = ref.read(searchPostServiceProvider);
    final result = await service.searchPost(model);
    return result;
  }

  void toggleLocation(City city) {
    var current = state.location ?? [];
    var updatedList = List<City>.from(current);
    if (current.contains(city)) {
      updatedList.remove(city);
    } else {
      updatedList.add(city);
    }
    state = state.copyWith(location: updatedList);
  }

  Set<ProfileType> getProfileTypeChoosing() {
    return Set<ProfileType>.from(state.profileType);
  }

  void toggleProfileType(ProfileType type) {
    final current = state.profileType;
    final updatedList = List<ProfileType>.from(
      current,
    ); // bản sao có thể thay đổi

    if (updatedList.contains(type)) {
      updatedList.remove(type);
    } else {
      updatedList.add(type);
    }

    state = state.copyWith(profileType: updatedList);
  }

  void setLocation(List<City> current_location_list) {
    state = state.copyWith(location: current_location_list);
  }

  Set<JobPostingType> getJobPostingTypeChoosing() {
    return Set<JobPostingType>.from(state.jobType);
  }

  void toggleJobPostingType(JobPostingType v) {
    final current = state.jobType;
    final updatedList = List<JobPostingType>.from(current);

    if (updatedList.contains(v)) {
      updatedList.remove(v);
    } else {
      updatedList.add(v);
    }

    state = state.copyWith(jobType: updatedList);
  }

  void clearAllFilters() {
    state = state.copyWith(
      query: '',
      location: [],
      jobType: [],
      profileType: [],
      domain: [],
    );
  }

  Set<Domain> getDomainChoosing() {
    return Set<Domain>.from(state.domain);
  }

  void toggleDomain(Domain v) {
    final current = state.domain;
    final updatedList = List<Domain>.from(current);

    if (updatedList.contains(v)) {
      updatedList.remove(v);
    } else {
      updatedList.add(v);
    }

    state = state.copyWith(domain: updatedList);
  }
}
