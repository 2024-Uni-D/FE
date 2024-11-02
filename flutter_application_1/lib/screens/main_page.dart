import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart'; // 로케일 초기화를 위한 패키지

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ko'); // 'ko' 로케일 초기화
  runApp(MaterialApp(
    home: CustomBottomNavigationBar(),
  ));
}

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 오늘 날짜를 가져오는 함수
  String getCurrentDate() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy.MM.dd (E)', 'ko'); // 예: 2024.11.03 (토)
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF4CA),
      body: Center(
        child: Container(
          width: 318,
          height: 462,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFF9E79F),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${getCurrentDate()} \n오늘의 일기를 기록해볼까요?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: 500, // 선의 길이
                height: 2, // 선의 두께
                color: Colors.black.withOpacity(0.5),
              ),
              SizedBox(height: 8),
              Text(
                "오늘의 일기는 아직 작성되지 않았어요",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              SvgPicture.asset(
                'assets/음성icon.svg', // SVG 파일 경로
                width: 100, // 아이콘 크기
                height: 100,
              ),
              SizedBox(height: 100),
              Center(
                // 버튼을 가운데 정렬
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE2C86E),
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Start',
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
      bottomNavigationBar: Container(
        width: 360.0,
        height: 84.0,
        decoration: BoxDecoration(
          color: Color(0xFFFFF4CA),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, -4),
              blurRadius: 8,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: _buildCustomItem(
                  'assets/diary.svg',
                  'Diary',
                  index: 0,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: _buildCustomItem(
                  'assets/home.svg',
                  'Home',
                  index: 1,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: _buildCustomItem(
                  'assets/profile.svg',
                  'Profile',
                  index: 2,
                ),
                label: '',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.grey,
            unselectedItemColor: Colors.black,
            onTap: _onItemTapped,
            showSelectedLabels: false,
            showUnselectedLabels: false,
          ),
        ),
      ),
    );
  }

  Widget _buildCustomItem(String iconPath, String label, {required int index}) {
    return Container(
      width: 80.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 24.0,
            height: 24.0,
            color: _selectedIndex == index ? Colors.grey : Colors.black,
          ),
          SizedBox(height: 6.93),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
              height: 1.1,
              letterSpacing: -0.22,
              color: _selectedIndex == index ? Colors.grey : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
