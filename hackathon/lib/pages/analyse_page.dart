import 'package:flutter/material.dart';

class AnalysePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 400,
        height: 844,
        color: Color(0xFF14161B),
        child: Column(
          mainAxisSize: MainAxisSize.max, // Allow it to take up full height
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: 30,
              height: 30,
              margin: EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color:
                Color(0xFFDDD9C8), // Background color for the button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                // Makes the background round
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back, size: 15, color: Color(0xFF14161B)),
                onPressed: () {
                  // Add your forward button logic here
                },
              ),
            ),
            Expanded( // Ensure the column takes up available space
              child: SingleChildScrollView( // Allow scrolling for long content
                child: Column(
                  children: [
                    _buildAnalizContainer('ANALİZ 1 -  The Dursleys had a small son called Dudley and in their opinion there was no finer boy anywhere.'),
                    SizedBox(height: 8),
                    _buildAnalizContainer('ANALİZ 2 -  The Dursleys had a small son called Dudley and in their opinion there was no finer boy anywhere.'),
                    SizedBox(height: 8),
                    _buildAnalizContainer('ANALİZ 3 -  The Dursleys had a small son called Dudley and in their opinion there was no finer boy anywhere.'),
                    SizedBox(height: 8),
                    _buildAnalizContainer('ANALİZ 4 -  The Dursleys had a small son called Dudley and in their opinion there was no finer boy anywhere.'),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 88,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 360,
                    height: 56,
                    decoration: ShapeDecoration(
                      color: Color(0xFFDFD8C8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Konuşma başlatmak için tıklayınız',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.46),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalizContainer(String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: Color(0xFF21252F),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFF313843)),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'AbhayaLibre',
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
