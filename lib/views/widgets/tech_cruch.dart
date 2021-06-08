import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app/models/core/24_news.dart';
import 'package:news_app/providers/24_news.dart';
import 'package:provider/provider.dart';

import 'article_card.dart';

class TechCruch extends StatefulWidget {
  TechCruch({Key key}) : super(key: key);

  @override
  _TechCruchState createState() => _TechCruchState();
}

class _TechCruchState extends State<TechCruch> {
   @override
  initState() {
    super.initState();
    final article = Provider.of<News24CategoryProvider>(context, listen: false);
    article.getTechArticle();
    print(article);
    inspect(article);
  }

  List<Widget> _showArticleCards(
    List<Article> articles,
  ) {
    return articles.map(
      (listing) {
        return InkWell(
          onTap: () {},
          child: Column(
            children: [
              /* Divider(
                color: Colors.black,
                indent: 1,
                endIndent: 1,
                thickness: 2,
              ), */
              ArticleCard(listing),
            ],
          ),
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final articleProvider =
        Provider.of<News24CategoryProvider>(context, listen: false);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => await articleProvider.getTechArticle(),
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 8),
              if (articleProvider.article.isNotEmpty)
                ..._showArticleCards(articleProvider.article),
              if (articleProvider.article.isEmpty)
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 100),
                    Center(
                      child: Text(
                        "Ther's no Articles",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

}