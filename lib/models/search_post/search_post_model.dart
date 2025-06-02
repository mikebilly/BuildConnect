import 'package:buildconnect/models/enums/enums.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'search_post_model.mapper.dart';

@MappableClass()
class SearchPostModel with SearchPostModelMappable {
  String query;
  List<City> location;
  List<JobPostingType> jobType;
  final int? budget;
  List<ProfileType> profileType;
  List<Domain> domain;
  DateTime? startDate;
  DateTime? endDate;
  SearchPostModel({
    this.query = '',
    this.location = const [],
    this.jobType = const [],
    this.profileType = const [],
    this.domain = const [],
    this.budget,
    this.startDate,
    this.endDate,
  });
  bool isEmptyModel() {
    return query.isEmpty &&
        location.isEmpty &&
        jobType.isEmpty &&
        profileType.isEmpty &&
        domain.isEmpty;
  }
}
