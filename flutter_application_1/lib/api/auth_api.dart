import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/userL.dart'; // UserL 클래스 import

class AuthAPI {
  final String baseUrl = 'http://10.0.2.2:8001';

  // 회원가입 메서드
  Future<void> registerUser(User user) async {
    final requestBody = jsonEncode(user.toJson());
    print("Register request body (JSON format): $requestBody"); // JSON 요청 본문 출력

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: requestBody,
      );

      print("Register response status: ${response.statusCode}");
      print("Raw register response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("회원가입 성공: ${data['message']}");
      } else {
        final errorData = jsonDecode(response.body);
        print("회원가입 실패: ${errorData['message']}");
      }
    } catch (e) {
      print("회원가입 요청 오류: $e");
    }
  }

  // 로그인 메서드
  Future<void> loginUser(UserL user) async {
    final requestBody = jsonEncode({
      'user_id': user.userId,
      'password': user.password,
    });
    print("Login request body (JSON format): $requestBody"); // 로그인 JSON 데이터 출력

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: requestBody,
      );

      print("Login response status: ${response.statusCode}");
      print("Raw login response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("로그인 성공: ${data['message']}");
      } else {
        final errorData = jsonDecode(response.body);
        print("로그인 실패: ${errorData['message']}");
      }
    } catch (e) {
      print("로그인 요청 오류: $e");
    }
  }
}
