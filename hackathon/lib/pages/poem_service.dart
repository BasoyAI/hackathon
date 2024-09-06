import "package:hackathon/api/t3aile.dart";

class PoemService {
  int? wordCount;
  String? poet;
  String? poemName;
  String? century;
  String? monarch;
  String? etymology;
  String? sentimentAnalysis;
  List<Map<String, String>> chatHistory = [];

  PoemService();

  Future<void> init(String text) async {
    wordCount = getWordCount(text);
    print("TEST" + wordCount.toString());

    Map<String, dynamic> poetNameData = await getPoetNameJSON(text);
    poet = poetNameData['choices'][0]['text'];

    Map<String, dynamic> poemNameData = await getPoemNameJSON(text);
    poemName = poemNameData['choices'][0]['text'];

    Map<String, dynamic> centuryData = await getCenturyJSON(text);
    century = centuryData['choices'][0]['text'];

    Map<String, dynamic> monarchData = await getMonarchJSON(text);
    monarch = monarchData['choices'][0]['text'];

    Map<String, dynamic> etymologyData = await getEtymology(text);
    etymology = etymologyData['choices'][0]['text'];

    Map<String, dynamic> sentimentAnalysisData = await getSentimentAnalysis(text);
    sentimentAnalysis = etymologyData['choices'][0]['text'];
  }

  int getWordCount(String text) {
    List<String> words = text.split(' ');
    words = words.where((word) => word.isNotEmpty).toList();
    print("tostr" + words.length.toString());
    print("tostr2" + wordCount.toString());
    return words.length;
  }

  Future<Map<String, dynamic>> getPoetNameJSON(String text) async {
    var json_data = [
      {
        "role": "system",
        "content":
            "Sen bir divan şiiri uzmanısın. Kullanıcı sana şiirin bir kısmını verecek ve sen bu şairin adını söyleyeceksin."
      },
      {"role": "user", "content": text},
    ];

    final response = await ModelT3AIle.sendRequest(json_data);
    String poetName = response['choices'][0]['text'];
    print("AI'den Gelen Yanıt 1: $poetName");
    return response;
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

    final response = await ModelT3AIle.sendRequest(json_data);
    String poemName = response['choices'][0]['text'];
    print("AI'den Gelen Yanıt 1: $poemName");
    return response;
  }

  Future<Map<String, dynamic>> getCenturyJSON(String text) async {
    var json_data = [
      {
        "role": "system",
        "content":
            "Sen bir tarih uzmanısın. Sana verilen şiirin hangi yüzyılda yazıldığını söyleyeceksin.",
      },
      {"role": "user", "content": text},
    ];

    final response = await ModelT3AIle.sendRequest(json_data);
    String century = response['choices'][0]['text'];
    print("AI'den Gelen Yanıt 2 : $century");
    return response;
  }

  Future<Map<String, dynamic>> getMonarchJSON(String text) async {
    var json_data = [
      {
        "role": "system",
        "content":
            "Sen bir tarih uzmanısın. Sana verilen şiirin hangi padişah döneminde yazıldığını söyleyeceksin.",
      },
      {"role": "user", "content": text},
    ];

    final response = await ModelT3AIle.sendRequest(json_data);
    String monarchName = response['choices'][0]['text'];
    print("AI'den Gelen Yanıt 2 : $monarchName");
    return response;
  }

  // selected text !!
  Future<Map<String, dynamic>> getEtymology(String selectedText) async {
    var json_data = [
      {
        "role": "system",
        "content":
            "Sen bir dil bilimcisin. Sana verilen herhangi bir kelimenin etimolojik incelemesini yapacaksın.",
      },
      {"role": "user", "content": selectedText},
    ];

    final response = await ModelT3AIle.sendRequest(json_data);
    String EtymologyName = response['choices'][0]['text'];
    print("AI'den Gelen Yanıt 3 : $EtymologyName");
    return response;
  }

  // selected text !!
  Future<Map<String, dynamic>> getSentimentAnalysis(String selectedText) async {
    var json_data = [
      {
        "role": "system",
        "content":
        "Sen divan edebiyatında uzman bir şiir yorumcususun. Sana verilen herhangi bir beyitin anlamsal analizini yap.",
      },
      {"role": "user", "content": selectedText},
    ];

    final response = await ModelT3AIle.sendRequest(json_data);
    String EtymologyName = response['choices'][0]['text'];
    print("AI'den Gelen Yanıt 4 : $EtymologyName");
    return response;
  }
}
