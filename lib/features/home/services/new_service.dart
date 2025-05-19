import 'dart:convert';
import 'package:buildconnect/models/article/article_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
//b130038a627c47e4ba02baef18b4e81c
// Điều chỉnh đường dẫn

class NewsService {
  final String _apiKey =
      "b130038a627c47e4ba02baef18b4e81c"; // Thay bằng API key của bạn từ newsapi.org
  final String _baseUrl = "https://newsapi.org/v2/everything";

  // Lấy tin tức về xây dựng (ví dụ)
  Future<List<ArticleModel>> fetchBaoXayDungNews({
    int page = 1,
    int pageSize = 10,
  }) async {
    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {
        'domains': 'baoxaydung.vn',
        'language': 'vi',
        'sortBy': 'publishedAt',
        'pageSize': '$pageSize',
        'page': '$page',
        'apiKey': _apiKey,
      },
    );

    debugPrint(uri.toString());
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('NewsAPI error ${response.statusCode}: ${response.body}');
    }

    final Map<String, dynamic> payload = json.decode(
      utf8.decode(response.bodyBytes),
    );
    final List<dynamic> articlesJson =
        payload['articles'] as List<dynamic>? ?? [];
    return articlesJson.map((j) => ArticleModelMapper.fromJson(j)).toList();
  }
}
