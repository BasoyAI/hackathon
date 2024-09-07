import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/main.dart';
import 'package:hackathon/pages/main_page.dart';
import 'package:hackathon/pages/poem_service.dart';
import 'page_controller.dart';

class InputPage extends StatefulWidget {
  final PageController pageController;
  final String poem;

  const InputPage(
      {super.key, required this.pageController, required this.poem});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String? selectedWord; // Store the selected word

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Color(0xFF14161B),
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: FractionalOffset.bottomLeft,
                height: 40,
                color: Color(0xFF14161B),
                child: Container(
                  decoration: ShapeDecoration(
                    color: Color(0xFFDDD9C8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.home, color: Color(0xFF14161B)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StartPage()),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 342,
                          child: _buildRichText(MyApp.text),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Bottom Navigation Bar with buttons
              Container(
                height: 88,
                color: Color(0xFF14161B),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: ShapeDecoration(
                        color: Color(0xFFDDD9C8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Color(0xFF14161B)),
                        onPressed: () {
                          widget.pageController.animateToPage(
                            0,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                      ),
                    ),
                    Text(
                      '6 from 1049',
                      style: TextStyle(
                        color: Color(0xFFDDD9C8),
                        fontSize: 16,
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                    Container(
                      decoration: ShapeDecoration(
                        color: Color(0xFFDDD9C8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: IconButton(
                        icon:
                            Icon(Icons.arrow_forward, color: Color(0xFF14161B)),
                        onPressed: () {
                          widget.pageController.animateToPage(
                            2,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build RichText widget for highlighting and printing clicked words
  Widget _buildRichText(String text) {
    List<String> words = text.split(' ');

    return RichText(
      text: TextSpan(
        children: words.map((word) {
          return TextSpan(
            text: '$word ',
            style: TextStyle(
              color: selectedWord == word
                  ? Colors.yellow
                  : Colors.white.withOpacity(0.7),
              fontSize: 19,
              fontFamily: 'Abhaya Libre ExtraBold',
              fontWeight: FontWeight.w800,
              height: 1.5,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                setState(() async {
                  selectedWord = word;
                  var response = await MyApp.service
                      .getEtymologyForSpecificWord(selectedWord.toString());
                  MyApp.service.etymology = response['choices'][0]['text'];
                });
                print('Clicked word: $word');
              },
          );
        }).toList(),
      ),
    );
  }
}
