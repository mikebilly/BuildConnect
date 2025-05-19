import 'package:dart_mappable/dart_mappable.dart';
part 'article_model.mapper.dart';

@MappableClass()
class ArticleModel with ArticleModelMappable {
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final String sourceName;
  final DateTime publishedAt;

  ArticleModel({
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.sourceName,
    required this.publishedAt,
  });
}
