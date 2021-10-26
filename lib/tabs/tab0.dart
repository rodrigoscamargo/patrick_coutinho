import 'package:flutter/material.dart';
import 'package:patrickkoutinho/blocs/featured_bloc.dart';
import 'package:patrickkoutinho/blocs/popular_articles_bloc.dart';
import 'package:patrickkoutinho/blocs/recent_articles_bloc.dart';
import 'package:patrickkoutinho/widgets/featured.dart';
import 'package:patrickkoutinho/widgets/popular_articles.dart';
import 'package:patrickkoutinho/widgets/recent_articles.dart';
import 'package:patrickkoutinho/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class Tab0 extends StatefulWidget {
  Tab0({Key key}) : super(key: key);

  @override
  _Tab0State createState() => _Tab0State();
}

class _Tab0State extends State<Tab0> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<FeaturedBloc>().onRefresh();
        context.read<PopularBloc>().onRefresh();
        context.read<RecentBloc>().onRefresh(mounted);
      },
      child: SingleChildScrollView(
        key: PageStorageKey('key0'),
        padding: EdgeInsets.all(0),
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            // SearchBar(),
            // Featured(),
            // PopularArticles(),
            RecentArticles()
          ],
        ),
      ),
    );
  }
}
