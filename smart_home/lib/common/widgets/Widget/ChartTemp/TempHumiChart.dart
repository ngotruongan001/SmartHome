import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/data/socket.dart';
import 'package:smart_home/modules/home/cubit/home_cubit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TempHumiChart extends StatefulWidget {
  TempHumiChart({Key? key, required this.bloc}) : super(key: key);
  final HomeCubit bloc;

  @override
  _TempHumiChartState createState() => _TempHumiChartState();
}

class _TempHumiChartState extends State<TempHumiChart> {
  ValueNotifier<List<LiveData>> chartData = ValueNotifier([]);
  ValueNotifier<List<LiveData>> chartData2 = ValueNotifier([]);

  late TooltipBehavior _tooltipBehavior;
  late ChartSeriesController _chartSeriesController;
  late ChartSeriesController _chartSeriesController2;

  num temperature = 0;
  num humidity = 0;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    chartData.value = getChartData();
    chartData2.value = getChartData2();
    SocketServer.on('testTemHumi', (data) {
      print("data temp: $data");
      num t = double.parse((data['temp']).toStringAsFixed(1));
      num h = double.parse((data['humi']).toStringAsFixed(1));
      updateDataSource(t);
      updateDataSource2(h);
    });

    // SocketServer.on('testTemHumi', (data){
    //   print("data $data");
    //   num t = data['temp'];
    //   num h = data['humi'];
    //   setState(() {
    //     temperature = t;
    //     humidity = h;
    //
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 500,
      child: ValueListenableBuilder<List<LiveData>>(
          valueListenable: chartData,
          builder: (context, value1, _) {
            return ValueListenableBuilder<List<LiveData>>(
                valueListenable: chartData2,
                builder: (context, value2, _) {
                  return SfCartesianChart(
                    title: ChartTitle(text: 'Temperature & Humidity'),
                    legend: Legend(isVisible: true),
                    tooltipBehavior: _tooltipBehavior,
                    series: <SplineSeries>[
                      SplineSeries<LiveData, double>(
                          onRendererCreated:
                              (ChartSeriesController controller) {
                            _chartSeriesController = controller;
                          },
                          name: 'Temperature',
                          dataSource: value1,
                          xValueMapper: (LiveData sales, _) => sales.time,
                          yValueMapper: (LiveData sales, _) => sales.speed,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          enableTooltip: true,
                          color: Colors.red,
                          width: 4,
                          opacity: 1,
                          dashArray: <double>[1, 1],
                          splineType: SplineType.cardinal,
                          cardinalSplineTension: 0.0),
                      SplineSeries<LiveData, double>(
                          onRendererCreated:
                              (ChartSeriesController controller2) {
                            _chartSeriesController2 = controller2;
                          },
                          name: 'Humidity',
                          dataSource: value2,
                          xValueMapper: (LiveData sales, _) => sales.time,
                          yValueMapper: (LiveData sales, _) => sales.speed,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          enableTooltip: true,
                          color: Colors.blueAccent,
                          width: 4,
                          opacity: 1,
                          dashArray: <double>[1, 1],
                          splineType: SplineType.cardinal,
                          cardinalSplineTension: 0.0),
                    ],
                    primaryXAxis: NumericAxis(
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                    ),
                  );
                });
          }),
    );
  }

  double time = 6;
  void updateDataSource(num data) {
    var newChart = chartData.value;
    newChart.add(LiveData(time += 5, data));
    newChart.removeAt(0);
    chartData.value = newChart;
    _chartSeriesController.updateDataSource(
        addedDataIndex: newChart.length - 1, removedDataIndex: 0);
  }

  double time2 = 6;
  void updateDataSource2(num data) {
    var newChart = chartData2.value;
    newChart.add(LiveData(time2 += 5, data));
    newChart.removeAt(0);
    chartData2.value = newChart;
    _chartSeriesController2.updateDataSource(
        addedDataIndex: newChart.length - 1, removedDataIndex: 0);
  }

  List<LiveData> getChartData2() {
    return <LiveData>[
      for(var i = 0; i < 5; i++) LiveData(i.toDouble(), widget.bloc.humiDataNotifier.value),
      // LiveData(0, 40),
      // LiveData(1, 45),
      // LiveData(2, 50),
      // LiveData(3, 55),
      // LiveData(4, 60),

    ];
  }

  List<LiveData> getChartData() {
    return <LiveData>[
      // LiveData(0, widget.bloc.humiDataNotifier.value),
      for(var i = 0; i < 5; i++) LiveData(i.toDouble(), widget.bloc.tempDataNotifier.value),

      // LiveData(1, 22),
      // LiveData(2, 15),
      // LiveData(3, 17),
      // LiveData(4, 18),
      // LiveData(5, 22)
    ];
  }
}

class LiveData {
  LiveData(this.time, this.speed);
  final double time;
  final num speed;
}
