import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ChattingToday extends StatefulWidget {
  @override
  _ChattingTodayState createState() => _ChattingTodayState();
}

class _ChattingTodayState extends State<ChattingToday> {
  // 예시용 메시지 리스트
  List<Map<String, dynamic>> messages = [
    {"text": "안녕하세요!", "isMine": false},
    {"text": "오늘은 무엇을 도와드릴까요?", "isMine": false},
    {"text": "안녕하세요, 문의드립니다.", "isMine": true},
    {"text": "네, 어떻게 도와드릴까요?", "isMine": false},
    {"text": "네, 어떻게 도와드릴까요?", "isMine": false},
    {"text": "네, 어떻게 도와드릴까요?", "isMine": false},
    {"text": "네, 어떻게 도와드릴까요?", "isMine": true},
    {"text": "네, 어떻게 도와드릴까요?", "isMine": false},
    {"text": "네, 어떻게 도와드릴까요?", "isMine": false},
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
      backgroundColor: Color(0xFFF9E79F),
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
            SizedBox(height: 20),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFF9E79F),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getCurrentDate(),
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final bool isSameSender = index > 0 &&
                              messages[index - 1]["isMine"] ==
                                  message["isMine"];

                          return Padding(
                            padding: EdgeInsets.only(
                              top: isSameSender ? 4.0 : 12.0, // 간격 조절
                              bottom: 4.0,
                            ),
                            child: Align(
                              alignment: message["isMine"]
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: CustomPaint(
                                painter: ChatBubblePainter(
                                  color: message["isMine"]
                                      ? Colors.blue[100]!
                                      : Colors.grey[300]!,
                                  alignment: message["isMine"]
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                ),
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 4),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 14),
                                  child: Text(
                                    message["text"],
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE2C86E),
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                '종료',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ChatBubblePainter extends CustomPainter {
  final Color color;
  final Alignment alignment;

  ChatBubblePainter({required this.color, required this.alignment});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(16),
    );
    canvas.drawRRect(rrect, paint);

    // 뾰족한 부분 그리기
    final path = Path();
    if (alignment == Alignment.centerRight) {
      path.moveTo(size.width, size.height / 2);
      path.lineTo(size.width + 10, size.height / 2 - 5);
      path.lineTo(size.width, size.height / 2 - 10);
    } else {
      path.moveTo(0, size.height / 2);
      path.lineTo(-10, size.height / 2 - 5);
      path.lineTo(0, size.height / 2 - 10);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ChatBubblePainter oldDelegate) {
    return color != oldDelegate.color || alignment != oldDelegate.alignment;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ko');
  runApp(MaterialApp(
    home: ChattingToday(),
  ));
}
