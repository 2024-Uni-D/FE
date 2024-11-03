import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'main_page.dart'; // main_page import 추가
import 'profile_page.dart'; // EmotionChart import 추가

class MyDiaryScreen extends StatefulWidget {
  @override
  _MyDiaryScreenState createState() => _MyDiaryScreenState();
}

class _MyDiaryScreenState extends State<MyDiaryScreen> {
  DateTime _focusedDay = DateTime.now();

  // 가상의 JSON 데이터를 Map 형태로 변환
  Map<String, int> dayStatus = {
    "2024-11-01": 0,
    "2024-11-02": 1,
    "2024-11-03": 2,
  };

  // 포맷팅된 날짜를 가져오는 함수
  String getFormattedDate() {
    return DateFormat('MMMM yyyy').format(_focusedDay); // 예: October 2024
  }

  // 각 날짜에 대해 강조 색상 반환 함수
  Color getHighlightColor(DateTime day) {
    String dayKey = DateFormat('yyyy-MM-dd').format(day);
    int? status = dayStatus[dayKey];

    switch (status) {
      case 2:
        return Color(0xFF4FE084); // 2일 경우 연두색
      case 0:
        return Color(0xFFF58282); // 0일 경우 빨간색
      case 1:
        return Color(0xFFD9D9D9); // 1일 경우 회색
      default:
        return Colors.transparent; // 상태가 없으면 투명
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100),
            Text(
              'My Diary',
              style: TextStyle(
                fontSize: 32,
                fontStyle: FontStyle.italic,
                color: Color(0xFF3254ED),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 325,
              height: 400,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: Colors.grey, width: 1.5),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_left),
                        onPressed: () {
                          setState(() {
                            _focusedDay = DateTime(
                              _focusedDay.year,
                              _focusedDay.month - 1,
                              _focusedDay.day,
                            );
                          });
                        },
                      ),
                      Text(
                        getFormattedDate(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_right),
                        onPressed: () {
                          setState(() {
                            _focusedDay = DateTime(
                              _focusedDay.year,
                              _focusedDay.month + 1,
                              _focusedDay.day,
                            );
                          });
                        },
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey),
                  SizedBox(height: 10),
                  TableCalendar(
                    firstDay: DateTime.utc(2000, 1, 1),
                    lastDay: DateTime.utc(2100, 12, 31),
                    focusedDay: _focusedDay,
                    onPageChanged: (focusedDay) {
                      setState(() {
                        _focusedDay = focusedDay;
                      });
                    },
                    calendarFormat: CalendarFormat.month,
                    headerVisible: false,
                    daysOfWeekVisible: true,
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month'
                    },
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: getHighlightColor(DateTime.now()),
                        shape: BoxShape.circle,
                      ),
                      outsideDaysVisible: false,
                      todayTextStyle: TextStyle(color: Colors.black),
                    ),
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, focusedDay) {
                        return Container(
                          decoration: BoxDecoration(
                            color: getHighlightColor(day),
                            shape: BoxShape.circle,
                          ),
                          margin: EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          child: Text(
                            day.day.toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 0, // My Diary 아이콘이 활성화되도록 설정
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  CustomBottomNavigationBar({required this.selectedIndex});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.0,
      height: 106.0,
      decoration: BoxDecoration(
        color: Color(0xFF3254ED),
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
              icon: _buildNavItem('assets/icon/diary.svg', 'Diary', 0),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildNavItem('assets/icon/home_icon.svg', 'Home', 1),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildNavItem('assets/icon/profile_icon.svg', 'Profile', 2),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          backgroundColor: Color(0xFF3254ED),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });

            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyDiaryScreen()),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmotionChart()),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildNavItem(String assetPath, String label, int index) {
    return Container(
      decoration: BoxDecoration(
        color: _selectedIndex == index ? Colors.white : Colors.transparent,
        shape: BoxShape.circle,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            assetPath,
            color: _selectedIndex == index ? Color(0xFF3254ED) : Colors.white70,
            width: 30,
            height: 30,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color:
                  _selectedIndex == index ? Color(0xFF3254ED) : Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyDiaryScreen(),
  ));
}
