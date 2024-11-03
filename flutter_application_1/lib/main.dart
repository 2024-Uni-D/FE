import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_application_1/screens/login_start.dart'; // your_app_name을 실제 앱 이름으로 변경

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(); // 로케일 데이터 초기화
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      home: LoginStartPageScreen(),
    );
  }
}
