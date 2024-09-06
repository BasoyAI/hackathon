import "package:hackathon/api/t3aile.dart";

class PoemService {
  int? wordCount;
  String? poet;
  String? poemName;
  String? century;
  String? monarch;
  String? etymology;

  // Empty constructor
  PoemService();

  // Method to count words in the text
  int getWordCount(String text) {
    List<String> words = text.split(' ');
    words = words.where((word) => word.isNotEmpty).toList();
    return words.length;
  }

  // Method to get the poem name using AI (async method)
  Future<Map<String, dynamic>> getPoemNameJSON(String text) async {
    var json_data = [
      {
        "role": "system",
        "content":
            "Sen bir divan şiiri uzmanısın. Kullanıcı sana şiirin bir kısmını verecek ve sen bu şiirin adını söyleyeceksin."
      },
      {"role": "user", "content": text},
    ];

    // Assuming `t3aIle` is initialized

    final response = await ModelT3AIle.sendRequest(json_data);
    print("AI'den Gelen Yanıt: $response");
    return response;
  }

  // Method to get the monarch period of the poem
  void getMonarch(String text) {
    Map<String, String> divanSystem = {
      "system":
          "Sen bir tarih uzmanısın. Sana verilen şiirin hangi padişah döneminde yazıldığını söyleyeceksin.",
      "question": text
    };

    print("System: ${divanSystem['system']}");
    print("Question: ${divanSystem['question']}");
  }

  // Method to get the etymology of a word
  void getEtymology(String selectedText) {
    Map<String, String> divanSystem = {
      "system":
          "Sen bir dil bilimcisin. Sana verilen herhangi bir kelimenin etimolojik incelemesini yapacaksın.",
      "question": selectedText
    };

    print("System: ${divanSystem['system']}");
    print("Question: ${divanSystem['question']}");
  }
}
