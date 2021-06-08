import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app/views/widgets/apple_article.dart';
import 'package:news_app/views/widgets/tech_cruch.dart';
import 'package:news_app/views/widgets/tesla_article.dart';
import 'package:news_app/views/widgets/wall_street_article.dart';
import 'package:provider/provider.dart';
import 'package:news_app/providers/24_news.dart';

class News24 extends StatefulWidget {
  News24({Key key}) : super(key: key);

  @override
  _News24State createState() => _News24State();
}

class _News24State extends State<News24> {
  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 10,
            title: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Explore",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            titleSpacing: 0.0,
            automaticallyImplyLeading: false,
            bottom: new TabBar(
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 5.0),
                  //insets: EdgeInsets.symmetric(horizontal:60.0)
                ),
                indicatorColor: Color(0xFFffc55c),
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                tabs: <Widget>[
                  new Tab(
                    child: Row(
                      children: <Widget>[
                        Text('Apple',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  new Tab(
                    child: Row(
                      children: <Widget>[
                        Text('TechCruch',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  new Tab(
                    child: Row(
                      children: <Widget>[
                        Text('Tesla',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  new Tab(
                    child: Row(
                      children: <Widget>[
                        Text('Wall Street',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ]),
          ),
          body: Stack(
            children: [
              TabBarView(
                children: <Widget>[
                  AppleArticle(),
                  TechCruch(),
                  Tesla(),
                  WallStreet()
                ],
              ),
            ],
          )),
    );
  }
}
