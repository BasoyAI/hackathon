import 'package:flutter/material.dart';

class PoemDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true, // Klavye açıldığında ekran kaydırılabilir olacak
        body: Container(
          width: double.infinity,
          height: 800,
          color: Color(0xFF14161B),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Geri butonu
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
                      Navigator.pop(context); // Geri gitme fonksiyonu
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      buildInfoCard('Kelime Sayısı', '283'),
                      const SizedBox(height: 8),
                      buildInfoCard('Şair', 'Fuzuli'),
                      const SizedBox(height: 8),
                      buildInfoCard('Şiir İsmi', 'Vefa Her Kimseden Kim İstedim Ondan Cefa Gördüm'),
                      const SizedBox(height: 8),
                      buildInfoCard('Yazıldığı Yüzyıl', '16. yy'),
                      const SizedBox(height: 8),
                      buildInfoCard('Hangi Padişah Döneminde', 'II. Selim'),
                      const SizedBox(height: 8),
                      buildInfoCard('Etimolojik İnceleme', 'Lütfen Kelime Seçiniz'),
                    ],
                  ),
                ),
              ),
              // Bottom container kaldırıldı
            ],
          ),
        ),
      ),
    );
  }

  // Refactored widget function with infinity width
  Widget buildInfoCard(String header, String answer) {
    return Container(
      width: double.infinity,
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
    );
  }
}
