import 'package:flutter/material.dart';
import 'package:samples/news_app/services/services.dart';
import 'package:samples/news_app/viewModel/articleViewModel.dart';

enum Status { initial, loading, loaded }

class ArticleListViewModel extends ChangeNotifier {
  ArticleViewModel viewModel = ArticleViewModel('general', []);
  Status status = Status.initial;

  ArticleListViewModel() {
    getNews('sports');
  }

  Future<void> getNews(String category) async {
    status = Status.loading;
    notifyListeners();
    viewModel.articles = await NewsServices().getNewsData(category);
    status = Status.loaded;
    notifyListeners();
  }
}