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
  }

  void getWordCount(String text) {
    List<String> words = text.split(' ');
    words = words.where((word) => word.isNotEmpty).toList();
    wordCount = words.length;
  }

  Future<Map<String, dynamic>> getLLMResponse() async {

    final response = await ModelT3AIle.sendRequest(chatHistory);
    String resContent = response['choices'][0]['text'];
    chatHistory.add({"role": "assistant", "content": resContent});
    return response;
  }

  Future<Map<String, dynamic>> getPoetSemanticAnalysis(String text) async {
    chatHistory = [
      {
        "role": "system",
        "content":
        "Sen bir divan şiiri uzmanısın. Kullanıcı sana şiirin bir kısmını verecek ve sen bu şiirin ne anlattını açıklayacaksın."
      },
      {"role": "user", "content": text},
    ];

    final response = await ModelT3AIle.sendRequest(chatHistory);
    String resContent = response['choices'][0]['text'];
    chatHistory.add({"role": "assistant", "content": resContent});
    return response;
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
            "Sen bir divan şiiri uzmanı sın. Kullanıcı sana şiirin bir kısmını verecek ve sen bu şiirin adını söyleyeceksin."
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


  Future<void> loadAllData(String text, {int maxRetries = 3}) async {
    // Şair adını yüklemeye çalış
    await _loadDataWithRetry(
      () async {
        Map<String, dynamic> poetNameData = await getPoetNameJSON(text);
        poet = poetNameData['choices'][0]['text'];
      },
      "Şair adını yükleme",
      maxRetries,
    );

    await _loadDataWithRetry(
          () async {
        Map<String, dynamic> poemAnalysisData = await getPoetSemanticAnalysis(text);
      },
      "Analiz",
      maxRetries,
    );

    // Şiir adını yüklemeye çalış
    await _loadDataWithRetry(
      () async {
        Map<String, dynamic> poemNameData = await getPoemNameJSON(text);
        poemName = poemNameData['choices'][0]['text'];
      },
      "Şiir adını yükleme",
      maxRetries,
    );

    // Yüzyıl verisini yüklemeye çalış
    await _loadDataWithRetry(
      () async {
        Map<String, dynamic> centuryData = await getCenturyJSON(text);
        century = centuryData['choices'][0]['text'];
      },
      "Yüzyıl verisini yükleme",
      maxRetries,
    );

    // Padişah adını yüklemeye çalış
    await _loadDataWithRetry(
      () async {
        Map<String, dynamic> monarchData = await getMonarchJSON(text);
        monarch = monarchData['choices'][0]['text'];
      },
      "Padişah adını yükleme",
      maxRetries,
    );

    // Etimoloji verisini yüklemeye çalış
    await _loadDataWithRetry(
      () async {
        Map<String, dynamic> etymologyData = await getEtymology(text);
        etymology = etymologyData['choices'][0]['text'];
      },
      "Etimoloji verisini yükleme",
      maxRetries,
    );
  }

  // Genel yükleme fonksiyonu. Her bir veri yükleme fonksiyonunu sarar ve hataları yeniden dener
  Future<void> _loadDataWithRetry(
    Future<void> Function() loadDataFunction,
    String functionName,
    int maxRetries,
  ) async {
    int retryCount = 0;
    bool success = false;

    while (retryCount < maxRetries && !success) {
      try {
        await loadDataFunction(); // Veriyi yükle
        success = true; // Eğer başarılı olduysa döngüyü bitir
      } catch (e) {
        retryCount++;
        print(
            "$functionName sırasında hata oluştu: $e. Yeniden deneme: $retryCount");

        // Yeniden deneme süresi
        if (retryCount < maxRetries) {
          await Future.delayed(Duration(seconds: 2));
        } else {
          print(
              "$functionName yüklenemedi. Maksimum yeniden deneme sayısına ulaşıldı.");
        }
      }
    }
  }
}
