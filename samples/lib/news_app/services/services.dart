import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:samples/news_app/models/articles.dart';
import 'package:samples/news_app/models/models.dart';
class NewsServices {
  Future<List<Articles>> getNewsData(String category) async{
    final String url = 'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=df8a5eab68dd4646b0a7a79e5234b3c9';
    final response = await http.get(Uri.parse(url));
    
    if(response.statusCode == 200) {
      final result = jsonDecode(response.body);
      News news = News.fromJson(result);

      return news.articles ?? [];
    }
    
    throw Exception('Bad request');
  }


}