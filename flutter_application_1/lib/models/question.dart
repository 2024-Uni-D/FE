// lib/api/question_api.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/question.dart';

class QuestionAPI {
  final String baseUrl = 'http://10.0.2.2:8001';

  // 일기 생성 및 질문 추가 메서드
  Future<Map<String, dynamic>?> createDiaryAndQuestion(int userId) async {
    final todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final requestBody = jsonEncode({
      'id': userId,
      'today': todayDate,
    });

    final response = await http.post(
      Uri.parse('$baseUrl/questions/generate'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
      body: requestBody,
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      print('Failed to create diary and question');
      return null;
    }
  }

  // 질문 답변 업데이트 메서드
  Future<bool> updateAnswer(int userId, int order, String answer, String date) async {
    final requestBody = jsonEncode({
      'id': userId,
      'order': order,
      'answer': answer,
      'date': date,
    });

    final response = await http.put(
      Uri.parse('$baseUrl/diary/update_answer'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
      body: requestBody,
    );

    return response.statusCode == 200;
  }
}
