
import 'dart:math';

import 'package:flutter/material.dart';


class ChartPage extends StatelessWidget {
  List<double> points = [0, 0.38, 0.67, 0.96, 1.25];  // 세로축 텍스트
  List<String> labels = [ // 가로축에 적을 텍스트(레이블)
    "1",
    "2",
    "3",
    "4",
    "Today",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chart Page"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                child: CustomPaint(
                    size: Size(200, 200),
                    foregroundPainter: BarChart(
                        data: points,
                        labels: labels,
                        color: Colors.pinkAccent)), // color - 막대 그래프의 색깔
              )
            ],
          ),
        ),
      ),
    );
  }
}
// BarChart;
  //   1. 좌표를 구하는 부분 -> 어디에 그래프를 그릴지
  //    2. 그래프를 그리는 부분 -> 실제 막대그리프를 그림 ; drawRect() (실제 그래프 그리는 함수)
  //    3. 텍스트를 그리는 부분 -> x축과 y축에 텍스트를 그린다. 화면 크기에 비례해 폰트크기가 정해지도록 계산됨
class BarChart extends CustomPainter {   // 이 클래스는 실제 페인팅을 담당함, ;컬러 지정 해둠
  Color color;
  double textScaleFactorXAxis = 1.0; // x축 텍스트의 비율을 정함.
  double textScaleFactorYAxis = 1.2; // y축 텍스트의 비율을 정함.

  List<double> data = [];
  List<String> labels = [];
  double bottomPadding = 0.0;
  double leftPadding = 0.0;

  BarChart({required this.data, required this.labels, this.color = Colors.blue});

  @override
  void paint(Canvas canvas, Size size) {   // Paint(); 캔버스에 실제 그리는 메서드 ; 캔버스 객체를 받아 그림을 그림
    setTextPadding(size); // 텍스트를 공간을 미리 정함.

    List<Offset> coordinates = getCoordinates(size);

    drawBar(canvas, size, coordinates);
    drawXLabels(canvas, size, coordinates);
    drawYLabels(canvas, size, coordinates);
    drawLines(canvas, size, coordinates);   // 선 그기
  }

  void setTextPadding(Size size) {
    bottomPadding = size.height / 10; // 세로 크기의 1/10만큼만 텍스트 패딩을 줌
    leftPadding = size.width / 10; // 가로 길이의 1/10만큼 텍스트 패딩을 줌
  }

  void drawBar(Canvas canvas, Size size, List<Offset> coordinates) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill   // 선 안을 다 채울건지
      ..strokeCap = StrokeCap.round;   // 선의 끝을 둥글

    double barWidthMargin = (size.width * 0.09); // 막대 그래프가 겹치지 않게 간격을 줌.

    for (var index = 0; index < coordinates.length; index++) {
    Offset offset = coordinates[index];
    double left = offset.dx;
    double right = offset.dx + barWidthMargin; // 간격만큼 가로로 이동
    double top = offset.dy;
    double bottom = size.height - bottomPadding; // 텍스트 크기만큼 패딩을 빼줘서, 텍스트와 겹치지 않게 함.

    Rect rect = Rect.fromLTRB(right, top, left, bottom);
    canvas.drawRect(rect, paint);    // 실제 막대그래프를 그리는 부분

    }
  }

  // X축 텍스트(레이블)을 그림.
  void drawXLabels(Canvas canvas, Size size, List<Offset> coordinates) {
    double fontSize = calculateFontSize(labels[0], size, xAxis: true); // 화면 크기에 유동적으로 폰트 크기를 계산함.

    for (int index = 0; index < labels.length; index++) {

    TextSpan span = TextSpan(    // 화면에 들어가게함
    style: TextStyle(
    color: Colors.black,
    fontSize: fontSize,   // 화면 크기에 비례헤 폰트가 계산됨
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400),
    text: labels[index]);

    TextPainter tp = TextPainter(text: span, textDirection: TextDirection.ltr);    // 화면 어디에 들어가게 해라 ; tp
    tp.layout();

    Offset offset = coordinates[index];   //offset; 얼만큼 띄어뜨릴 것인지
    double dx = offset.dx;
    double dy = size.height - tp.height;

    tp.paint(canvas, Offset(dx, dy));
    }
  }

  // Y축 텍스트(레이블)을 그림. 최저값과 최고값을 Y축에 표시함.
  void drawYLabels(Canvas canvas, Size size, List<Offset> coordinates) {
    double bottomY = coordinates[0].dy;
    double topY = coordinates[0].dy;
    int indexOfMax = 0;
    int indexOfMin = 0;

    for (int index = 0; index < coordinates.length; index++) {
    double dy = coordinates[index].dy;

    if (bottomY < dy) {
    bottomY = dy;
    indexOfMin = index;
    }

    if (topY > dy) {
    topY = dy;
    indexOfMax = index;
    }
    }

    String maxValue = "${data[indexOfMax].toInt()}";
    String minValue = "${data[indexOfMin].toInt()}";

    double fontSize = calculateFontSize(maxValue, size, xAxis: false);

    drawYText(canvas, maxValue, fontSize, topY);
    drawYText(canvas, minValue, fontSize, bottomY);
  }

  // 화면 크기에 비례해 폰트 크기를 계산.
  double calculateFontSize(String value, Size size, {required bool xAxis}) {
    int numberOfCharacters = value.length; // 글자수에 따라 폰트 크기를 계산하기 위함.
    double fontSize = (size.width / numberOfCharacters) / data.length; // width가 600일 때 100글자를 적어야 한다면, fontSize는 글자 하나당 6이어야겠죠.

    if (xAxis) {
    fontSize *= textScaleFactorXAxis;
    } else {
    fontSize *= textScaleFactorYAxis;
    }

    return fontSize;
  }

  // x축과 y축을 구분하는 선을 긋습니다.
  void drawLines(Canvas canvas, Size size, List<Offset> coordinates) {
    Paint paint = Paint()
      ..color = Colors.blueGrey[100]!
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;

    double bottom = size.height - bottomPadding;
    double left = coordinates[0].dx;

    Path path = Path();
    path.moveTo(left, 0);
    path.lineTo(left, bottom);
    path.lineTo(size.width, bottom);

    canvas.drawPath(path, paint);   // path에 있는 좌표를 따라서 선을 그린다
  }

  void drawYText(Canvas canvas, String text, double fontSize, double y) {

    TextSpan span = TextSpan(
    style: TextStyle(
    fontSize: fontSize,
    color: Colors.black,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w600),
    text: text,
    );

    TextPainter tp = TextPainter(text: span, textDirection: TextDirection.ltr);

    tp.layout();

    Offset offset = Offset(0.0, y);
    tp.paint(canvas, offset);
  }

  List<Offset> getCoordinates(Size size) {
    List<Offset> coordinates = [];

    double maxData = data.reduce(max);

    double width = size.width - leftPadding;
    double minBarWidth = width / data.length;

    for (var index = 0; index < data.length; index++) {
    double left = minBarWidth * (index) + leftPadding; // 그래프의 가로 위치를 정합니다.
    double normalized = data[index] / maxData; // 그래프의 높이가 [0~1] 사이가 되도록 정규화 합니다.
    double height = size.height - bottomPadding; // x축에 표시되는 글자들과 겹치지 않게 높이에서 패딩을 제외합니다.
    double top = height - normalized * height; // 정규화된 값을 통해 높이를 구해줍니다.

    Offset offset = Offset(left, top);
    coordinates.add(offset);
    }

    return coordinates;
  }

  @override
  bool shouldRepaint(BarChart old) {   // shouldRepaint();  오버라이드한 위 클래스를 언제 다시 랜더링을 할 것인지 묻는 메서드 ; 좌표값이 변할 때 그린다던지 조건을 줌 paint
    return old.data != data;
  }
}