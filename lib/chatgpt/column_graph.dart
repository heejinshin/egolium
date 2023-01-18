import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class GraphArea extends StatefulWidget {
  const GraphArea({Key? key}) : super(key: key);

  @override
  _GraphAreaState createState() => _GraphAreaState();
}

class _GraphAreaState extends State<GraphArea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/image/auth_background.png')
              )
          ),
        ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: Colors.white),
            width: 200,
            height: 250,
          ),
        ]
      ),
    );
  }
}


class ColumnGraphExample extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool animate;

  ColumnGraphExample(this.seriesList, {this.animate = true});

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Stack(
        children: [
          new charts.BarChart(seriesList,
              animate: animate,
              primaryMeasureAxis: new charts.NumericAxisSpec(
                    tickProviderSpec: new charts.StaticNumericTickProviderSpec(
                      <charts.TickSpec<num>>[
                        charts.TickSpec(0.8, label: ''),
                        charts.TickSpec(0, label: '0'),
                        charts.TickSpec(0.38, label: '0.38'),
                        charts.TickSpec(0.67, label: '0.67'),
                        charts.TickSpec(0.96, label: '0.96'),
                        charts.TickSpec(1.25, label: '1.25'),
                      ],
                    ),
              ))
        ],
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  final double yValue;

  MyCustomPainter({required this.yValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()
      ..color = Color.fromRGBO(0, 0, 0, 0.2)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    final double yPixel = (size.height - (yValue * size.height));
    canvas.drawLine(
      Offset(0, yPixel),
      Offset(size.width, yPixel),
      paint,
    );
  }

  @override
  bool shouldRepaint(MyCustomPainter oldDelegate) => false;
}

class ColumnGraph extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ColumnGraphState();
}

class ColumnGraphState extends State<ColumnGraph> {
  late List<charts.Series<dynamic, String>> seriesList;
  late bool animate;

  @override
  void initState() {
    super.initState();
    seriesList = _createSampleData();
    animate = true;
  }

  @override
  Widget build(BuildContext context) {
    return ColumnGraphExample(seriesList, animate: animate);
  }

  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('1', 0.35),
      new OrdinalSales('2', 1.2),
      new OrdinalSales('3', 0.65),
      new OrdinalSales('4', 0.67),
      new OrdinalSales('Today', 0.80),
    ];
    final data2 = [
      new OrdinalSales('1', 0.38),
      new OrdinalSales('2', 1.25),
      new OrdinalSales('3', 0.67),
      new OrdinalSales('4', 0.64),
      new OrdinalSales('Today', 0.81),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Mining Ratio',
        colorFn: (OrdinalSales sales, _) {
          if (sales.day == 'Today') {
            return charts.MaterialPalette.pink.shadeDefault;
          }
          return charts.MaterialPalette.blue.shadeDefault;
        },
        domainFn: (OrdinalSales sales, _) => sales.day,
        measureFn: (OrdinalSales sales, _) => sales.mining_ratio,
        data: data,
      ),

      new charts.Series<OrdinalSales, String>(
        id: 'Mining Ratio',
        colorFn: (OrdinalSales sales, _) {
          if (sales.day == 'Today') {
            return charts.MaterialPalette.purple.shadeDefault;
          }
          return charts.MaterialPalette.blue.shadeDefault;
        },
        // 그래프 색상
        domainFn: (OrdinalSales sales, _) => sales.day,
        // 열 제목
        measureFn: (OrdinalSales sales, _) => sales.mining_ratio,
        // 행 제목
        data: data2,
      )
    ];
  }
}

class OrdinalSales {
  // 그래프 데이터 정의
  final String day;
  final double mining_ratio;

  OrdinalSales(this.day, this.mining_ratio);
}
