import 'dart:convert';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/main.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class AnalysePage extends StatefulWidget {
  @override
  State<AnalysePage> createState() => _AnalysePageState();
}

class _AnalysePageState extends State<AnalysePage> {
  late List<Map<String, String>> analizList = [];
  TextEditingController _textController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  String? selectedWord; // Seçilen kelimeyi saklayacak değişken

  List<bool> likedList = List<bool>.filled(6, false);
  List<bool> dislikedList = List<bool>.filled(6, false);
  List<bool> buttonDisabledList = List<bool>.filled(6, false);

  @override
  void initState() {
    super.initState();
    analizList.addAll(MyApp.service.chatHistory.sublist(2, MyApp.service.chatHistory.length));
  }

  // Dosya yolunu bulma
  Future<String> getFilePath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // JSON verilerini dosyaya yaz (mevcut dosyaya ekleme)
  Future<void> appendToFile(String jsonString) async {
    final path = await getFilePath();
    File file = File('$path/feedbacks.json');

    List<dynamic> feedbackList = [];

    // Dosya zaten varsa, var olan içeriği oku
    if (await file.exists()) {
      String existingContent = await file.readAsString();
      if (existingContent.isNotEmpty) {
        feedbackList = jsonDecode(existingContent);
      }
    }

    // Yeni geri bildirimi mevcut listeye ekle
    feedbackList.add(jsonDecode(jsonString));

    // Güncellenen listeyi dosyaya yaz
    await file.writeAsString(jsonEncode(feedbackList));
    print('Veriler feedbacks.json dosyasına kaydedildi');
  }

  // Geri bildirim JSON olarak kaydet
  Future<void> saveFeedback(int index, String rating, [String feedbackText = '', String preferredResponse = '']) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(now);

    Map<String, dynamic> feedbackData = {
      "interaction_id": "interaction_$index",
      "user_id": "user_001",
      "timestamp": formattedDate,
      "content_generated": {
        "input_prompt": analizList[index]['text'],
        "response": "Sample AI Response"
      },
      "user_feedback": {
        "rating": rating,
        "feedback_text": feedbackText,
        "preferred_response": preferredResponse
      },
      "feedback_metadata": {
        "device": "mobile",
        "session_duration": 45
      }
    };

    String jsonString = jsonEncode(feedbackData);
    await appendToFile(jsonString); // Aynı JSON dosyasına ekle
    print('Geri bildirim kaydedildi: $jsonString');
  }

  // Dislike butonuna basıldığında pop-up göster
  Future<void> handleDislike(int index) async {
    TextEditingController feedbackController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Neden beğenmediniz?"),
          content: TextField(
            controller: feedbackController,
            decoration: InputDecoration(hintText: "Geri bildiriminizi girin"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                saveFeedback(index, "dislike", feedbackController.text, "Daha iyi bir yanıt önerin");
                Navigator.of(context).pop();
              },
              child: Text("Gönder"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          width: 400,
          height: 844,
          color: Color(0xFF14161B),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              // Mesaj Listesi
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: analizList.asMap().entries.map((entry) {
                      int index = entry.key;
                      String role = entry.value['role']!;
                      String text = entry.value['content']!;
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
              // Arama Kutusu
              _buildSearchBox(),
            ],
          ),
        ),
      ),
    );
  }

  // Function to scroll to the bottom
  void _scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500), // Duration of the scroll animation
      curve: Curves.easeOut, // Animation curve
    );
  }

  // Function that waits for 100 ms before triggering the function
  void _triggerWithDelay() {
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollToEnd();
    });
  }

  Widget _buildAnalizContainer(String role, String text, int index) {
    Color containerColor;
    Color textColor;
    Alignment alignment;
    EdgeInsets margin;

    if (role == 'assistant') {
      containerColor = Color(0xFF21252F); // Asistan mesajları rengi
      textColor = Colors.white;
      alignment = Alignment.centerLeft;
      margin = EdgeInsets.only(left: 20, right: 90);
    } else {
      containerColor = Color(0xFFEAD6CA); // Kullanıcı mesajları rengi
      textColor = Colors.black;
      alignment = Alignment.centerRight;
      margin = EdgeInsets.only(left: 160, right: 20);
    }

    // Metni kelimelere böl
    List<String> words = text.split(' ');

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
            padding: const EdgeInsets.only(bottom: 32.0),
            child: RichText(
              text: TextSpan(
                children: words.map((word) {
                  return TextSpan(
                    text: '$word ',
                    style: TextStyle(
                      color: selectedWord == word ? Colors.yellow : textColor, // Seçilen kelimeyi sarı yap
                      fontSize: 18,
                      fontFamily: 'AbhayaLibre',
                      fontWeight: FontWeight.w800,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        setState(() {
                          selectedWord = word; // Seçilen kelimeyi güncelle
                        });
                        print('Seçilen kelime: $word');
                      },
                  );
                }).toList(),
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
                        buttonDisabledList[index] = true;
                        saveFeedback(index, "like");
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
                        buttonDisabledList[index] = true;
                      });
                      handleDislike(index);
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSearchBox() {
    return Container(
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
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Arama Yapmak İçin Tıklayınız',
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: IconButton(
                    onPressed: () async {
                      var message = {"role": "user", "content": _textController.text};
                      analizList.add(message);
                      MyApp.service.chatHistory.add(message);
                      await MyApp.service.getLLMResponse();
                      analizList.add(MyApp.service.chatHistory.last);
                      _triggerWithDelay();
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
