import 'package:flutter/material.dart';
import 'package:patrickcoutinho/models/article.dart';
import 'package:patrickcoutinho/models/youtube_card_content.dart';
import 'package:patrickcoutinho/pages/video_article_details.dart';
import 'package:patrickcoutinho/utils/cached_image.dart';
import 'package:patrickcoutinho/utils/next_screen.dart';
import 'package:patrickcoutinho/widgets/video_icon.dart';

class YoutubeCard extends StatelessWidget {
  YoutubeCard({@required this.content});

  final YoutubeCardContent content;

  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Theme.of(context).shadowColor,
                    blurRadius: 10,
                    offset: Offset(0, 3))
              ]),
          child: Wrap(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width,
                    child: CustomCacheImage(
                      imageUrl: content.channelThumbnailUrl,
                      radius: 5.0,
                      circularShape: false,
                    ),
                  ),
                  VideoIcon(
                    contentType: 'video',
                    iconSize: 80,
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content.title ?? '',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    // Text(
                    //     HtmlUnescape()
                    //         .convert(parse(d.description).documentElement.text),
                    //     overflow: TextOverflow.ellipsis,
                    //     maxLines: 2,
                    //     style: TextStyle(
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.w500,
                    //         color: Theme.of(context).secondaryHeaderColor)),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Icon(
                    //       CupertinoIcons.time,
                    //       size: 16,
                    //       color: Colors.grey,
                    //     ),
                    //     SizedBox(
                    //       width: 3,
                    //     ),
                    //     Text(
                    //       format.format(DateTime.parse(date))?.toString()??'',
                    //       style: TextStyle(fontSize: 12, color: Theme.of(context).secondaryHeaderColor),
                    //     ),
                    //     Spacer(),
                    //     // Icon(
                    //     //   Icons.favorite,
                    //     //   size: 16,
                    //     //   color: Theme.of(context).secondaryHeaderColor,
                    //     // ),
                    //     // SizedBox(
                    //     //   width: 3,
                    //     // ),
                    //     // Text(
                    //     //   d.loves.toString(),
                    //     //   style: TextStyle(fontSize: 12, color: Theme.of(context).secondaryHeaderColor),
                    //     // )
                    //   ],
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          nextScreen(
              context,
              VideoArticleDetails(
                data: Article(
                    title: content.title,
                    category: 'Video',
                    contentType: 'video',
                    content: content.description,
                    date: content.createdAt,
                    description: '',
                    sourceUrl: '',
                    loves: 0,
                    timestamp: content.createdAt,
                    thumbnailImagelUrl: content.channelThumbnailUrl,
                    videoID: content.id,
                    youtubeVideoUrl: content.videoThumbnailUrl),
                tag: 'content.channelThumbnailUrl',
              ));
        });

    // return Container(
    //   margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
    //   child: Material(
    //     color: Color(0XFFFFFFFF),
    //     elevation: 2.0,
    //     borderRadius: BorderRadius.circular(12.0),
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: <Widget>[
    //
    //         Container(
    //           height: 160,
    //           width: MediaQuery.of(context).size.width,
    //           child: CustomCacheImage(
    //             imageUrl: content.channelThumbnailUrl,
    //             radius: 5.0,
    //             circularShape: false,
    //           ),
    //         ),
    //         SizedBox(width: 12.0),
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           mainAxisSize: MainAxisSize.min,
    //           children: <Widget>[
    //             Text(
    //               content.title,
    //               maxLines: 3,
    //               overflow: TextOverflow.ellipsis,
    //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    //             ),
    //             SizedBox(height: 8.0),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
