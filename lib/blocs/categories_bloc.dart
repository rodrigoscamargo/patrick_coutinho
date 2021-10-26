import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:patrickcoutinho/models/category.dart';

class CategoriesBloc extends ChangeNotifier {

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<CategoryModel> _data = [];
  List<CategoryModel> get data => _data;

  bool _hasData;
  bool get hasData => _hasData;

  Future<Null> getData(mounted) async {
    _hasData = true;

    notifyListeners();
    return null;
  }

  setLoading(bool isloading) {
    _isLoading = isloading;
    notifyListeners();
  }

  onRefresh(mounted) {
    _isLoading = true;
    _data.clear();
    getData(mounted);
    notifyListeners();
  }



}