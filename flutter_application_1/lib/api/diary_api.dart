import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/diary.dart';

class DiaryAPI {
  final String baseUrl = 'http://10.0.2.2:8001';

  // 일기 결과 조회 메서드
  Future<Diary?> getDiaryResult(int id) async {
    // 요청 본문에 id만 포함하여 JSON 형식으로 구성
    final requestBody = jsonEncode({'id': id});
    print("Diary result request body: $requestBody");

    try {
      final response = await http.put(
        Uri.parse('$baseUrl/diary/result'),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: requestBody,
      );

      print("Diary result response status: ${response.statusCode}");
      print("Diary result response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("일기 결과 조회 성공: $data");
        return Diary.fromJson(data);
      } else if (response.statusCode == 422) {
        print("Validation Error: ${response.body}");
      } else {
        print("일기 결과 조회 실패: ${response.body}");
      }
      return null;
    } catch (e) {
      print("일기 결과 조회 요청 오류: $e");
      return null;
    }
  }
}
