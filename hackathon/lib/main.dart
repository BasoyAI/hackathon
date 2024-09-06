import 'package:flutter/material.dart';
import 'package:hackathon/pages/main_page.dart';
import 'package:hackathon/pages/page_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static String text =
      "Kamu bîmârına cânân deva-yı derd eder ihsan\n Niçün kılmaz bana derman beni bîmar sanmaz mı";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PageViewExample(),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      body: PageViewExample(),
    ),
  );
}

class WordDoubleTap extends StatefulWidget {
  @override
  _WordDoubleTapState createState() => _WordDoubleTapState();
}

class _WordDoubleTapState extends State<WordDoubleTap> {
  TextEditingController _textFieldController = TextEditingController();
  TextEditingController _selectedWordController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  // This will hold the currently selected word's TextSelection
  TextSelection? _selection;

  @override
  void initState() {
    super.initState();
    _textFieldController.text = "This is an example text for double-ta";
  }

  void _handleDoubleTap(TapDownDetails details) {
    final text = _textFieldController.text;

    // Get the position of the tap
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.globalToLocal(details.globalPosition);

    // Calculate which word was tapped using TextPainter
    final wordData = _getTappedWord(text, position);

    if (wordData != null) {
      setState(() {
        _selection = wordData['selection'] as TextSelection;
        _selectedWordController.text = wordData['word'] as String;
      });

      // Highlight the selected word in the text field
      _textFieldController.selection = _selection!;
    }
  }

  Map<String, dynamic>? _getTappedWord(String text, Offset position) {
    final textStyle = TextStyle(fontSize: 16.0);
    final span = TextSpan(text: text, style: textStyle);

    TextPainter textPainter = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
      maxLines: null,
    );

    // Layout the text to measure it
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    textPainter.layout(minWidth: 0, maxWidth: renderBox.size.width);

    // Calculate tap position in the text
    final offset = textPainter.getPositionForOffset(position);
    int tapIndex = offset.offset;

    // Find word boundaries
    int start = tapIndex;
    int end = tapIndex;

    // Move to the start of the word
    while (start > 0 && text[start - 1] != ' ') {
      start--;
    }
    // Move to the end of the word
    while (end < text.length && text[end] != ' ') {
      end++;
    }

    String selectedWord = text.substring(start, end);

    return {
      'word': selectedWord,
      'selection': TextSelection(baseOffset: start, extentOffset: end),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          GestureDetector(
            onDoubleTapDown: _handleDoubleTap,
            child: TextField(
              controller: _textFieldController,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: 'Double-tap any word...',
              ),
              maxLines: null,
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _selectedWordController,
            decoration: InputDecoration(
              labelText: 'Selected Word',
            ),
            readOnly: true,
          ),
        ],
      ),
    );
  }
}
