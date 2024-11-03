import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Q2.dart';

class Q1Screen extends StatefulWidget {
  @override
  _Q1ScreenState createState() => _Q1ScreenState();
}

class _Q1ScreenState extends State<Q1Screen> {
  int? selectedOption;

  Future<void> submitSelection() async {
    if (selectedOption == null) return;

    // API URL을 실제 서버 URL로 변경하세요
    final url = Uri.parse('http://10.0.2.2:8001/prequestion/tts');

    final ttsVersion = (selectedOption ?? 1) - 1;

    // 요청에 필요한 헤더와 JSON 본문을 설정합니다.
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': 1, // 사용자 ID 또는 다른 고유 식별자를 필요에 따라 설정
        'tts_ver': ttsVersion,
      }),
    );

    // 서버의 응답을 처리합니다.
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      print(responseBody['message']); // 성공 메시지 출력

      // Q2Screen으로 이동
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Q2Screen()),
      );
    } else {
      print('Failed to update TTS version: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildOption(1, iconData: Icons.woman, text: '엄마'),
                  _buildOption(2, iconData: Icons.man, text: '아빠'),
                  _buildOption(3, iconData: Icons.group, text: '친구(여성)'),
                  _buildOption(4, iconData: Icons.group, text: '친구(남성)'),
                ],
              ),
              SizedBox(height: 40),
              Text(
                'Q1. 가장 마음에 드는 목소리를 골라주세요.',
                style: TextStyle(
                  fontFamily: 'CustomFont',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: submitSelection, // 서버에 선택 항목을 전송하는 함수 호출
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3254ED),
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  '다음으로',
                  style: TextStyle(
                    fontFamily: 'CustomFont',
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

  Widget _buildOption(int value,
      {String? svgPath, IconData? iconData, required String text}) {
    bool isSelected = selectedOption == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = value;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF3254ED) : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: isSelected ? Color(0xFF3254ED) : Colors.grey,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            svgPath != null
                ? SvgPicture.asset(
                    svgPath,
                    width: 40,
                    height: 40,
                    color: isSelected ? Colors.white : Colors.black54,
                  )
                : Icon(iconData,
                    size: 40,
                    color: isSelected ? Colors.white : Colors.black54),
            SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(
                fontFamily: 'CustomFont',
                fontSize: 16,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Q1Screen(),
  ));
}
