import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../api/auth_api.dart';
import '../api/diary_api.dart'; // DiaryAPI import
import '../models/diary.dart';

class DiaryScreen extends StatefulWidget {
  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final AuthAPI authAPI = AuthAPI(); // AuthAPI 인스턴스 생성
  final DiaryAPI diaryAPI = DiaryAPI(); // DiaryAPI 인스턴스 생성

  String username = "username";  // 서버에서 받아올 이름
  String summary = "오늘의 대화 요약 내용이 여기에 표시됩니다."; // 일기 요약
  int mood = 2; // 0: Positive, 1: Negative, 2: Soso

  @override
  void initState() {
    super.initState();
    _retrieveUsername(); // 사용자 이름 불러오기
    _retrieveDiaryResult(); // 일기 결과 불러오기
  }

  // 서버에서 사용자 이름을 가져오는 메서드
  Future<void> _retrieveUsername() async {
    int userId = 1; // 예시로 설정한 ID, 실제로는 필요한 ID로 변경
    String? retrievedName = await authAPI.retrieveUser(userId);

    if (retrievedName != null) {
      setState(() {
        username = retrievedName;
      });
    } else {
      print("사용자 이름을 불러오지 못했습니다.");
    }
  }

  // 서버에서 오늘의 일기 결과를 가져오는 메서드
  Future<void> _retrieveDiaryResult() async {
    int userId = 1; // 예시로 설정한 ID, 실제로는 필요한 ID로 변경

    Diary? diary = await diaryAPI.getDiaryResult(userId);

    if (diary != null) {
      setState(() {
        summary = diary.content;
        mood = diary.feeling; // 서버에서 받은 감정 상태(0, 1, 2)를 mood에 설정
      });
    } else {
      print("오늘의 일기 결과를 불러오지 못했습니다.");
    }
  }

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
              width: 325,
              height: 400,
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Scrollbar(
                thumbVisibility: true,
                radius: Radius.circular(20),
                child: SingleChildScrollView(
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
                          SizedBox(width: 110),
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
