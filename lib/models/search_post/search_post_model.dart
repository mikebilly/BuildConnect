import 'package:buildconnect/models/enums/enums.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'search_post_model.mapper.dart';

@MappableClass()
class SearchPostModel with SearchPostModelMappable {
  String query;
  List<City> location;
  List<JobPostingType> jobType;
  final int? budget;

  final DateTime startDate;
  final DateTime endDate;
  SearchPostModel({
    this.query = '',
    this.location = const [],
    this.jobType = const [],
    this.budget,
    required this.startDate,
    required this.endDate,
  });
  bool isEmptyModel() {
    return query.isEmpty && location.isEmpty && jobType.isEmpty;
  }
}
