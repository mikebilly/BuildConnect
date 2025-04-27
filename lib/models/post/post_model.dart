// lib/models/post/post_model.dart
import 'package:buildconnect/models/enums/enums.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:postgrest/src/types.dart';

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

  String? id; // We will use uuid
  final String title;
  final JobPostingType jobPostingType;
  final String location;
  final String description;
  final double? budget;
  final DateTime? deadline;
  final List<String>? requiredSkills;
  final List<String>? categories;
  final String authorId; // ID of the user who created the post
  final DateTime? createdAt;
}
