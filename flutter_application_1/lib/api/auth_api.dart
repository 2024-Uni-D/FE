import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/userL.dart'; // UserL 클래스 import

class AuthAPI {
  final String baseUrl = 'http://10.0.2.2:8001';

  // 회원가입 메서드
  Future<void> registerUser(User user) async {
    final requestBody = jsonEncode(user.toJson());
    print("Register request body (JSON format): $requestBody");

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
    print("Login request body (JSON format): $requestBody");

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

// 사용자 조회 메서드
Future<String?> retrieveUser(int id) async {
  final requestBody = jsonEncode({'id': id});
  print("Retrieve request body (JSON format): $requestBody");

  try {
    final response = await http.post(
      Uri.parse('$baseUrl/user/retrieve'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
      body: requestBody,
    );

    print("Retrieve response status: ${response.statusCode}");
    print("Raw retrieve response body: ${response.body}");

    if (response.statusCode == 200) {
      // UTF-8로 디코딩하여 JSON 데이터로 변환
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      final name = data['name'];
      print("User 조회 성공: name = $name");
      return name;
    } else if (response.statusCode == 404) {
      print("User 조회 실패: 사용자 정보 없음");
      return null;
    } else {
      print("User 조회 실패: ${response.body}");
      return null;
    }
  } catch (e) {
    print("User 조회 요청 오류: $e");
    return null;
  }
}

}
