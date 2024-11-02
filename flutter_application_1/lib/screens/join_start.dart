import 'package:flutter/material.dart';
import '../api/auth_api.dart'; // AuthAPI import 추가
import '../models/user.dart';

class JoinStartPageScreen extends StatefulWidget {
  @override
  _JoinStartPageScreenState createState() => _JoinStartPageScreenState();
}

class _JoinStartPageScreenState extends State<JoinStartPageScreen> {
  final AuthAPI authAPI = AuthAPI();

  // 각 입력 필드를 위한 컨트롤러
  final TextEditingController nameController = TextEditingController();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  DateTime? selectedDate;

  @override
  void dispose() {
    // 컨트롤러 해제
    nameController.dispose();
    userIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _registerUser() async {
    // User 객체 생성
    final user = User(
      userId: userIdController.text,
      password: passwordController.text,
      name: nameController.text,
      birthday: selectedDate != null
          ? '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}'
          : '',
    );

    // 회원가입 요청 실행
    try {
      await authAPI.registerUser(user);
      print("회원가입에 성공했습니다!");
    } catch (e) {
      // 실패 시 콘솔에 오류 메시지 출력
      print("회원가입에 실패했습니다: $e");
    }
  }

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
              buildInputField('이름', controller: nameController),
              buildInputField('아이디', controller: userIdController),
              buildInputField('비밀번호', controller: passwordController, isPassword: true),
              buildInputField('생년월일', isDateField: true),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _registerUser, // 회원가입 버튼 클릭 시 _registerUser 호출
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
  Widget buildInputField(String label,
      {TextEditingController? controller, bool isDateField = false, bool isPassword = false}) {
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
            controller: controller,
            obscureText: isPassword, // 비밀번호 필드일 때 텍스트 가리기 설정
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
