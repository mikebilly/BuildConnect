//
import 'package:buildconnect/models/enums/enums.dart';
import 'package:dart_mappable/dart_mappable.dart';
part 'post_model.mapper.dart';

@MappableClass()
class PostModel with PostModelMappable {
  PostModel({
    this.id,
    required this.title,
    required this.jobPostingType,
    required this.location,
    required this.description,
    this.budget,
    this.deadline,
    this.requiredSkills,
    this.categories,
    required this.authorId,
    this.createdAt,
  });

  String? id;

  final String title;

  @MappableField(key: 'job_posting_type')
  final JobPostingType jobPostingType;

  final String location;
  final String description;
  final double? budget;
  final DateTime? deadline;
  final List<String>? requiredSkills;
  final List<String>? categories;

  @MappableField(key: 'author_id')
  final String authorId;

  @MappableField(key: 'created_at')
  final DateTime? createdAt;
}
