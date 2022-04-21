import 'package:flutter/material.dart';
import 'package:news_feed/models/model/news_model.dart';
import 'package:news_feed/view/style/style.dart';

class ArticleTileDesc extends StatelessWidget {
  final Article article;

  ArticleTileDesc({required this.article});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          article.title ?? "",
          style: textTheme.subtitle1?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          article.publishedAt ?? "",
          style: textTheme.overline?.copyWith(fontStyle: FontStyle.italic),
        ),
        Text(
          article.description ?? "",
          style: textTheme.bodyText1?.copyWith(fontFamily: RegularFont),
        ),
      ],
    );
  }
}
