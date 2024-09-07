import 'package:flutter/material.dart';
import 'package:hackathon/pages/page_controller.dart'; // Yönlendirilecek sayfa
import 'package:file_picker/file_picker.dart';
import 'package:hackathon/pages/poem_service.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart'; // PDF işlemek için
import 'dart:io';
import 'package:xml/xml.dart' as xml;
import 'package:archive/archive.dart'; // DOCX desteği için
import 'dart:convert';
import '../main.dart';
import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';

class StartPage extends StatefulWidget {
  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Klavye açıldığında ekran kaydırılabilir olacak
      body: SingleChildScrollView(
        // Ekranın kaydırılabilir olması için eklendi
        child: Container(
          width: 400,
          color: Color(0xFF14161B),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 810,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Ortadaki logo ve başlık kısmı
                    Container(
                      width: 390,
                      height: 454,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 24,
                            top: 361,
                            child: SizedBox(
                              width: 342,
                              child: Text(
                                'BASOY',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontFamily: 'Abhaya Libre ExtraBold',
                                  fontWeight: FontWeight.w800,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 10,
                            top: 25,
                            child: Container(
                              width: 370,
                              height: 370,
                              decoration: ShapeDecoration(
                                color: Color(0x05EB8A53),
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 54,
                            top: 66,
                            child: Container(
                              width: 283,
                              height: 284,
                              decoration: ShapeDecoration(
                                color: Color(0x19E2E2E2),
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 86,
                            top: 98,
                            child: Container(
                              width: 220,
                              height: 220,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/logo.png"),
                                  fit: BoxFit.fill,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Arama çubuğu ve PDF yükleme kısmı
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 160,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Çok satırlı arama çubuğu ve arama butonu
                            Container(
                              width: 360,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxHeight:
                                              40, // Maksimum yükseklik küçültüldü
                                        ),
                                        child: SingleChildScrollView(
                                          child: TextField(
                                            controller: _textController,
                                            textAlign: TextAlign.left,
                                            maxLines: null,
                                            // Sınırsız satır
                                            minLines: 1,
                                            // Minimum 1 satır
                                            keyboardType:
                                                TextInputType.multiline,
                                            // Çok satırlı metin girişi
                                            decoration: InputDecoration(
                                              hintText: 'Şiirinizi yazın',
                                              hintStyle: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.6),
                                                fontSize: 18,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w500,
                                              ),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.search,
                                        color: Colors.black.withOpacity(0.6),
                                      ),
                                      onPressed: () async {
                                        // Loading pop-up'ını göster
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          // Pop-up'ı kullanıcı kapatamasın
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(), // Loading göstergesi
                                              ),
                                            );
                                          },
                                        );
                                        MyApp.text = _textController.text;
                                        PoemService poemService =
                                            new PoemService();
                                        await poemService
                                            .loadAllData(MyApp.text);
                                        poemService.getWordCount(MyApp.text);
                                        MyApp.service = poemService;
                                        // Pop-up'ı kapat
                                        Navigator.pop(context);

                                        // Yeni sayfaya yönlendirme
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PageViewExample(), // Hedef sayfa
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Fuzuli'nin dizesi
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                'Ger derse Fuzûlî ki güzellerde vefâ var Aldanma ki şair sözü elbette yalandır',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF83899F),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // PDF Yükleme butonu
                            GestureDetector(
                              onTap: () async {
                                // Dosya seçimi ve metin çıkarma işlemi
                                String extractedText =
                                    await _pickAndExtractText();

                                if (extractedText.isNotEmpty) {
                                  // Dosya içeriği başarıyla okundu, main.dart'taki text değişkenini güncelliyoruz
                                  MyApp.text = extractedText;

                                  // Sayfayı yönlendirme işlemi
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PageViewExample(), // Yönlendirilmek istenen sayfa
                                    ),
                                  );
                                } else {
                                  // Dosya yükleme başarısız olduysa kullanıcıya hata mesajı gösteriliyor
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Dosya içeriği yüklenemedi!'),
                                  ));
                                }
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: 85, // Yuvarlağın boyutunu büyüttüm
                                    height: 85, // Yuvarlağın boyutunu büyüttüm
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(226, 226, 226, 0.1),
                                      shape: BoxShape.circle, // Yuvarlak şekil
                                    ),
                                    child: ClipOval(
                                      child: Image.asset(
                                        'assets/pdf_gorsel.jpg',
                                        // Yüklediğin PDF ikonu dosyasını burada kullanıyoruz
                                        width: 85,
                                        height: 85,
                                        fit: BoxFit
                                            .cover, // İkonun boyutunu tam olarak yuvarlağa oturtuyoruz
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'PDF Yükle',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF83899F),
                                      fontFamily: 'Abhaya Libre ExtraBold',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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

  // PDF, DOCX ve TXT içeriğini seçip okuyacak olan fonksiyon
  Future<String> _pickAndExtractText() async {
    String extractedText = "";
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'pdf',
          'docx',
          'txt'
        ], // PDF, DOCX ve TXT dosyalarını seçmek için
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        String extension = file.path.split('.').last;

        if (extension == 'pdf') {
          extractedText = await _extractTextFromPdf(file);
        } else if (extension == 'txt') {
          extractedText = await file.readAsString(encoding: utf8);
        } else if (extension == 'docx') {
          extractedText = await _extractTextFromDocx(file);
        }
      }
    } catch (e) {
      print("Hata: $e");
    }

    return extractedText; // İçerik döndürülüyor
  }

  Future<String> _extractTextFromPdf(File file) async {
    try {
      PdfDocument document = PdfDocument(inputBytes: await file.readAsBytes());
      PdfTextExtractor extractor = PdfTextExtractor(document);
      return extractor.extractText();
    } catch (e) {
      return 'PDF dosyasından metin çıkarılamadı: $e';
    }
  }

  Future<String> _extractTextFromDocx(File file) async {
    String docxText = '';
    try {
      final input = InputFileStream(file.path);
      final archive = ZipDecoder().decodeBuffer(input);

      for (var file in archive) {
        if (file.name == 'word/document.xml') {
          final content = file.content as List<int>;
          final xmlString = utf8.decode(content);
          docxText = _extractTextFromDocxXml(xmlString);
          break;
        }
      }
    } catch (e) {
      return 'DOCX dosyasından metin çıkarılamadı: $e';
    }
    return docxText;
  }

  String _extractTextFromDocxXml(String xmlString) {
    final document = xml.XmlDocument.parse(xmlString);
    return document.findAllElements('w:t').map((node) => node.text).join(' ');
  }
}
