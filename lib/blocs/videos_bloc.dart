import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:patrickcoutinho/models/article.dart';
import 'package:youtube_api/youtube_api.dart';

class VideosBloc extends ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<YT_API> _videos = [];
  List<Article> _data = [];
  List<Article> get data => _data;
  List<YT_API> get videos => _videos;

  String _popSelection = 'recent';
  String get popupSelection => _popSelection;

  bool _hasData;
  bool get hasData => _hasData;

  Future<void> get() async {
    setLoading(true);
    String key = 'AIzaSyCVxTPw5efdD6SL50IBqCCYT6jRPXwgSeY';
    YoutubeAPI ytApi = new YoutubeAPI(key, maxResults: 200);

    String query = "UCO1IIMNSxM5_o85ycTy8luA";
    _videos = await ytApi.channel(query);
    setLoading(false);
    notifyListeners();
  }

  Future<void> getData(mounted, String orderBy) async {
    _hasData = true;

    notifyListeners();
    return null;
  }

  afterPopSelection(value, mounted, orderBy) {
    _popSelection = value;
    onRefresh(mounted, orderBy);
    notifyListeners();
  }

  setLoading(bool isloading) {
    _isLoading = isloading;
    notifyListeners();
  }

  onRefresh(mounted, orderBy) {
    _isLoading = true;
    _data.clear();
    get();
    //  getData(mounted, orderBy);
    notifyListeners();
  }
}
