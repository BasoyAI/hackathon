import 'dart:convert';
import 'package:http/http.dart' as http;

class ModelT3AIle {
  static final String url = "https://inference2.t3ai.org/v1/completions";

  static String convertToSpecialFormat(List<Map<String, dynamic>> jsonData) {
    String output = "<|begin_of_text|>";
    for (var entry in jsonData) {
      if (entry["role"] == "system") {
        output +=
            '<|start_header_id|>system<|end_header_id|>\n\n${entry["content"]}<|eot_id|>';
      } else if (entry["role"] == "user") {
        output +=
            '\n<|start_header_id|>${entry["role"]}<|end_header_id|>\n\n${entry["content"]}<|eot_id|>';
      } else if (entry["role"] == "assistant") {
        output +=
            '\n<|start_header_id|>${entry["role"]}<|end_header_id|>\n\n${entry["content"]}<|eot_id|>';
      }
    }
    output += "\n<|start_header_id|>assistant<|end_header_id|>";
    return output;
  }

  static Future<Map<String, dynamic>> sendRequest(
      List<Map<String, dynamic>> jsonData) async {
    String specialFormatOutput = convertToSpecialFormat(jsonData);

    Map<String, dynamic> payload = {
      "model": "/home/ubuntu/hackathon_model_2/",
      "prompt": specialFormatOutput,
      "temperature": 0.01,
      "top_p": 0.95,
      "max_tokens": 1024,
      "repetition_penalty": 1.1,
      "stop_token_ids": [128001, 128009],
      "skip_special_tokens": true
    };

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      var decodedResponse = utf8.decode(response.bodyBytes);
      return jsonDecode(decodedResponse);
    } else {
      throw Exception('Failed to load response');
    }
  }
}
