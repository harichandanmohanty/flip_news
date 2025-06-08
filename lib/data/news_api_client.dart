import 'dart:convert';

import 'package:flipnews/utils/util.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'model/top_headlines.dart';


const baseUrl = 'https://newsapi.org/v2/';

Future<TopHeadlines> getTopHeadLines(
    {required String selectedCategory, required String searchQuery}) async {
  final topHeadlinesUrl = '${baseUrl}top-headlines?country=us${searchQuery != '' ? '&q=$searchQuery' : ''}${selectedCategory == Category.all.name ? '' : '&category=$selectedCategory'}&apiKey=${const String.fromEnvironment('auth_key')}';
  final Response response = await http.get(Uri.parse(topHeadlinesUrl));
  final decodedValue = jsonDecode(response.body);
  Map<String, dynamic>? data = decodedValue;
  return TopHeadlines.fromJson(data ?? {});
}
