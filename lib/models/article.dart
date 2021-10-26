import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Article {
  String category;
  String contentType;
  String title;
  String description;
  String content;
  String thumbnailImagelUrl;
  String youtubeVideoUrl;
  String videoID;
  int loves;
  String sourceUrl;
  String date;
  String timestamp;

  Article(
      {this.category,
      this.contentType,
      this.title,
      this.description,
      this.content,
      this.thumbnailImagelUrl,
      this.youtubeVideoUrl,
      this.videoID,
      this.loves,
      this.sourceUrl,
      this.date,
      this.timestamp});

  factory Article.fromJson(Map json) {
    return Article(
      category: json['category'],
      contentType: json['content type'],
      title: json['title'],
      description: json['excerpt'],
      content: json['content'],
      thumbnailImagelUrl: json['image'] != null ? imageUrl(json['image']) : '',
      youtubeVideoUrl: json['youtube url'],
      videoID: json['content type'] == 'video'
          ? YoutubePlayer.convertUrlToId(json['youtube url'],
              trimWhitespaces: true)
          : '',
      loves: json['loves'],
      sourceUrl: json['postPageUrl'],
      date: json['publishedDate'],
      timestamp: json['timestamp'],
    );
  }
}

String imageUrl(String wixReferenceUrl) {
  var splitedReference = wixReferenceUrl.split('/');
  return 'https://static.wixstatic.com/media/' + splitedReference[3];
}
