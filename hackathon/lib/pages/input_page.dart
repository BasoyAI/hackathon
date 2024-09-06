import 'package:flutter/material.dart';
import 'package:hackathon/main.dart';
import 'package:hackathon/pages/poem_service.dart';
import 'page_controller.dart';

class InputPage extends StatefulWidget {
  final PageController pageController;
  final String poem;

  const InputPage({super.key, required this.pageController, required this.poem});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // Using Scaffold for overall structure
        body: Container(
          color: Color(0xFF14161B),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: FractionalOffset.bottomLeft,
                height: 40,
                // Fixed height for the button container
                color: Color(0xFF14161B),
                // Background color
                child: Container(
                  decoration: ShapeDecoration(
                    color: Color(0xFFDDD9C8), // Background color for the button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // Makes the background round
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Color(0xFF14161B)),
                    onPressed: () {
                      // Use the passed pageController to animate to the first page
                      widget.pageController.animateToPage(
                        0, // Go to the first page (index 0)
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                ),
              ),
              // Top content
              Expanded(
                child: SingleChildScrollView(
                  // Enables scrolling for the main content
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 342,
                          child: Text(
                            MyApp.text,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 19,
                              fontFamily: 'Abhaya Libre ExtraBold',
                              fontWeight: FontWeight.w800,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Bottom Navigation Bar with buttons
              Container(
                height: 88, // Fixed height for the button container
                color: Color(0xFF14161B), // Background color
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Backward button with background color
                    Container(
                      decoration: ShapeDecoration(
                        color: Color(
                            0xFFDDD9C8), // Background color for the button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // Makes the background round
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Color(0xFF14161B)),
                        onPressed: () {
                          // Add your back button logic here
                        },
                      ),
                    ),
                    // Text in the middle
                    Text(
                      '6 from 1049',
                      style: TextStyle(
                        color: Color(0xFFDDD9C8),
                        fontSize: 16,
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                    // Forward button with background color
                    Container(
                      decoration: ShapeDecoration(
                        color: Color(
                            0xFFDDD9C8), // Background color for the button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // Makes the background round
                      ),
                      child: IconButton(
                        icon:
                            Icon(Icons.arrow_forward, color: Color(0xFF14161B)),
                        onPressed: () {
                          // Add your forward button logic here
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
}
