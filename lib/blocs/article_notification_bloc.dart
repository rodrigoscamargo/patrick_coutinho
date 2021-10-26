import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:patrickcoutinho/models/article.dart';

class ArticleNotificationBloc extends ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<Article> _data = [];
  List<Article> get data => _data;

  bool _hasData;
  bool get hasData => _hasData;

  Future<List> getNotificationsList() async {}

  Future<Null> getData(mounted) async {}

  onRefresh(mounted) {
    _isLoading = true;
    _data.clear();
    getData(mounted);
    notifyListeners();
  }
}
