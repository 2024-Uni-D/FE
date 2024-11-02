import 'package:flutter/material.dart';

class JoinStartPageScreen extends StatefulWidget {
  @override
  _JoinStartPageScreenState createState() => _JoinStartPageScreenState();
}

class _JoinStartPageScreenState extends State<JoinStartPageScreen> {
  DateTime? selectedDate;

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
              buildInputField('이름'),
              buildInputField('아이디'),
              buildInputField('비밀번호'),
              buildInputField('생년월일', isDateField: true),
              SizedBox(height: 30),
              // 회원가입 버튼 그대로 유지
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // 회원가입 버튼 눌렀을 때의 동작 추가
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3254ED),
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    '회원가입',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 입력 필드 생성 함수 (생년월일 필드일 때와 아닐 때를 구분)
  Widget buildInputField(String label, {bool isDateField = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '* $label',
            style: TextStyle(color: Color(0xFF3254ED)),
          ),
          SizedBox(height: 0),
          TextField(
            readOnly: isDateField, // 생년월일 필드일 때만 읽기 전용 설정
            onTap: isDateField
                ? () async {
                    // 생년월일 필드를 누르면 날짜 선택기 열기
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate ?? DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  }
                : null,
            decoration: InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              hintText: isDateField
                  ? (selectedDate != null
                      ? '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}'
                      : 'ex) 20XX.MM.YY')
                  : '',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: JoinStartPageScreen(),
  ));
}
