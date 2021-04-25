import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:news_app/blocs/ads_bloc.dart';
import 'package:news_app/blocs/bookmark_bloc.dart';
import 'package:news_app/blocs/recent_articles_bloc.dart';
import 'package:news_app/blocs/sign_in_bloc.dart';
import 'package:news_app/blocs/theme_bloc.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/models/custom_color.dart';
import 'package:news_app/pages/comments.dart';
import 'package:news_app/utils/cached_image.dart';
import 'package:news_app/utils/sign_in_dialog.dart';
import 'package:news_app/widgets/bookmark_icon.dart';
import 'package:news_app/widgets/full_image.dart';
import 'package:news_app/widgets/launch_url.dart';
import 'package:news_app/widgets/love_count.dart';
import 'package:news_app/widgets/love_icon.dart';
import 'package:news_app/widgets/related_articles.dart';
import 'package:share/share.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import '../utils/next_screen.dart';

class ArticleDetails extends StatefulWidget {
  final Article data;
  final String tag;
  const ArticleDetails({Key key, @required this.data, @required this.tag})
      : super(key: key);

  @override
  _ArticleDetailsState createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetails> {
  InAppWebViewController webView;
  ContextMenu contextMenu;
  String url = "";
  double progress = 0;
  CookieManager _cookieManager = CookieManager.instance();


  double rightPaddingValue = 140;
  bool adInitiated;

  String date;

  DateFormat format = DateFormat('dd/MM/yyyy HH:mm');

  final GlobalKey webViewKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 0)).then((value) {
      context.read<RecentBloc>().getPost(widget.data.sourceUrl);
    });

    date = widget.data.date.substring(0, 10) +
        ' ' +
        widget.data.date.substring(11, 23);
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      setState(() {
        rightPaddingValue = 10;
      });
    });

    contextMenu = ContextMenu(
        menuItems: [
          ContextMenuItem(androidId: 1, iosId: "1", title: "Special", action: () async {
            print("Menu item Special clicked!");
            print(await webView.getSelectedText());
            await webView.clearFocus();
          })
        ],
        options: ContextMenuOptions(
            hideDefaultSystemContextMenuItems: true
        ),
        onCreateContextMenu: (hitTestResult) async {
          print("onCreateContextMenu");
          print(hitTestResult.extra);
          print(await webView.getSelectedText());
        },
        onHideContextMenu: () {
          print("onHideContextMenu");
        },
        onContextMenuActionItemClicked: (contextMenuItemClicked) async {
          var id = (Platform.isAndroid) ? contextMenuItemClicked.androidId : contextMenuItemClicked.iosId;
          print("onContextMenuActionItemClicked: " + id.toString() + " " + contextMenuItemClicked.title);
        }
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sb = context.watch<SignInBloc>();
    final ab = context.watch<AdsBloc>();
    final rb = context.watch<RecentBloc>();
    final Article d = widget.data;

    return SafeArea(
      bottom: true,
      top: false,
      maintainBottomViewPadding: true,
      minimum: EdgeInsets.only(
          bottom: ab.bannerAd == true
              ? Platform.isAndroid
                  ? 60
                  : 80
              : 0),
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    expandedHeight: 270,
                    flexibleSpace: FlexibleSpaceBar(
                        background: widget.tag == null
                            ? CustomCacheImage(
                                imageUrl: d.thumbnailImagelUrl, radius: 0.0)
                            : Hero(
                                tag: widget.tag,
                                child: CustomCacheImage(
                                    imageUrl: d.thumbnailImagelUrl,
                                    radius: 0.0),
                              )),
                    leading: IconButton(
                      icon: Icon(Icons.keyboard_backspace,
                          size: 22, color: Colors.white),
                      onPressed: () {
                        rb.cleanDom();
                        Navigator.pop(context);
                      },
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.share, size: 22, color: Colors.white),
                        onPressed: () {
                          // _handleShare();
                        },
                      ),
                      SizedBox(
                        width: 5,
                      )
                    ],
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                        alignment: Alignment.center,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: context
                                                      .watch<ThemeBloc>()
                                                      .darkTheme ==
                                                  false
                                              ? CustomColor().loadingColorLight
                                              : CustomColor().loadingColorDark,
                                        ),
                                        child: AnimatedPadding(
                                          duration:
                                              Duration(milliseconds: 1000),
                                          padding: EdgeInsets.only(
                                              left: 10,
                                              right: rightPaddingValue,
                                              top: 5,
                                              bottom: 5),
                                          child: Text(
                                            d.category ?? 'Artigo',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )),
                                    Spacer(),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(CupertinoIcons.time_solid,
                                        size: 18, color: Colors.grey),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      format.format(DateTime.parse(date)),
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .secondaryHeaderColor,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  d.title,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Divider(
                                  color: Theme.of(context).primaryColor,
                                  endIndent: 280,
                                  thickness: 2,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                !rb.isLoading
                                    ? Container(
                                        //height: 1500,
                                        child: Html(
                                          data:
                                          '''${rb.dom}''',
                                          style: {
                                            "p": null,
                                            "br": Style(
                                            ),
                                            'div': Style(
                                              margin: EdgeInsets.symmetric(
                                              ),
                                              lineHeight: 0,
                                              textAlign: TextAlign.justify,

                                            ),
                                            // 'span': Style(
                                            //   backgroundColor: Colors.red
                                            // ),
                                            'strong': Style(
                                                fontSize: FontSize(16),
                                                padding: EdgeInsets.all(0),
                                              textAlign: TextAlign.justify
                                            )
                                          },
                                          onLinkTap: (url) async {
                                            launchURL(context, url);
                                          },
                                          onImageTap: (imageUrl) =>
                                              nextScreenPopup(
                                                  context,
                                                  FullScreeImage(
                                                      imageUrl: imageUrl)),
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        child: CircularProgressIndicator(),
                                      ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
