import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class DiaryScreen extends StatefulWidget {
  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  // 예시 데이터 (백엔드에서 가져온다고 가정)
  String username = "username"; // 사용자 이름
  String summary = "오늘의 대화 요약 내용이 여기에 표시됩니다."; // 대화 요약
  int mood = 2; // 0: Positive, 1: Negative, 2: Soso

  // 오늘 날짜 가져오기
  String getCurrentDate() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy.MM.dd (E)', 'ko');
    return formatter.format(now);
  }

  // 기분 상태에 따른 SVG 경로 가져오기
  String getMoodSvgPath() {
    switch (mood) {
      case 0:
        return 'assets/icon/Positive.svg';
      case 1:
        return 'assets/icon/Negative.svg';
      case 2:
        return 'assets/icon/Soso.svg';
      default:
        return 'assets/icon/Soso.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40),
            Text(
              '로고',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '$username의 오늘의 일기',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 325, // 너비 설정
              height: 400, // 높이 설정
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Scrollbar(
                // 스크롤바 추가
                thumbVisibility: true, // 항상 보여줌
                radius: Radius.circular(20), // 스크롤바의 모서리 반경
                child: SingleChildScrollView(
                  // 스크롤 가능하게 만들기
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            getCurrentDate(),
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 110), // SVG와의 간격 조정
                          SvgPicture.asset(
                            getMoodSvgPath(),
                            width: 24,
                            height: 24,
                            placeholderBuilder: (context) => Container(),
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey),
                      SizedBox(height: 10),
                      Text(
                        '오늘의 대화',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      // 여러 줄의 텍스트 추가
                      for (int i = 0; i < 20; i++)
                        Text(
                          summary,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ko');
  runApp(MaterialApp(
    home: DiaryScreen(),
  ));
}
