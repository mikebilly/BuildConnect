import 'package:buildconnect/models/enums/enums.dart';
import 'package:dart_mappable/dart_mappable.dart';
part 'search_profile_model.mapper.dart';

@MappableClass()
class ArchitectFilterModel with ArchitectFilterModelMappable {
  ArchitectRole? architectRole;
  List<DesignStyle> designStyle;
  ArchitectFilterModel({this.architectRole, this.designStyle = const []});
}

@MappableClass()
class ContractorFilterModel with ContractorFilterModelMappable {
  List<ServiceType> serviceType;
  ContractorFilterModel({this.serviceType = const []});
}

@MappableClass()
class ConstructionTeamFilterModel with ConstructionTeamFilterModelMappable {
  List<ServiceType> serviceType;
  ConstructionTeamFilterModel({this.serviceType = const []});
}

@MappableClass()
class SupplierFilterModel with SupplierFilterModelMappable {
  List<MaterialCategory> materialCategory;
  SupplierFilterModel({this.materialCategory = const []});
}

@MappableClass()
class SearchProfileModel with SearchProfileModelMappable {
  String query;
  List<City> cityList;
  List<ProfileType> profileType;
  final int? minYearsOfExperience;
  final ArchitectFilterModel? architectFilterModel;
  final ContractorFilterModel? contractorFilterModel;
  final ConstructionTeamFilterModel? constructionTeamFilterModel;
  final SupplierFilterModel? supplierFilterModel;
  SearchProfileModel({
    this.query = '',
    this.cityList = const [],
    this.profileType = const [],
    this.minYearsOfExperience,
    this.architectFilterModel,
    this.contractorFilterModel,
    this.constructionTeamFilterModel,
    this.supplierFilterModel,
  });
  bool isEmptyModel() {
    return query.isEmpty && cityList.isEmpty && profileType.isEmpty;
  }

  @override
  String toString() {
    return 'SearchProfileModel(query: $query, cityList: $cityList, profileType: $profileType, minYearsOfExperience: $minYearsOfExperience, architectFilterModel: $architectFilterModel, contractorFilterModel: $contractorFilterModel, constructionTeamFilterModel: $constructionTeamFilterModel, supplierFilterModel: $supplierFilterModel)';
  }
}
