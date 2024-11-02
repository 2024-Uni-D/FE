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
      backgroundColor: Color(0xFFF9E79F),
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
                  _buildOption(1, svgPath: 'assets/icon/movie.svg', text: '영화'),
                  _buildOption(2, svgPath: 'assets/icon/music.svg', text: '음악'),
                  _buildOption(3,
                      svgPath: 'assets/icon/exhibition.svg', text: '전시회'),
                  _buildOption(4,
                      svgPath: 'assets/icon/reading.svg', text: '독서'),
                ],
              ),
              SizedBox(height: 40),
              Text(
                'Q2. 관심사를 알려주세요! (복수 선택 가능)',
                style: TextStyle(
                  fontFamily: 'CustomFont',
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
                  backgroundColor: Color(0xFFE2C86E),
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  '결정',
                  style: TextStyle(
                    fontFamily: 'CustomFont',
                    color: Colors.black,
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            svgPath != null
                ? SvgPicture.asset(
                    svgPath,
                    width: 40,
                    height: 40,
                    color: Colors.black54,
                  )
                : Icon(Icons.help_outline, size: 40, color: Colors.black54),
            SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(
                fontFamily: 'CustomFont',
                fontSize: 16,
                color: Colors.black87,
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
