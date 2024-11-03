import 'dart:convert';
import 'package:http/http.dart' as http;

class AnswerAPI {
  final String baseUrl = 'http://10.0.2.2:8001';

  // 답변 업데이트 메서드
  Future<String?> updateAnswer(int userId, int order, String answer, String todayDate) async {
    final requestBody = jsonEncode({'id': userId, 'order': order, 'answer': answer, 'today': todayDate});
    print("Request body for updateAnswer: $requestBody");

    try {
      final response = await http.put(
        Uri.parse('$baseUrl/questions/answer'),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Answer updated: $data");
        return data['response'];  // 서버 응답을 화면에 표시하기 위해 반환
      } else {
        print("Failed to update answer: ${response.statusCode}");
      }
    } catch (e) {
      print("Error updating answer: $e");
    }
    return null;
  }
}
