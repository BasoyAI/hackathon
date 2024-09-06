import 'package:flutter/material.dart';

class AnalysePage extends StatefulWidget {
  @override
  State<AnalysePage> createState() => _AnalysePageState();
}

class _AnalysePageState extends State<AnalysePage> {
  List<Map<String, String>> analizList = [
    {"role": "assistant", "text": "ANALİZ 1 - The Dursleys had a small son called Dudley and in their opinion there was no finer boy anywhere."},
    {"role": "assistant", "text": "ANALİZ 2 - The Dursleys had a small son called Dudley and in their opinion there was no finer boy anywhere."},
    {"role": "assistant", "text": "ANALİZ 3 - The Dursleys had a small son called Dudley and in their opinion there was no finer boy anywhere."},
    {"role": "assistant", "text": "ANALİZ 4 - The Dursleys had a small son called Dudley and in their opinion there was no finer boy anywhere."},
    {"role": "user", "text": "Thanks for the info you're the best"},
    {"role": "assistant", "text": "ANALİZ 4 The Dursleys had a small son called Du"},
  ];

  // Her mesaj için like ve dislike durumlarını takip eden listeler
  List<bool> likedList = List<bool>.filled(6, false);
  List<bool> dislikedList = List<bool>.filled(6, false);
  List<bool> buttonDisabledList = List<bool>.filled(6, false); // Butonları devre dışı bırakma durumu

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true, // Klavye açıldığında ekran kaydırılabilir olacak
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
                    children: analizList.asMap().entries.map((entry) {
                      int index = entry.key;
                      String role = entry.value['role']!;
                      String text = entry.value['text']!;
                      return Column(
                        children: [
                          _buildAnalizContainer(role, text, index),
                          SizedBox(height: 8),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
              // Arama TextField'ı ekranın en alt kısmında olacak şekilde konumlandırıldı
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
                        color: Color(0xFFEAD6CA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                textAlign: TextAlign.left,  // Text sol hizalı
                                decoration: InputDecoration(
                                  hintText: 'Arama Yapmak İçin Tıklayınız',
                                  hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 18,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Icon(
                              Icons.search,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ],
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

  Widget _buildAnalizContainer(String role, String text, int index) {
    Color containerColor;
    Color textColor;
    Alignment alignment;
    EdgeInsets margin;

    if (role == 'assistant') {
      containerColor = Color(0xFF21252F); // Color for assistant
      textColor = Colors.white;
      alignment = Alignment.centerLeft; // Sola hizalama
      margin = EdgeInsets.only(left: 20, right: 90); // Sağdan boşluk bırak
    } else {
      containerColor = Color(0xFFEAD6CA); // Color for user
      textColor = Colors.black;
      alignment = Alignment.centerRight; // Sağa hizalama
      margin = EdgeInsets.only(left: 160, right: 20); // Kullanıcı mesajlarını tamamen sağa yasla
    }

    return Container(
      alignment: alignment,
      margin: margin,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: containerColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFF313843)),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0), // İkonların yazı ile çakışmaması için boşluk
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontFamily: 'AbhayaLibre',
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          if (role == 'assistant') // Sadece AI mesajlarında ikonları göster
            Positioned(
              bottom: -8,
              right: 0,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.thumb_up_alt_outlined,
                      color: likedList[index] ? Colors.green : Color(0xFFEAD6CA),
                    ),
                    onPressed: buttonDisabledList[index] ? null : () {
                      setState(() {
                        likedList[index] = true;
                        dislikedList[index] = false;
                        buttonDisabledList[index] = true; // Butonlar devre dışı
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.thumb_down_alt_outlined,
                      color: dislikedList[index] ? Colors.red : Color(0xFFEAD6CA),
                    ),
                    onPressed: buttonDisabledList[index] ? null : () {
                      setState(() {
                        dislikedList[index] = true;
                        likedList[index] = false;
                        buttonDisabledList[index] = true; // Butonlar devre dışı
                      });
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
