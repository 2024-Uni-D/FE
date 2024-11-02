import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Q2Screen extends StatefulWidget {
  @override
  _Q2ScreenState createState() => _Q2ScreenState();
}

class _Q2ScreenState extends State<Q2Screen> {
  Set<int> selectedOptions = Set();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildOption(1, svgPath: 'assets/icon/film.svg', text: '영화'),
                  _buildOption(2, svgPath: 'assets/icon/music.svg', text: '음악'),
                  _buildOption(3,
                      svgPath: 'assets/icon/image.svg', text: '전시회'),
                  _buildOption(4, svgPath: 'assets/icon/book.svg', text: '독서'),
                ],
              ),
              SizedBox(height: 40),
              Text(
                'Q2. 관심사를 알려주세요!\n(복수 선택 가능)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  print("선택한 옵션: $selectedOptions");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3254ED),
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  '다음으로',
                  style: TextStyle(
                    fontFamily: 'CustomFont',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(int value, {String? svgPath, required String text}) {
    bool isSelected = selectedOptions.contains(value);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedOptions.remove(value);
          } else {
            selectedOptions.add(value);
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF3254ED) : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: isSelected ? Color(0xFF3254ED) : Colors.grey,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // 오른쪽 위 텍스트를 중앙에 가깝게 이동하고 스타일 조정
            Positioned(
              top: 28,
              right: 28,
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: 'CustomFont',
                  fontSize: 18, // 글씨 크기
                  fontWeight: FontWeight.bold, // 글씨 굵게
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
            ),
            // 왼쪽 아래 아이콘을 중앙에 가깝게 이동
            Positioned(
              bottom: 28,
              left: 28,
              child: svgPath != null
                  ? SvgPicture.asset(
                      svgPath,
                      width: 34,
                      height: 34,
                      color: isSelected ? Colors.white : Colors.black54,
                    )
                  : Icon(
                      Icons.help_outline,
                      size: 34,
                      color: isSelected ? Colors.white : Colors.black54,
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
    home: Q2Screen(),
  ));
}
