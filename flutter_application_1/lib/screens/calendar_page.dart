import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

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
            // 전체 흰색 배경을 감싸는 Container에 테두리 추가
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
                  // 달력
                  TableCalendar(
                    firstDay: DateTime.utc(2000, 1, 1),
                    lastDay: DateTime.utc(2100, 12, 31),
                    focusedDay: _focusedDay,
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
                        color: getHighlightColor(DateTime.now()),
                        shape: BoxShape.circle,
                      ),
                      outsideDaysVisible: false, // 월에 포함되지 않는 날 표시 안 함
                      todayTextStyle:
                          TextStyle(color: Colors.black), // 오늘 날짜의 텍스트 스타일 검정색
                    ),
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, focusedDay) {
                        return Container(
                          decoration: BoxDecoration(
                            color: getHighlightColor(day), // 강조 색상 설정
                            shape: BoxShape.circle,
                          ),
                          margin: EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          child: Text(
                            day.day.toString(),
                            style: TextStyle(
                                color: Colors.black), // 모든 날짜의 폰트 색상 검정색
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
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyDiaryScreen(),
  ));
}
