import 'package:flutter/material.dart';

class AnalysePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: 400,
          height: 844,
          color: Color(0xFF14161B),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: FractionalOffset.bottomLeft,
                height: 40, // Sabit yükseklik
                color: Color(0xFF14161B), // Arkaplan rengi
                child: Container(
                  decoration: ShapeDecoration(
                    color: Color(0xFFDDD9C8), // Butonun arka plan rengi
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Color(0xFF14161B)),
                    onPressed: () {
                      // Geri tuşu işlemleri burada olacak
                    },
                  ),
                ),
              ),
              SizedBox(height: 20), // Back button ile analiz kutusu arasına boşluk ekliyoruz
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildAnalizContainer('ANALİZ 1 - The Dursleys had a small son called Dudley and in their opinion there was no finer boy anywhere.'),
                      SizedBox(height: 8),
                      _buildAnalizContainer('ANALİZ 2 - The Dursleys had a small son called Dudley and in their opinion there was no finer boy anywhere.'),
                      SizedBox(height: 8),
                      _buildAnalizContainer('ANALİZ 3 - The Dursleys had a small son called Dudley and in their opinion there was no finer boy anywhere.'),
                      SizedBox(height: 8),
                      _buildAnalizContainer('ANALİZ 4 - The Dursleys had a small son called Dudley and in their opinion there was no finer boy anywhere.'),
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
