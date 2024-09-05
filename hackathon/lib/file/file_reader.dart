import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:xml/xml.dart' as xml;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter File Text Extraction',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'File Text Extraction Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = false;

  void _extractText() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Let the user pick a file from their device
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'pdf',
          'docx',
          'txt'
        ], // Allow PDF, DOCX, and TXT files
      );

      if (result != null) {
        // Get the file and normalize the file path using URI encoding
        String originalFilePath = result.files.single.path!;
        String normalizedPath =
            Uri.encodeFull(originalFilePath); // Normalize the path

        File file = File(normalizedPath);
        print(
            "File selected: $normalizedPath"); // Show normalized file path in console
        String filePath = file.path;
        String extension = filePath.split('.').last;

        print("File extension: $extension"); // Show file extension in console

        String text = "";

        if (extension == 'pdf') {
          // Handle PDF file
          try {
            print("Processing PDF file");
            PdfDocument document =
                PdfDocument(inputBytes: await file.readAsBytes());
            PdfTextExtractor extractor = PdfTextExtractor(document);
            text = extractor.extractText();
            print("Extracted text from PDF: $text");
          } catch (e) {
            text = 'Failed to extract text from PDF: $e';
            print(text);
          }
        } else if (extension == 'txt') {
          // Handle TXT file
          try {
            print("Processing TXT file");
            text = await file.readAsString(
                encoding: utf8); // Ensure UTF-8 encoding
            print("Extracted text from TXT: $text");
          } catch (e) {
            text = 'Failed to read text from TXT file: $e';
            print(text);
          }
        } else if (extension == 'docx') {
          // Handle DOCX file as a zip archive
          print("Processing DOCX file");
          text = await _extractDocxText(file);
          print("Extracted text from DOCX: $text");
        } else {
          // Unsupported file type
          text = 'Unsupported file type: $extension';
          print(text);
        }

        _showResult(context, text);
      } else {
        // User canceled the picker
        print("No file selected");
        _showResult(context, 'No file selected.');
      }
    } catch (e) {
      print("Error during file selection: $e");
      _showResult(context, 'Error during file selection: $e');
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<String> _extractDocxText(File file) async {
    String docxText = '';
    try {
      print('Attempting to extract DOCX from: ${file.path}');
      final input = InputFileStream(file.path);
      final archive = ZipDecoder().decodeBuffer(input);

      for (var file in archive) {
        print("Archive file found: ${file.name}"); // Show file names in archive
        if (file.name == 'word/document.xml') {
          final content = file.content as List<int>;
          final xmlString = utf8.decode(content);
          docxText = _extractTextFromDocxXml(xmlString);
          break;
        }
      }
    } catch (e) {
      docxText = 'Error extracting text from DOCX file: $e';
      print(docxText);
    }
    return docxText;
  }

  String _extractTextFromDocxXml(String xmlString) {
    print("Extracting text from DOCX XML content");
    final document = xml.XmlDocument.parse(xmlString);
    return document.findAllElements('w:t').map((node) => node.text).join(' ');
  }

  void _showResult(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Extracted text'),
          content: Scrollbar(
            child: SingleChildScrollView(
              child: Text(text),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_isLoading) CircularProgressIndicator(),
            if (!_isLoading)
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: _extractText,
                child: const Text('Select File and Extract Text'),
              ),
          ],
        ),
      ),
    );
  }
}
