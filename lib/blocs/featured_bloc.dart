import 'package:flutter/foundation.dart';
import 'package:patrickcoutinho/models/article.dart';

class FeaturedBloc with ChangeNotifier {
  List<Article> _data = [];
  List<Article> get data => _data;

  List featuredList = [];

  Future getData() async {}

  onRefresh() {
    featuredList.clear();
    _data.clear();
    getData();
    notifyListeners();
  }
}
