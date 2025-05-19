import 'dart:convert';
import 'dart:math';
import 'package:buildconnect/models/article/article_model.dart';
import 'package:flutter/foundation.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
//b130038a627c47e4ba02baef18b4e81c
// Điều chỉnh đường dẫn

class NewsService {
  final String _baseUrl = "https://baoxaydung.vn";
  final String _categoryUrl = "/xay-dung.htm";

  Future<List<ArticleModel>> fetchArticles() async {
    final List<ArticleModel> articles = [];
    try {
      final response = await http.get(Uri.parse(_baseUrl + _categoryUrl));

      if (response.statusCode == 200) {
        final document = parse(utf8.decode(response.bodyBytes));

        // Selector dựa trên HTML bạn cung cấp: div.box-category-middle > div.box-category-item
        final articleElements = document.querySelectorAll(
          'div.box-category-middle > div.box-category-item',
        );

        if (kDebugMode) {
          print('Found ${articleElements.length} article elements.');
        }

        for (var element in articleElements) {
          try {
            final dom.Element? titleAnchorElement = element.querySelector(
              'h3.box-category-title-text > a.box-category-link-title',
            );
            final String? articleRelativeUrl =
                titleAnchorElement?.attributes['href'];
            final String? title =
                titleAnchorElement?.text.trim() ??
                titleAnchorElement?.attributes['title']?.trim();

            final dom.Element? imageElement = element.querySelector(
              'a.box-category-link-with-avatar > img.box-category-avatar',
            );
            final String? imageUrl = imageElement?.attributes['src'];

            final dom.Element? sapoElement = element.querySelector(
              'p.box-category-sapo',
            );
            final String? description = sapoElement?.text.trim();

            if (title != null &&
                title.isNotEmpty &&
                articleRelativeUrl != null &&
                articleRelativeUrl.isNotEmpty) {
              String fullArticleUrl =
                  articleRelativeUrl.startsWith('http')
                      ? articleRelativeUrl
                      : _baseUrl + articleRelativeUrl;
              DateTime publishedAt = await _fetchPublishedDateFromDetailPage(
                fullArticleUrl,
              );
              articles.add(
                ArticleModel(
                  sourceName: 'Báo Xây Dựng',
                  title: title,
                  description: description ?? '',
                  url: fullArticleUrl,
                  imageUrl: imageUrl!,
                  publishedAt: publishedAt,
                ),
              );
            }
          } catch (e, s) {
            if (kDebugMode) {
              print('Error parsing an article element: $e');
              print('Stacktrace: $s');
            }
          }
        }
      } else {
        if (kDebugMode) {
          print('Failed to load category page: ${response.statusCode}');
        }
        throw Exception('Failed to load category page: ${response.statusCode}');
      }
    } catch (e, s) {
      if (kDebugMode) {
        print('Error fetching recent articles: $e');
        print('Stacktrace: $s');
      }
      rethrow;
    }
    if (kDebugMode) {
      print(
        'Successfully scraped ${articles.length} articles from category page.',
      );
    }
    if (articles.isNotEmpty) {
      final random = Random();
      articles.shuffle(random); // Sử dụng phương thức shuffle có sẵn của List
    }
    return articles;
  }

  DateTime? parsePublishDateFromHtml(String htmlContent) {
    try {
      final document = parse(htmlContent);

      final dom.Element? dateElement = document.querySelector(
        'div.name-flex > span.name2[data-role="publishdate"]',
      );

      if (dateElement != null) {
        final String? dateString = dateElement.text.trim();
        if (kDebugMode) {
          print('Found raw date string: "$dateString"');
        }

        if (dateString != null && dateString.isNotEmpty) {
          try {
            final dateFormat = DateFormat('dd/MM/yyyy, HH:mm');
            final DateTime publishedDate = dateFormat.parseStrict(dateString);
            if (kDebugMode) {
              print('Parsed DateTime: $publishedDate');
            }
            return publishedDate;
          } catch (e) {
            if (kDebugMode) {
              print('Error parsing date string "$dateString": $e');
            }

            try {
              final dateFormatNoTime = DateFormat('dd/MM/yyyy');
              final DateTime publishedDate = dateFormatNoTime.parseStrict(
                dateString,
              );
              if (kDebugMode) {
                print('Parsed DateTime (no time): $publishedDate');
              }
              return publishedDate;
            } catch (e2) {
              if (kDebugMode) {
                print('Error parsing date string (no time) "$dateString": $e2');
              }
            }
          }
        } else {
          if (kDebugMode) {
            print('Date string is empty or null.');
          }
        }
      } else {
        if (kDebugMode) {
          print('Date element not found with selector.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error parsing HTML for date: $e');
      }
    }
    return null;
  }

  Future<DateTime> _fetchPublishedDateFromDetailPage(String articleUrl) async {
    try {
      final response = await http.get(Uri.parse(articleUrl));
      if (response.statusCode == 200) {
        final htmlContent = utf8.decode(response.bodyBytes);
        DateTime? parsedDate = parsePublishDateFromHtml(htmlContent);
        return parsedDate ??
            DateTime.now(); // Trả về ngày parse được hoặc ngày hiện tại nếu lỗi
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching detail page for $articleUrl: $e');
      }
    }
    return DateTime.now(); // Trả về ngày hiện tại nếu có lỗi fetch trang
  }
}
