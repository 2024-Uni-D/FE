import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Q2Screen extends StatefulWidget {
  @override
  _Q2ScreenState createState() => _Q2ScreenState();
}

class _Q2ScreenState extends State<Q2Screen> {
  Set<int> selectedOptions = Set();

  Future<void> submitSelection() async {
    if (selectedOptions.isEmpty) return;

    final url = Uri.parse('http://10.0.2.2:8001/prequestion/apply1');
    // final url = Uri.parse('http://127.0.0.1:8001/prequestion/apply1');

    // 선택된 옵션들을 콤마로 구분된 문자열로 변환
    String favorite1 = selectedOptions.map((option) {
      switch (option) {
        case 1:
          return "영화";
        case 2:
          return "음악";
        case 3:
          return "전시회";
        case 4:
          return "독서";
        default:
          return "";
      }
    }).join(", ");

    // 전송할 JSON 본문을 미리 확인
    final requestBody = jsonEncode({
      'id': 0, // 고유 사용자 ID 필요 시 변경
      'favorite1': favorite1,
    });
    print('Sending request body: $requestBody');
    print('Request body type: ${requestBody.runtimeType}');

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': 1, // 고유 사용자 ID 필요 시 변경
        'favorite1': favorite1,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      print(responseBody['message']);
    } else {
      print('Failed to update favorite1: ${response.statusCode}');
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
                  _buildOption(1, svgPath: 'assets/icon/film.svg', text: '영화'),
                  _buildOption(2, svgPath: 'assets/icon/music.svg', text: '음악'),
                  _buildOption(3,
                      svgPath: 'assets/icon/image.svg', text: '전시회'),
                  _buildOption(4, svgPath: 'assets/icon/book.svg', text: '독서'),
                ],
              ),
              SizedBox(height: 40),
              Text(
                'Q2. 관심사를 알려주세요!\n(복수 선택 가능)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: submitSelection,
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

  Widget _buildOption(int value, {String? svgPath, required String text}) {
    bool isSelected = selectedOptions.contains(value);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedOptions.remove(value);
          } else {
            selectedOptions.add(value);
          }
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
        child: Stack(
          children: [
            Positioned(
              top: 28,
              right: 28,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
            ),
            Positioned(
              bottom: 28,
              left: 28,
              child: svgPath != null
                  ? SvgPicture.asset(
                      svgPath,
                      width: 34,
                      height: 34,
                      color: isSelected ? Colors.white : Colors.black54,
                    )
                  : Icon(
                      Icons.help_outline,
                      size: 34,
                      color: isSelected ? Colors.white : Colors.black54,
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
    home: Q2Screen(),
  ));
}
