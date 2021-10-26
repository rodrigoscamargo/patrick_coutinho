import 'package:flutter/material.dart';

class YoutubeCardContent {
  YoutubeCardContent({
    @required this.id,
    @required this.url,
    @required this.videoThumbnailUrl,
    @required this.channelThumbnailUrl,
    @required this.trendingPosition,
    @required this.title,
    @required this.description,
    @required this.channelName,
    @required this.views,
    @required this.createdAt,
  });

  final String id;
  final String url;
  final String videoThumbnailUrl;
  final String channelThumbnailUrl;
  final int trendingPosition;
  final String title;
  final String description;
  final String channelName;
  final int views;
  final String createdAt;
}
