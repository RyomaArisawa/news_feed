import 'package:flutter/material.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/models/model/news_model.dart';
import 'package:news_feed/view/components/head_line_item.dart';
import 'package:news_feed/view/components/page_transformer.dart';
import 'package:news_feed/viewmodels/head_line_viewmodel.dart';
import 'package:provider/provider.dart';

class HeadLinePage extends StatelessWidget {
  const HeadLinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HeadLineViewModel>();

    if (!viewModel.isLoading && viewModel.articles.isEmpty) {
      Future(() => viewModel.getHeadLines(searchType: SearchType.HEAD_LINE));
    }

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<HeadLineViewModel>(
            builder: (context, model, child) {
              if (model.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return PageTransformer(
                    pageViewBuilder: (context, pageVisibilityResolver) {
                  return PageView.builder(
                    controller: PageController(viewportFraction: 0.9),
                    itemCount: model.articles.length,
                    itemBuilder: (context, index) {
                      final article = model.articles[index];
                      final pageVisibility =
                          pageVisibilityResolver.resolvePageVisibility(index);
                      final visibleFraction = pageVisibility.visibleFraction;
                      return Opacity(
                        opacity: visibleFraction,
                        child: Container(
                          child: HeadLineItem(
                            article: article,
                            pageVisibility: pageVisibility,
                            onArticleClicked: (article) =>
                                _openArticleWebPage(context, article),
                          ),
                        ),
                      );
                    },
                  );
                });
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.refresh),
          onPressed: () => onRefresh(context),
        ),
      ),
    );
  }

  onRefresh(BuildContext context) async {
    final viewModel = context.read<HeadLineViewModel>();
    await viewModel.getHeadLines(searchType: SearchType.HEAD_LINE);
  }

  _openArticleWebPage(BuildContext context, Article article) {
    print("${article.url}");
  }
}
