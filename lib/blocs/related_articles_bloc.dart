import 'package:flutter/foundation.dart';
import 'package:patrickcoutinho/models/article.dart';

class RelatedBloc extends ChangeNotifier {
  List<Article> _data = [];
  List<Article> get data => _data;

  Future getData(String category, String timestamp) async {
    notifyListeners();
  }

  onRefresh(mounted, String stateName, String timestamp) {
    _data.clear();
    getData(stateName, timestamp);
    notifyListeners();
  }
}
