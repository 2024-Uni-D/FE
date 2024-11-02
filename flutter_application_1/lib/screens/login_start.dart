import 'package:flutter/material.dart';

class LoginStartPageScreen extends StatefulWidget {
  @override
  _LoginStartPageScreenState createState() => _LoginStartPageScreenState();
}

class _LoginStartPageScreenState extends State<LoginStartPageScreen> {
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
                    decoration: InputDecoration(
                      hintText: '아이디를 입력해주세요',
                      hintStyle: TextStyle(
                        color: Color(0xFF868686), // 원하는 색상으로 변경
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
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: '비밀번호를 입력해주세요',
                      hintStyle: TextStyle(
                        color: Color(0xFF868686), // 원하는 색상으로 변경
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
                onPressed: () {
                  // 로그인 버튼 눌렀을 때의 동작 추가
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3254ED), // 버튼 색상 설정
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
