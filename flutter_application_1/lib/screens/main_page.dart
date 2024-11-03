import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/auth_api.dart';
import '../screens/calendar_page.dart'; // MyDiaryScreen import 추가
import '../screens/profile_page.dart'; // EmotionChart import 추가
import '../screens/chattingToday.dart'; // EmotionChart import 추가

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ko');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MaterialTopNavigationBar(),
      body: CustomBottomNavigationBar(),
    );
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 1;
  bool _hasSeenPopup = false;
  final Color popupBorderColor = Color(0xFFDE2A3D).withOpacity(0.4);
  final AuthAPI authAPI = AuthAPI();
  String username = "username";

  @override
  void initState() {
    super.initState();
    _checkIfPopupSeen();
    _retrieveUsername();
  }

  Future<void> _checkIfPopupSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _hasSeenPopup = prefs.getBool('hasSeenPopup') ?? false;
    });

    if (!_hasSeenPopup) {
      _showPopup();
    }
  }

  Future<void> _retrieveUsername() async {
    int userId = 1; // 예시 ID, 실제 ID로 변경 필요
    String? retrievedName = await authAPI.retrieveUser(userId);

    if (retrievedName != null) {
      setState(() {
        username = retrievedName;
      });
    } else {
      print("사용자 이름을 불러오지 못했습니다.");
    }
  }

  Future<void> _showPopup() async {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: popupBorderColor, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            width: 297,
            height: 500,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '루틴',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: popupBorderColor,
                          ),
                        ),
                        TextSpan(
                          text: '을 설정해주세요',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '루틴을 설정해주시면 앱을 더 유용하게 사용하실 수 있어요!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  SvgPicture.asset(
                    'assets/icon/Frame.svg',
                    width: 400,
                    height: 200,
                  ),
                  SizedBox(height: 20),
                  Text(
                    '이제 집에 들어가는 순간 withU가 $username을 반겨줄 거예요',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool('hasSeenPopup', true);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: popupBorderColor,
                    ),
                    child: Text(
                      '확인',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String getCurrentDate() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy.MM.dd (E)', 'ko');
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/icon/Logo.svg',
              width: 100, // 적절한 크기로 설정하세요
              height: 100,
            ),
            SizedBox(height: 20),
            Container(
              width: 320,
              height: 380,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF3254ED),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${getCurrentDate()} \n오늘의 일기를 기록해볼까요?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: 500,
                    height: 2,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "오늘의 일기는 아직 작성되지 않았어요",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 50),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ChattingToday()), // ChattingToday 페이지로 이동
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/icon/speak_icon.svg',
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
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
                icon:
                    _buildNavItem('assets/icon/profile_icon.svg', 'Profile', 2),
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
                // Diary 아이콘 클릭 시 MyDiaryScreen으로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyDiaryScreen()),
                );
              } else if (index == 2) {
                // Profile 아이콘 클릭 시 EmotionChart로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmotionChart()),
                );
              }
            },
          ),
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

class MaterialTopNavigationBar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icon/back_icon.svg',
          width: 17.375,
          height: 18.688,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(
            'assets/icon/setting.svg',
            width: 40,
            height: 28,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
