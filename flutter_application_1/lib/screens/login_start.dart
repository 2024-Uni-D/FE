import 'package:flutter/material.dart';
import '../api/auth_api.dart'; // AuthAPI import 추가
import '../models/userL.dart'; // UserL import 추가
import '../screens/join_start.dart'; // join_start 화면 import 추가
import '../screens/Q1.dart'; // Q1 화면 import 추가

class LoginStartPageScreen extends StatefulWidget {
  @override
  _LoginStartPageScreenState createState() => _LoginStartPageScreenState();
}

class _LoginStartPageScreenState extends State<LoginStartPageScreen> {
  final AuthAPI authAPI = AuthAPI();

  // 각 입력 필드를 위한 컨트롤러
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // 컨트롤러 해제
    userIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _loginUser() async {
    // UserL 객체 생성
    final user = UserL(
      userId: userIdController.text,
      password: passwordController.text,
    );

    // 로그인 요청 실행
    try {
      await authAPI.loginUser(user);
      print("로그인 성공!");

      // 로그인 성공 시 Q1 페이지로 이동
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Q1Screen()), // Q1Screen으로 네비게이션
      );
    } catch (e) {
      print("로그인 실패: $e");
      // 로그인 실패 시 오류 메시지를 보여줄 수도 있음
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("로그인 실패"),
          content: Text("아이디 또는 비밀번호를 확인하세요."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("확인"),
            ),
          ],
        ),
      );
    }
  }

  void _navigateToJoinScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              JoinStartPageScreen()), // JoinStartScreen으로 네비게이션
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'LOGO',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '아이디',
                    style: TextStyle(color: Color(0xFF868686)),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: userIdController,
                    decoration: InputDecoration(
                      hintText: '아이디를 입력해주세요',
                      hintStyle: TextStyle(
                        color: Color(0xFF868686),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '비밀번호',
                    style: TextStyle(color: Color(0xFF868686)),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: '비밀번호를 입력해주세요',
                      hintStyle: TextStyle(
                        color: Color(0xFF868686),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: _loginUser, // 로그인 버튼 클릭 시 _loginUser 호출
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3254ED),
                  padding: EdgeInsets.symmetric(horizontal: 150, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  '로그인',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _navigateToJoinScreen, // 회원가입 버튼 클릭 시 화면 전환 함수 호출
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3254ED),
                  padding: EdgeInsets.symmetric(horizontal: 145, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  '회원가입',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginStartPageScreen(),
  ));
}
