import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final ValueChanged onSearch;
  final TextEditingController _textEditingController = TextEditingController();

  SearchBar({required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          onSubmitted: onSearch,
          maxLines: 1,
          controller: _textEditingController,
          decoration: const InputDecoration(
            icon: Icon(Icons.search),
            hintText: "検索ワードを入れてください",
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
