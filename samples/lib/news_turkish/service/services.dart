import 'dart:convert';

import 'package:samples/news_turkish/model/newsModel.dart';
import 'package:http/http.dart' as http;
import 'package:samples/news_turkish/model/result.dart';

class NewsServices {
  Future<List<Results>> getDatas(String category) async{
    final String url = 'https://newsdata.io/api/1/latest?country=tr&category=$category&apikey=pub_5615643768d3fd940b2b9159932ff29d46731';
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200) {
      final result = json.decode(utf8.decode(response.bodyBytes));
      NewsModel model = NewsModel.fromJson(result);

      return model.results ?? [];
    }

    throw Exception('Bad request');
  }
}