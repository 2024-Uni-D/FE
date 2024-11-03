import 'dart:convert';
import 'package:http/http.dart' as http;

class QuestionAPI {
  final String baseUrl = 'http://10.0.2.2:8001';

  // 질문 생성 및 첫 질문 가져오기 메서드
  Future<Map<String, dynamic>?> createQuestion(int userId, String todayDate) async {
    final requestBody = jsonEncode({'id': userId, 'today': todayDate});
    print("Request body for createQuestion: $requestBody");

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/questions/generate'),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Question created: $data");
        return data;
      } else {
        print("Failed to create question: ${response.statusCode}");
      }
    } catch (e) {
      print("Error creating question: $e");
    }
    return null;
  }
}
