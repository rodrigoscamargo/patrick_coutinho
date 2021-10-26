import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart';
import 'package:patrickcoutinho/blocs/ads_bloc.dart';
import 'package:patrickcoutinho/blocs/recent_articles_bloc.dart';
import 'package:patrickcoutinho/blocs/sign_in_bloc.dart';
import 'package:patrickcoutinho/blocs/theme_bloc.dart';
import 'package:patrickcoutinho/models/article.dart';
import 'package:patrickcoutinho/models/custom_color.dart';
import 'package:patrickcoutinho/utils/cached_image.dart';
import 'package:patrickcoutinho/widgets/full_image.dart';
import 'package:patrickcoutinho/widgets/launch_url.dart';
import 'package:html/dom.dart' as dom;
import 'package:provider/provider.dart';
import 'dart:io';
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
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
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
                                            ? CustomColor()
                                                .loadingColorLight
                                            : CustomColor()
                                                .loadingColorDark,
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
                                      //height: 3500,
                                      child: Html(
                                        shrinkWrap: true,
                                        data: '''${rb.dom}''',
                                        style: {
                                          "p": null,
                                          "br": Style(),
                                          'div': Style(
                                            margin: EdgeInsets.symmetric(),
                                            lineHeight: 0,
                                            textAlign: TextAlign.justify,
                                          ),
                                          // 'span': Style(
                                          //   backgroundColor: Colors.red
                                          // ),
                                          'strong': Style(
                                              fontFamily: 'Helvetica',
                                              fontSize: FontSize(16),
                                              fontWeight: FontWeight.normal,
                                              padding: EdgeInsets.all(0),
                                              textAlign: TextAlign.justify)
                                        },
                                        customRender: {
                                          'img': (RenderContext context,
                                              Widget child, attributes, _) {
                                            return Container(
                                              alignment: Alignment.center,
                                              child: Image.network(
                                                  attributes["src"]),
                                            );
                                          },
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

Widget getImageCustomRender(
  RenderContext context,
  Widget parsedChild,
  Map<String, String> attributes,
  dom.Element element,
) {
  return Container();
}
