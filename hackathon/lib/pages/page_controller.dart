import 'package:flutter/material.dart';
import 'package:hackathon/pages/FirstPage.dart';
import 'package:hackathon/pages/SecondPage.dart';
import 'package:hackathon/pages/ThirdPage.dart';

class PageViewExample extends StatefulWidget {
  @override
  _PageViewExampleState createState() => _PageViewExampleState();
}

class _PageViewExampleState extends State<PageViewExample> {
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PageView with Stateful Widgets'),
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          FirstPage(),
          SecondPage(),
          ThirdPage(),
        ],
      ),
    );
  }
}
