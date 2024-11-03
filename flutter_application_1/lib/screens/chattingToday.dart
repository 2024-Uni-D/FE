import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../api/question_api.dart';
import '../api/answer_api.dart';

class ChattingToday extends StatefulWidget {
  @override
  _ChattingTodayState createState() => _ChattingTodayState();
}

class _ChattingTodayState extends State<ChattingToday> {
  final QuestionAPI questionAPI = QuestionAPI();
  final AnswerAPI answerAPI = AnswerAPI();
  List<Map<String, dynamic>> messages = [];
  int? currentOrder; // 현재 질문의 order 값을 저장할 변수

  @override
  void initState() {
    super.initState();
    _loadInitialQuestion(); // 초기화 시 질문 불러오기
  }

  // 질문을 생성하고, 서버에서 첫 질문을 가져오는 메서드
  Future<void> _loadInitialQuestion() async {
    int userId = 1; // 실제 사용자 ID로 설정
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // 서버에서 질문 생성 및 첫 질문 가져오기
    final questionResponse = await questionAPI.createQuestion(userId, todayDate);

    if (questionResponse != null) {
      setState(() {
        messages.add({"text": questionResponse['question_text'], "isMine": false});
        currentOrder = questionResponse['order']; // order 값 저장
      });
    } else {
      setState(() {
        messages.add({"text": "질문을 가져오지 못했습니다.", "isMine": false});
      });
    }
  }

  // 사용자가 메시지를 보냈을 때 호출되는 함수
  Future<void> _sendMessage(String text) async {
    setState(() {
      messages.add({"text": text, "isMine": true});
    });

    int userId = 1; // 실제 사용자 ID로 설정
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // 답변 업데이트 API 호출 (currentOrder를 전달)
    final answerResponse = await answerAPI.updateAnswer(userId, currentOrder!, text, todayDate);

    if (answerResponse != null) {
      setState(() {
        messages.add({"text": answerResponse, "isMine": false});
      });
    } else {
      setState(() {
        messages.add({"text": "답변을 가져오지 못했습니다.", "isMine": false});
      });
    }
  }

  // 오늘 날짜를 가져오는 함수
  String getCurrentDate() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy.MM.dd (E)', 'ko');
    return formatter.format(now);
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
                          : Border.all(
                              color: Color(0xFF3254ED),
                              width: 1.5,
                            ),
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
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "메시지를 입력하세요...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    onSubmitted: (text) {
                      _sendMessage(text);
                      _controller.clear();
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Color(0xFF3254ED)),
                  onPressed: () {
                    if (_controller.text.trim().isNotEmpty) {
                      _sendMessage(_controller.text.trim());
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
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
