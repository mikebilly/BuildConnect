import 'package:buildconnect/models/enums/enums.dart';
import 'package:dart_mappable/dart_mappable.dart';
part 'search_profile_model.mapper.dart';

@MappableClass()
class SearchProfileModel with SearchProfileModelMappable {
  String? query;
  List<City>? cityList;
  List<ProfileType>? profileType;
  final int? minYearsOfExperience;
  SearchProfileModel({
    this.query,
    this.cityList = const [],
    this.profileType,
    this.minYearsOfExperience,
  });
  bool isEmptyModel() {
    return query == null && cityList == null && profileType == null;
  }
}
