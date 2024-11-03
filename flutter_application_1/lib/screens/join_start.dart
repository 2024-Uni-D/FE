import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // SVG 패키지 추가
import '../api/auth_api.dart';
import '../models/user.dart';
import '../screens/Q1.dart'; // Q1 화면 import 추가

class JoinStartPageScreen extends StatefulWidget {
  @override
  _JoinStartPageScreenState createState() => _JoinStartPageScreenState();
}

class _JoinStartPageScreenState extends State<JoinStartPageScreen> {
  final AuthAPI authAPI = AuthAPI();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  DateTime? selectedDate;

  @override
  void dispose() {
    nameController.dispose();
    userIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _registerUser() async {
    final user = User(
      userId: userIdController.text,
      password: passwordController.text,
      name: nameController.text,
      birthday: selectedDate != null
          ? '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}'
          : '',
    );

    try {
      await authAPI.registerUser(user);
      print("회원가입에 성공했습니다!");

      // 회원가입 성공 시 Q1Screen으로 이동
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Q1Screen()),
      );
    } catch (e) {
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
              SvgPicture.asset(
                'assets/icon/Logo.svg', // SVG 로고 파일 경로
                width: 100, // 로고 크기 설정
                height: 100,
              ),
              SizedBox(height: 40),
              buildInputField('이름', controller: nameController),
              buildInputField('아이디', controller: userIdController),
              buildInputField('비밀번호',
                  controller: passwordController, isPassword: true),
              buildInputField('생년월일', isDateField: true),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _registerUser,
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

  Widget buildInputField(String label,
      {TextEditingController? controller,
      bool isDateField = false,
      bool isPassword = false}) {
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
            obscureText: isPassword,
            readOnly: isDateField,
            onTap: isDateField
                ? () async {
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
