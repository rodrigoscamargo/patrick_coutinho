import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' hide Text;

class RecentBloc extends ChangeNotifier {
  List<Article> _data = [];
  List<Article> get data => _data;
  String _dom;
  String get dom => _dom;

  final Dio _dio = Dio();

  DocumentSnapshot _lastVisible;
  DocumentSnapshot get lastVisible => _lastVisible;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  void cleanDom() => _dom = '';

  Future<List> getNotificationsList() async {
    try {
      final result = await _dio
          .get('https://www.patrickcoutinhoadvogados.com.br/_functions/posts');

      if (result.statusCode == 200) {
        List posts = result.data['posts'];
        return posts;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<Null> getPost(String path) async {
    _isLoading = true;
    try {
      final result =
          await _dio.get('https://www.patrickcoutinhoadvogados.com.br$path');

      if (result.statusCode == 200) {
        var _document = parse(result.data);
        _dom = _document.getElementsByClassName('kaqlz')[0].outerHtml;
        
        _dom.replaceAll('<br>', '');


        notifyListeners();
      } else {
        notifyListeners();
      }
    } catch (e) {
      notifyListeners();
    }
    _isLoading = false;
  }

  Future<Null> getData(mounted) async {
    final result = await _dio
        .get('https://www.patrickcoutinhoadvogados.com.br/_functions/posts');

    if (result.data['posts'].isNotEmpty) {
      // _hasData = true;

      if (mounted) {
        _isLoading = false;
        _data = List<Article>.from(
            result.data['posts'].map((e) => Article.fromJson(e)));
      }

      notifyListeners();
      return null;
    } else {
      notifyListeners();
      return null;
    }
  }

  // Future<Null> getData(mounted) async {
  //   QuerySnapshot rawData;
  //
  //   if (_lastVisible == null)
  //     rawData = await firestore
  //         .collection('contents')
  //         .orderBy('timestamp', descending: true)
  //         .limit(4)
  //         .get();
  //   else
  //     rawData = await firestore
  //         .collection('contents')
  //         .orderBy('timestamp', descending: true)
  //         .startAfter([_lastVisible['timestamp']])
  //         .limit(4)
  //         .get();
  //
  //
  //
  //
  //
  //   if (rawData != null && rawData.docs.length > 0) {
  //     _lastVisible = rawData.docs[rawData.docs.length - 1];
  //     if (mounted) {
  //       _isLoading = false;
  //       _snap.addAll(rawData.docs);
  //       _data = _snap.map((e) => Article.fromFirestore(e)).toList();
  //       notifyListeners();
  //     }
  //   } else {
  //     _isLoading = false;
  //     print('no items available');
  //     notifyListeners();
  //
  //   }
  //   return null;
  // }

  setLoading(bool isloading) {
    _isLoading = isloading;
    notifyListeners();
  }

  onRefresh(mounted) {
    _isLoading = true;
    _data.clear();
    _lastVisible = null;
    getData(mounted);
    notifyListeners();
  }
}
