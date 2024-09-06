import 'package:flutter/material.dart';
import 'package:hackathon/pages/analyse_page.dart';
import 'package:hackathon/pages/input_page.dart';
import 'package:hackathon/pages/poem_detail.dart';

class PageViewExample extends StatefulWidget {
  @override
  _PageViewExampleState createState() => _PageViewExampleState();
}

class _PageViewExampleState extends State<PageViewExample> {
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          AnalysePage(),
          InputPage(pageController: _pageController, poem: '',),
          PoemDetail(),
        ],
      ),
    );
  }
}
