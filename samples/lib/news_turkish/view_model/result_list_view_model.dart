import 'package:flutter/material.dart';
import 'package:samples/news_turkish/service/services.dart';
import 'package:samples/news_turkish/view_model/result_view_model.dart';

class ResultListViewModel with ChangeNotifier{
  ResultViewModel viewModel = ResultViewModel('top', []);
  Status status = Status.initial;

  ResultListViewModel() {
    getNews('top');
  }

  Future<void> getNews(String category) async {
    status = Status.loading;
    notifyListeners();
    viewModel.results = await NewsServices().getDatas(category);
    status = Status.loaded;
    notifyListeners();
  }
}

enum Status {
  initial,
  loading,
  loaded
}