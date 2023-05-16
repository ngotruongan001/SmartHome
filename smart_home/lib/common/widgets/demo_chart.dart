import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:smart_home/common/widgets/card/card_design.dart';
import 'package:smart_home/themes/app_colors.dart';
import 'package:smart_home/themes/app_dimension.dart';
import 'package:smart_home/themes/styles_text.dart';
import 'package:smart_home/utils/app_images.dart';

class DemoWidgetChart extends StatefulWidget {
  const DemoWidgetChart({Key? key}) : super(key: key);

  @override
  State<DemoWidgetChart> createState() => _DemoWidgetChartState();
}

class _DemoWidgetChartState extends State<DemoWidgetChart> {
  double temperature = 0;
  double humidity = 0;
  late List<double> listDatTemp = [18, 32, 30, 31, 25];
  late List<double> listDataHumi = [40, 45, 50, 55, 60];

  @override
  void initState() {
    super.initState();
    Timer.periodic(
      const Duration(seconds: 5),
          (timer) {
        updateData();
      },
    );
  }

  void updateData() {
    temperature =  Random().nextDouble() * 50;
    humidity =  Random().nextDouble() * 90;

    setState(() {
      listDatTemp.add(temperature);
      listDatTemp.removeAt(0);
      listDataHumi.add(humidity);
      listDataHumi.removeAt(0);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.r),
      child: Column(
        children: [
          Center(
            child: Text('Temperature & Humidity'),
          ),
          SizedBox(
            height: 20.0.h,
          ),
          SizedBox(
            height: 400.0.h,
            width: 1.sw,
            child: _LineChart(
              listDataHumi: listDataHumi,
              listDatTemp: listDatTemp,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "",
                style: StylesText.caption1.copyWith(color: AppColors.neutral8),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _LineChart extends StatelessWidget {
  const _LineChart({required this.listDataHumi, required this.listDatTemp});
  final List<double> listDataHumi;
  final List<double> listDatTemp;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData1,
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
    lineTouchData: lineTouchData1,
    gridData: gridData,
    titlesData: titlesData1,
    borderData: FlBorderData(
      show: true,
      border:  Border(
        left: BorderSide(color: AppColors.border),
        top: BorderSide(color: AppColors.border),
        bottom: BorderSide(color: AppColors.border),
        right: BorderSide(color: AppColors.border),
      ),
    ),
    lineBarsData: lineBarsData1,
    minX: 0,
    maxX: 4,
    maxY: 100,
    minY: 0,
  );

  LineTouchData get lineTouchData1 => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      tooltipBgColor: AppColors.white,
    ),
  );

  FlTitlesData get titlesData1 => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles,
    ),
    rightTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    leftTitles: AxisTitles(
      sideTitles: leftTitles(),
    ),
  );

  List<LineChartBarData> get lineBarsData1 => [
    lineChartBarData1_1,
    lineChartBarData1_2,
  ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 10:
        text = '10';
        break;
      case 20:
        text = '20';
        break;
      case 30:
        text = '30';
        break;
      case 40:
        text = '40';
        break;
      case 50:
        text = '50';
        break;
      case 60:
        text = '60';
        break;
      case 70:
        text = '70';
        break;
      case 80:
        text = '80';
        break;
      case 90:
        text = '90';
        break;
      case 100:
        text = '100';
        break;
      default:
        return Container();
    }
    return Text(
      text,
      style: StylesText.body6.copyWith(color: AppColors.neutral8),
      textAlign: TextAlign.center,
    );
  }

  SideTitles leftTitles() => SideTitles(
    getTitlesWidget: leftTitleWidgets,
    showTitles: true,
    interval: 1,
    reservedSize: 40,
  );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text('$value'),
    );
  }

  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: 32,
    interval: 1,
    getTitlesWidget: bottomTitleWidgets,
  );

  FlGridData get gridData => FlGridData(show: true);

  FlBorderData get borderData => FlBorderData(
    show: true,
    border: Border(
      bottom: BorderSide(color: AppColors.primary1, width: 2),
      left: const BorderSide(color: Colors.transparent),
      right: const BorderSide(color: Colors.transparent),
      top: const BorderSide(color: Colors.transparent),
    ),
  );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
      color: Colors.red,
      barWidth: 5,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: [
        for (var i = 0; i < listDatTemp.length; i++)
          FlSpot(i.toDouble(), listDatTemp[i])
      ]

  );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
      color: AppColors.primary1,
      barWidth: 5,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: [
        for (var i = 0; i < listDataHumi.length; i++)
          FlSpot(i.toDouble(), listDataHumi[i])
      ]
  );
}