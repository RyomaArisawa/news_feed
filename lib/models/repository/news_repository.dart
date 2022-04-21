import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_feed/models/model/news_model.dart';

import '../../data/category_info.dart';
import '../../data/search_type.dart';

class NewsRepository {
  static const BASE_URL = "https://newsapi.org/v2/top-headlines?country=jp";
  static const API_KEY = "1dcea3c77ad44d628d79f868cd304990";

  Future<List<Article>> getNews(
      {required SearchType searchType,
      String? keyword,
      Category? category}) async {
    List<Article> results = [];
    http.Response? response;

    switch (searchType) {
      case SearchType.HEAD_LINE:
        final requestUrl = Uri.parse(BASE_URL + "&apiKey=$API_KEY");
        response = await http.get(requestUrl);
        break;
      case SearchType.KEYWORD:
        final requestUrl = Uri.parse(BASE_URL + "&q=$keyword&apiKey=$API_KEY");
        response = await http.get(requestUrl);
        break;
      case SearchType.CATEGORY:
        final requestUrl = Uri.parse(
            BASE_URL + "&category=${category?.nameEn}&apiKey=$API_KEY");
        response = await http.get(requestUrl);
        break;
    }

    if (response.statusCode == 200) {
      final responseBody = response.body;

      results = News.fromJson(jsonDecode(responseBody)).articles;
    } else {
      throw Exception("Failed to load News");
    }
    return results;
  }
}
