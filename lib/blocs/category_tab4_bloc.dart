import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:patrickcoutinho/models/article.dart';

class CategoryTab4Bloc extends ChangeNotifier{
  
  List<Article> _data = [];
  List<Article> get data => _data;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _hasData;
  bool get hasData => _hasData;

  Future<Null> getData(mounted, String category) async {
    notifyListeners();
    return null;
  }

  setLoading(bool isloading) {
    _isLoading = isloading;
    notifyListeners();
  }

  onRefresh(mounted, String category) {
    _isLoading = true;
    _data.clear();
    getData(mounted, category);
    notifyListeners();
  }



}