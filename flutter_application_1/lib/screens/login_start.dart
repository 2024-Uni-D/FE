import 'package:flutter/material.dart';
import '../api/auth_api.dart'; // AuthAPI import 추가
import '../models/userL.dart'; // UserL import 추가

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
    } catch (e) {
      print("로그인 실패: $e");
    }
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
                  padding: EdgeInsets.symmetric(horizontal: 153, vertical: 15),
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
