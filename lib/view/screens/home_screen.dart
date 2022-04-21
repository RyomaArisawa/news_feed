import 'package:flutter/material.dart';
import 'package:news_feed/view/screens/pages/about_us_page.dart';
import 'package:news_feed/view/screens/pages/head_line_page.dart';
import 'package:news_feed/view/screens/pages/news_list_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final _pages = [
    HeadLinePage(),
    NewsListPage(),
    AboutUsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.highlight),
            label: "トップニュース",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "ニュース一覧",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "このアプリについて",
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
