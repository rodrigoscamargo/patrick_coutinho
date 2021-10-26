import 'package:flutter/foundation.dart';
import 'package:patrickcoutinho/models/article.dart';

class BookmarkBloc extends ChangeNotifier {
  Future<List> getArticles() async {
    String _collectionName = 'contents';
    String _fieldName = 'bookmarked items';
    List<Article> data = [];

    return data;
  }

  Future onBookmarkIconClick(String timestamp) async {}

  Future onLoveIconClick(String timestamp) async {}
}
