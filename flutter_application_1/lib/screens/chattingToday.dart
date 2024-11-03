import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'today_Diary.dart'; // DiaryScreen import 추가

class ChattingToday extends StatefulWidget {
  @override
  _ChattingTodayState createState() => _ChattingTodayState();
}

class _ChattingTodayState extends State<ChattingToday> {
  List<Map<String, dynamic>> messages = [
    {"text": "상현아, 오늘은 전시회 어땠어?", "isMine": false}, // 초기 질문 메시지
  ];
  bool isChattingComplete = false; // 대화가 완료되었는지 상태를 저장하는 변수

  @override
  void initState() {
    super.initState();
    _sendMessage(); // 화면이 로드되자마자 메시지 전송
  }

  // 오늘 날짜를 가져오는 함수
  String getCurrentDate() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy.MM.dd (E)', 'ko');
    return formatter.format(now);
  }

  // 메시지 딜레이와 함께 추가하는 함수
  Future<void> _addMessageWithDelay(Map<String, dynamic> message, int delayInSeconds) async {
    await Future.delayed(Duration(seconds: delayInSeconds));
    setState(() {
      messages.add(message);
    });
  }

  // 사용자가 메시지를 보냈을 때 호출되는 함수
  Future<void> _sendMessage() async {
    // 사용자가 입력한 첫 메시지 추가
    await _addMessageWithDelay({"text": "오늘 전시회 재미있었어", "isMine": true}, 10);
    
    // 응답 메시지 추가
    await _addMessageWithDelay({"text": "상현, 전시회 재밌었겠다! 오늘 전시회에서 가장 기억에 남는 작품은 뭐였어?", "isMine": false}, 5);

    // 사용자 입력 메시지 추가
    await _addMessageWithDelay({"text": "밥먹고 있는 고양이 작품이 가장 기억에 남더라고", "isMine": true}, 10);

    // 또 다른 응답 메시지 추가
    await _addMessageWithDelay({"text": "상현, 오늘 전시회 이야기 들으니까 나도 같이 갔던 기분이야. 🥰 로제랑 브루노 마스가 함께 부른 APT. 이 노래 들어봤어?", "isMine": false}, 5);

    // 사용자 입력 메시지 추가
    await _addMessageWithDelay({"text": "응 어제 처음 들어봤어", "isMine": true}, 10);

    // 마지막 응답 메시지 추가
    await _addMessageWithDelay({"text": "상현, 어제 처음 들어봤다고 했는데 어떤 느낌이었어? 뭔가 특별한 감동이 있었을 것 같아. 😊", "isMine": false}, 5);

    // 대화가 완료되면 버튼 비활성화
    setState(() {
      isChattingComplete = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

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
                  alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
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
                        bottomLeft: isMine ? Radius.circular(15) : Radius.circular(0),
                        bottomRight: isMine ? Radius.circular(0) : Radius.circular(15),
                      ),
                      border: isMine
                          ? null
                          : Border.all(color: Color(0xFF3254ED), width: 1.5),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.send, color: isChattingComplete ? Colors.grey : Color(0xFF3254ED)),
                  onPressed: isChattingComplete
                      ? null
                      : () {
                          if (_controller.text.trim().isNotEmpty) {
                            _sendMessage();
                            _controller.clear();
                          }
                        },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DiaryScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF3254ED), // 파란색 버튼
                padding: EdgeInsets.symmetric(vertical: 15),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                '확인',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
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
