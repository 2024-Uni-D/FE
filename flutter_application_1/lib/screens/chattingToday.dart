import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ChattingToday extends StatefulWidget {
  @override
  _ChattingTodayState createState() => _ChattingTodayState();
}

class _ChattingTodayState extends State<ChattingToday> {
  // 예시 채팅 데이터
  List<Map<String, dynamic>> messages = [
    {"text": "안녕하세요!", "isMine": false},
    {"text": "오늘은 무엇을 도와드릴까요?", "isMine": false},
    {"text": "안녕하세요, 문의드립니다.", "isMine": true},
    {"text": "네, 어떻게 도와드릴까요?", "isMine": false},
    {"text": "네, 어떻게 도와드릴까요?", "isMine": false},
    {"text": "네, 어떻게 도와드릴까요?", "isMine": false},
    {"text": "네, 어떻게 도와드릴까요?", "isMine": false},
    {"text": "네, 어떻게 도와드릴까요?", "isMine": false},
    {"text": "안녕하세요, 문의드립니다.", "isMine": true},
    {"text": "안녕하세요, 문의드립니다.", "isMine": true},
    {"text": "안녕하세요, 문의드립니다.", "isMine": true},
  ];

  // 오늘 날짜를 가져오는 함수
  String getCurrentDate() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy.MM.dd (E)', 'ko');
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 40),
          Text(
            getCurrentDate(),
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final bool isMine = message["isMine"];
                return Align(
                  alignment:
                      isMine ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    margin: EdgeInsets.only(
                      bottom: 10,
                      left: isMine ? 50 : 0,
                      right: isMine ? 0 : 50,
                    ),
                    decoration: BoxDecoration(
                      color: isMine ? Color(0xFF3254ED) : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft:
                            isMine ? Radius.circular(15) : Radius.circular(0),
                        bottomRight:
                            isMine ? Radius.circular(0) : Radius.circular(15),
                      ),
                      border: isMine
                          ? null
                          : Border.all(
                              color: Color(0xFF3254ED),
                              width: 1.5), // 회색 말풍선 테두리 추가
                    ),
                    child: Text(
                      message["text"],
                      style: TextStyle(
                        color: isMine ? Colors.white : Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 100), // 네비게이션 바가 들어갈 공간 확보
        ],
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ko');
  runApp(MaterialApp(
    home: ChattingToday(),
  ));
}
