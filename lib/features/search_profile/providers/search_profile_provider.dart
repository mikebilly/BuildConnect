import 'package:buildconnect/features/auth/providers/auth_service_provider.dart';
import 'package:buildconnect/features/auth/services/auth_service.dart';
import 'package:buildconnect/features/search_profile/providers/search_profile_service_provider.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:buildconnect/models/profile/profile_model.dart';
import 'package:buildconnect/models/search_profile/search_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_profile_provider.g.dart';

@Riverpod(keepAlive: true)
class SearchProfileNotifier extends _$SearchProfileNotifier {
  AuthService get _authService => ref.watch(authServiceProvider);
  bool get _isLoggedIn => _authService.isLoggedIn;
  String? get _userId => _authService.currentUserId;

  @override
  SearchProfileModel build() {
    if (!_isLoggedIn || _userId == null) {
      debugPrint("Not logged in");
    } else {
      debugPrint('Logged into ProfileData, userId: $_userId');
    }

    // Trả về state khởi tạo ban đầu
    return SearchProfileModel(); // đảm bảo model có default constructor
  }

  void updateQuery(String query) {
    state = state.copyWith(query: query);
    debugPrint(state.query);
    // gọi suggestion ở đây nếu cần
  }

  void toggleLocation(City city) {
    final current = state.cityList ?? [];

    final updatedList = current.contains(city) ? current : [...current, city];

    state = state.copyWith(cityList: updatedList);
  }

  void setLocation(List<City>? location) {
    state.copyWith(cityList: location);
  }

  void setProfileType(List<ProfileType>? profileType) {
    state.copyWith(profileType: profileType);
  }

  void updateYearsOfExperience(int? years) {
    state = state.copyWith(minYearsOfExperience: years);
  }

  Future<List<Profile>?> searchProfile() async {
    debugPrint(state.toString());
    final model = state;
    if (model.isEmptyModel()) {
      debugPrint('Search model is empty');
      return null;
    }
    debugPrint('Searching with model: ${model.toString()}');
    final service = ref.read(searchProfileServiceProvider);
    final result = await service.searchProfile(model);
    return result;
  }

  void toggleProfileType(ProfileType type) {
    final current = state.profileType ?? [];

    final updatedList =
        current.contains(type)
            ? current.where((c) => c != type).toList()
            : [...current, type];

    state = state.copyWith(profileType: updatedList);
  }

  bool isSelectedProfileType(ProfileType? p) {
    if (state.profileType == null)
      return false;
    else {
      bool check = state.profileType!.contains(p);
      return check;
    }
    ;
  }

  void clearAllFilters() {
    state = state.copyWith(
      query: '',
      cityList: const [], // empty list, not null
      profileType: null,
      // yearsOfExperience: null,
      // suggestions: const [], // if you have suggestions
    );
  }
}
