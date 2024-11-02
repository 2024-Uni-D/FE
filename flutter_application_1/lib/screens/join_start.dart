import 'package:flutter/material.dart';

class JoinStartPageScreen extends StatefulWidget {
  @override
  _JoinStartPageScreenState createState() => _JoinStartPageScreenState();
}

class _JoinStartPageScreenState extends State<JoinStartPageScreen> {
  DateTime? selectedDate;
  bool isSelectedCal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9E79F),
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
              SizedBox(height: 20),
              CalButton(
                onDateSelected: (date) {
                  setState(() {
                    selectedDate = date;
                    isSelectedCal = true;
                  });
                },
                isSelected: isSelectedCal,
                selectedDate: selectedDate,
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // 회원가입 버튼 눌렀을 때의 동작 추가
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE2C86E),
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    '회원가입',
                    style: TextStyle(
                      color: Colors.black,
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

  // 입력 필드 생성 함수
  Widget buildInputField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '* $label',
            style: TextStyle(color: Colors.grey[700]),
          ),
          SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              hintText: '$label을(를) 입력해주세요',
            ),
          ),
        ],
      ),
    );
  }
}

// 캘린더 버튼 클래스
class CalButton extends StatelessWidget {
  final Function(DateTime) onDateSelected;
  final bool isSelected;
  final DateTime? selectedDate;

  const CalButton({
    Key? key,
    required this.onDateSelected,
    required this.isSelected,
    this.selectedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(1950),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          onDateSelected(pickedDate);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xffFFF4CA),
      ),
      child: Container(
        width: 340,
        height: 65,
        decoration: BoxDecoration(
          color: Color(0xffFFF4CA),
          borderRadius: BorderRadius.all(Radius.circular(80)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.calendar_today,
              color: Color(0xff000000),
            ),
            SizedBox(width: 10),
            Text(
              isSelected ? '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}' : '생년월일',
              style: TextStyle(
                color: Color(0xff000000),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: JoinStartPageScreen(),
  ));
}
