import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main_page.dart'; // main_page.dart 파일을 import
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(); // 로케일 데이터 초기화
  runApp(MaterialApp(
    home: ChatScreen(),
  ));
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Future<String>? futureResponder;

  @override
  void initState() {
    super.initState();
    futureResponder = fetchResponder();
  }

  Future<String> fetchResponder() async {
    try {
      final url = Uri.parse('http://10.0.2.2:8001/user/retrieve');
      final requestBody = jsonEncode({'id': 0}); // 예시 ID

      // 보내는 URL과 데이터를 출력
      print('Sending request to: $url');
      print('Sending request body: $requestBody');
      print('Request body type: ${requestBody.runtimeType}');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print('Response: $responseBody');
        return responseBody['name'] ?? '알 수 없음';
      } else {
        print('Failed to retrieve responder: ${response.statusCode}');
        return '알 수 없음';
      }
    } catch (e) {
      print('Error retrieving responder: $e');
      return '알 수 없음';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FutureBuilder<String>(
          future: futureResponder,
          builder: (context, snapshot) {
            String responder = "알 수 없음";

            if (snapshot.connectionState == ConnectionState.done) {
              // 데이터가 성공적으로 로드된 경우
              if (snapshot.hasData) {
                responder = snapshot.data!;
              }
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 180),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      margin: EdgeInsets.only(right: 50),
                      decoration: BoxDecoration(
                        color: Color(0xFF3254ED),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                      child: Text(
                        '나 시험 망쳤어.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 50),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Color(0xFF3254ED),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 100),
                Container(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '답변을 입력하세요',
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  'Q3. 엄마는 뭐라고 대답하실까?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // main_page.dart로 화면 전환
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
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
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
