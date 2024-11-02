import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class MyDiaryScreen extends StatefulWidget {
  @override
  _MyDiaryScreenState createState() => _MyDiaryScreenState();
}

class _MyDiaryScreenState extends State<MyDiaryScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // 포맷팅된 날짜를 가져오는 함수
  String getFormattedDate() {
    return DateFormat('MMMM yyyy').format(_focusedDay); // 예: October 2024
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF4CA),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40),
            Text(
              '로고',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'My Diary',
              style: TextStyle(
                fontSize: 24,
                fontStyle: FontStyle.italic,
                color: Colors.black,
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
              ),
              child: Column(
                children: [
                  // 달력 위에 화살표 버튼과 날짜 텍스트
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
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    onPageChanged: (focusedDay) {
                      setState(() {
                        _focusedDay = focusedDay; // 스크롤된 월로 업데이트
                      });
                    },
                    calendarFormat: CalendarFormat.month, // 월 단위로만 표시
                    headerVisible: false, // 기본 상단 헤더 숨김
                    daysOfWeekVisible: true, // 요일 행 표시
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month'
                    }, // 월 단위로만 고정
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
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
    home: MyDiaryScreen(),
  ));
}
