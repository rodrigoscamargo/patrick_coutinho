import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:patrickcoutinho/models/article.dart';

class PopularBloc extends ChangeNotifier {
  List<Article> _data = [];
  List<Article> get data => _data;

  Future getData() async {
    notifyListeners();
  }

  onRefresh() {
    _data.clear();
    getData();
    notifyListeners();
  }
}
