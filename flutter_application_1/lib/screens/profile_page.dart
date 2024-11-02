import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class EmotionChart extends StatelessWidget {
  final Map<String, double> dataMap = {
    "Positive": 60,
    "Negative": 30,
    "Soso": 10,
  };

  final List<Color> colorList = [
    Color(0xFF4FE084),
    Color(0xFFF58282),
    Color(0xFFD9D9D9),
  ];

  @override
  Widget build(BuildContext context) {
    double positivePercentage = dataMap["Positive"] ?? 0;
    double negativePercentage = dataMap["Negative"] ?? 0;
    double neutralPercentage = dataMap["Soso"] ?? 0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Scrollbar( // 스크롤바 추가
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 45),
                Text(
                'LOGO',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
                SizedBox(height: 45),
                PieChart(
                  dataMap: dataMap,
                  animationDuration: Duration(milliseconds: 800),
                  chartRadius: MediaQuery.of(context).size.width / 2.5,
                  colorList: colorList,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 80,
                  chartValuesOptions: ChartValuesOptions(
                    showChartValuesInPercentage: true,
                    showChartValues: false,
                    chartValueStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    showChartValuesOutside: false,
                  ),
                  legendOptions: LegendOptions(
                    showLegends: false,
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8, // 동일한 너비 설정
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFF3254ED),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '지난 7일 간, 축구를 3번이나 언급하셨네요!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8, // 동일한 너비 설정
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFF3254ED),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${positivePercentage.toInt()}% Positive\n${negativePercentage.toInt()}% Negative ${neutralPercentage.toInt()}% So-so',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8, // 동일한 너비 설정
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'user님 맞춤형으로 추천해드려요!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '안양FC\nVS. 전북현대',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          '11/03 (일)',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 80), // 네비게이션 바 공간 확보
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: EmotionChart(),
  ));
}
