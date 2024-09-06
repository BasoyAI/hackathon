import 'package:flutter/material.dart';

class PoemDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 400,
        height: 800,
        color: Color(0xFF14161B),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header container
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: ShapeDecoration(
                      color: Color(0xFFDFD8C8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    // Using the custom widget function with fixed width
                    buildInfoCard('Kelime Sayısı', '283', 300),
                    const SizedBox(height: 8),
                    buildInfoCard('Şair', 'Fuzuli', 300),
                    const SizedBox(height: 8),
                    buildInfoCard('Şiir İsmi', 'Vefa Her Kimseden Kim İstedim Ondan Cefa Gördüm', 300),
                    const SizedBox(height: 8),
                    buildInfoCard('Yazıldığı Yüzyıl', 'yy', 300),
                    const SizedBox(height: 8),
                    buildInfoCard('Hangi Padişah Döneminde', 'II. Selim', 300),
                    const SizedBox(height: 8),
                    buildInfoCard('Etimolojik İnceleme', 'Lütfen Kelime Seçiniz', 300),
                  ],
                ),
              ),
            ),
            // Bottom container
            Container(
              width: 390,
              height: 24,
              padding: const EdgeInsets.symmetric(horizontal: 131),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 128,
                    height: 4,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
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

  // Refactored widget function with fixed width parameter
  Widget buildInfoCard(String header, String answer, double width) {
    return SizedBox(
      width: width,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: ShapeDecoration(
          color: Color(0xFF14161B),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0xFF313843)),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              header,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'AbhayaLibre',
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Opacity(
              opacity: 0.60,
              child: Text(
                answer,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'AbhayaLibre',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
