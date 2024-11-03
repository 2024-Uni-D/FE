import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../api/auth_api.dart';
import 'main_page.dart'; // HomeScreen import
import 'calendar_page.dart'; // MyDiaryScreen import
import 'profile_page.dart'; // EmotionChart import

class DiaryScreen extends StatefulWidget {
  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final AuthAPI authAPI = AuthAPI();
  String username = "username";
  String summary = "오늘 전시회 정말 재미있었어! \n전시장 분위기부터가 너무 좋았고, \n밥 먹고 있는 고양이 작품이 가장 기억에 남더라. \n그 고양이의 표정이 너무 귀엽고 인상 깊었어. \n특히 어제 처음 들었던 노래가 전시와 잘 어울려서 \n노래 들으면서 작품을 감상하는 순간이 정말 행복했어.\n마치 작품 속에 들어간 느낌이었달까?\n그 순간이 계속 떠오르고 잊혀지지가 않아.\n이번 전시회는 정말 특별한 경험이었어.\n앞으로도 이런 시간을 자주 만들고 싶어.\n마음이 편안해지고 기분도 좋아지더라.\n다음에도 좋은 전시회 있으면 꼭 가보고 싶어!" ;
  int mood = 2;

  @override
  void initState() {
    super.initState();
    _retrieveUsername();
  }

  Future<void> _retrieveUsername() async {
    int userId = 1;
    String? retrievedName = await authAPI.retrieveUser(userId);

    if (retrievedName != null) {
      setState(() {
        username = retrievedName;
      });
    } else {
      print("사용자 이름을 불러오지 못했습니다.");
    }
  }

  String getCurrentDate() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy.MM.dd (E)', 'ko');
    return formatter.format(now);
  }

  String getMoodSvgPath() {
    switch (mood) {
      case 0:
        return 'assets/icon/Positive.svg';
      case 1:
        return 'assets/icon/Negative.svg';
      case 2:
        return 'assets/icon/Soso.svg';
      default:
        return 'assets/icon/Soso.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              '$username의 오늘의 일기',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 325,
              height: 400,
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Scrollbar(
                thumbVisibility: true,
                radius: Radius.circular(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            getCurrentDate(),
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 110),
                          SvgPicture.asset(
                            getMoodSvgPath(),
                            width: 24,
                            height: 24,
                            placeholderBuilder: (context) => Container(),
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey),
                      SizedBox(height: 10),
                      Text(
                        '오늘의 대화',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                        Text(
                          summary,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: 0),
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ko');
  runApp(MaterialApp(
    home: DiaryScreen(),
  ));
}
