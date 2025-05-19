import 'package:buildconnect/features/auth/providers/auth_service_provider.dart';
import 'package:buildconnect/features/auth/services/auth_service.dart';
import 'package:buildconnect/features/search_profile/providers/search_profile_service_provider.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:buildconnect/models/profile/profile_model.dart';
import 'package:buildconnect/models/search_profile/search_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
    var current = state.cityList ?? [];
    var updatedList = List<City>.from(current);
    if (current.contains(city)) {
      updatedList.remove(city);
    } else {
      updatedList.add(city);
    }
    // final updatedList = current.contains(city) ? current : [...current, city];

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
    debugPrint('---------------------------');
    debugPrint(state.toString());
    debugPrint(state.architectFilterModel.toString());
    debugPrint('---------------------------');
    final model = state;
    if (model.isEmptyModel()) {
      debugPrint('Search model is empty');
      return null;
    }
    final service = ref.read(searchProfileServiceProvider);
    final result = await service.searchProfile(model);
    return result;
  }

  void toggleProfileType(ProfileType type) {
    final current = state.profileType;
    final updatedList = List<ProfileType>.from(
      current,
    ); // bản sao có thể thay đổi

    if (updatedList.contains(type)) {
      updatedList.remove(type);
      resetFilterByEachProfileType(type);
    } else {
      updatedList.add(type);
    }

    state = state.copyWith(profileType: updatedList);
  }

  bool isSelectedProfileTypeDetail(ProfileType? p) {
    bool check = state.profileType.contains(p);
    return check;
  }

  Map<ProfileType, bool> isSelectedProfileType() {
    return {
      ProfileType.architect: isSelectedProfileTypeDetail(ProfileType.architect),
      ProfileType.contractor: isSelectedProfileTypeDetail(
        ProfileType.contractor,
      ),
      ProfileType.constructionTeam: isSelectedProfileTypeDetail(
        ProfileType.constructionTeam,
      ),
      ProfileType.supplier: isSelectedProfileTypeDetail(ProfileType.supplier),
    };
  }

  String profileTypeName() {
    if (state.profileType.isEmpty)
      return 'No profile chosen';
    else {
      String res = '';
      for (final p in state.profileType) {
        res += p.label;
      }
      return res;
    }
  }

  void clearAllFilters() {
    debugPrint(
      '---------------------Curren state: ${state.toString()}-----------------',
    );
    state = state.copyWith(
      query: state.query,
      cityList: const [], // empty list, not null
      profileType: const [],
      architectFilterModel: null,
      contractorFilterModel: null,
      constructionTeamFilterModel: null,
      supplierFilterModel: null,
      // yearsOfExperience: null,
      // suggestions: const [], // if you have suggestions
    );
    debugPrint(
      '---------------------State sau khi clear All Filters: ${state.toString()}-----------------',
    );
  }

  bool isSelectedDesignStyle(DesignStyle type) {
    final model = state.architectFilterModel;
    if (model == null) return false;
    return model.designStyle.contains(type);
  }

  void toggleDesignStyle(DesignStyle type) {
    var model = state.architectFilterModel ?? ArchitectFilterModel();
    final currentList = List<DesignStyle>.from(model.designStyle);

    if (currentList.contains(type)) {
      currentList.remove(type);
    } else {
      currentList.add(type);
    }

    // Giả sử bạn có copyWith
    state = state.copyWith(
      architectFilterModel: model.copyWith(designStyle: currentList),
    );
  }

  void resetFilterByEachProfileType(ProfileType type) {
    switch (type) {
      case ProfileType.architect:
        state = state.copyWith(architectFilterModel: ArchitectFilterModel());
        break;
      case ProfileType.contractor:
        state = state.copyWith(contractorFilterModel: ContractorFilterModel());
        break;
      case ProfileType.constructionTeam:
        state = state.copyWith(
          constructionTeamFilterModel: ConstructionTeamFilterModel(),
        );
        break;
      case ProfileType.supplier:
        state = state.copyWith(supplierFilterModel: SupplierFilterModel());
        break;
      default:
        break;
    }
  }

  bool isSelectedServiceTypeOfConstructionTeam(ServiceType type) {
    final model = state.constructionTeamFilterModel;
    if (model == null) return false;
    return model.serviceType.contains(type);
  }

  void toggleServiceTypeOfConstructionTeam(ServiceType type) {
    var model =
        state.constructionTeamFilterModel ?? ConstructionTeamFilterModel();
    final currentList = List<ServiceType>.from(model.serviceType);

    if (currentList.contains(type)) {
      currentList.remove(type);
    } else {
      currentList.add(type);
    }

    // Giả sử bạn có copyWith
    state = state.copyWith(
      constructionTeamFilterModel: model.copyWith(serviceType: currentList),
    );
  }

  bool isSelectedServiceTypeOfContractor(ServiceType type) {
    final model = state.contractorFilterModel;
    if (model == null) return false;
    return model.serviceType.contains(type);
  }

  void toggleServiceTypeOfContractor(ServiceType type) {
    var model = state.contractorFilterModel ?? ContractorFilterModel();
    final currentList = List<ServiceType>.from(model.serviceType);

    if (currentList.contains(type)) {
      currentList.remove(type);
    } else {
      currentList.add(type);
    }

    // Giả sử bạn có copyWith
    state = state.copyWith(
      contractorFilterModel: model.copyWith(serviceType: currentList),
    );
  }

  isSelectedMaterialCategory(MaterialCategory type) {
    final model = state.supplierFilterModel;
    if (model == null) return false;
    return model.materialCategory.contains(type);
  }

  void toggleMaterialCategory(MaterialCategory type) {
    var model = state.supplierFilterModel ?? SupplierFilterModel();
    final currentList = List<MaterialCategory>.from(model.materialCategory);

    if (currentList.contains(type)) {
      currentList.remove(type);
    } else {
      currentList.add(type);
    }

    // Giả sử bạn có copyWith
    state = state.copyWith(
      supplierFilterModel: model.copyWith(materialCategory: currentList),
    );
  }

  bool isLoggedIn() => _isLoggedIn;
}

class ProfileTypeChoosingNotifier extends StateNotifier<List<ProfileType>> {
  ProfileTypeChoosingNotifier(super.state);

  @override
  List<ProfileType> build() {
    return [];
  }
}
