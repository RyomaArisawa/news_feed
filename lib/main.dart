import 'package:flutter/material.dart';
import 'package:news_feed/view/screens/home_screen.dart';
import 'package:news_feed/view/style/style.dart';
import 'package:news_feed/viewmodels/head_line_viewmodel.dart';
import 'package:news_feed/viewmodels/news_list_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<NewsListViewModel>(
          create: (_) => NewsListViewModel(),
        ),
        ChangeNotifierProvider<HeadLineViewModel>(
          create: (_) => HeadLineViewModel(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NewsFeed',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: BoldFont,
      ),
      home: HomeScreen(),
    );
  }
}
