import 'package:flutter/material.dart';
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/view/components/article_tile.dart';
import 'package:news_feed/view/components/category_chips.dart';
import 'package:news_feed/view/components/search_bar.dart';
import 'package:news_feed/viewmodels/news_list_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../models/model/news_model.dart';

class NewsListPage extends StatelessWidget {
  const NewsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<NewsListViewModel>();

    if (!viewModel.isLoading && viewModel.articles.isEmpty) {
      Future(() => viewModel.getNews(
          searchType: SearchType.CATEGORY, category: categories[0]));
    }

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.refresh),
          tooltip: "更新",
          onPressed: () => onRefresh(context),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              //TODO 検索ワード
              SearchBar(
                onSearch: (keyword) => getKeyWordNews(context, keyword),
              ),
              //TODO カテゴリー検索
              CategoryChips(
                onCategorySelected: (category) =>
                    getCategoryNews(context, category),
              ),
              //TODO　記事表示
              Expanded(
                child: Consumer<NewsListViewModel>(
                  builder: (context, model, child) {
                    return model.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: model.articles.length,
                            itemBuilder: (context, int position) => ArticleTile(
                              article: model.articles[position],
                              onArticleClicked: (article) =>
                                  _openArticleWebPage(article, context),
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //TODO 更新処理
  onRefresh(BuildContext context) async {
    final viewModel = context.read<NewsListViewModel>();
    await viewModel.getNews(
        searchType: viewModel.searchType,
        keyword: viewModel.keyword,
        category: viewModel.category);
  }

  getKeyWordNews(BuildContext context, String keyword) async {
    final viewModel = context.read<NewsListViewModel>();
    await viewModel.getNews(searchType: SearchType.KEYWORD, keyword: keyword);
  }

  getCategoryNews(BuildContext context, Category category) async {
    final viewModel = context.read<NewsListViewModel>();
    await viewModel.getNews(
        searchType: SearchType.CATEGORY, category: category);
  }

  _openArticleWebPage(Article article, BuildContext context) {
    print("_openArticleWebPage: ${article.url}");
  }
}
