import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/common/widgets/ChooseFloor.dart';
import 'package:smart_home/common/widgets/Widget/ChartTemp/TempHumiChart.dart';
import 'package:smart_home/common/widgets/Widget/DashBoard/DarshBoard_FirstFloor.dart';
import 'package:smart_home/common/widgets/Widget/DashBoard/DarshBoard_SecondFloor.dart';
import 'package:smart_home/common/widgets/Widget/DashBoard/DarshBoard_ThirdFloor.dart';
import 'package:smart_home/common/widgets/demo_chart.dart';
import 'package:smart_home/modules/home/cubit/home_cubit.dart';
import 'package:smart_home/themes/theme_provider.dart';
import 'package:smart_home/utils/local_storage.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key, required this.bloc}) : super(key: key);
  final HomeCubit bloc;

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool status = false;
  late Timer timer;
  ValueNotifier<DateTime> dateTime = ValueNotifier(DateTime.now());
  ValueNotifier<int> setId = ValueNotifier(0);

  ValueNotifier<bool> statusConditionerNotifier = ValueNotifier(false);
  ValueNotifier<bool> statusTVNotifier = ValueNotifier(false);
  ValueNotifier<bool> statusLightNotifier = ValueNotifier(false);
  ValueNotifier<int> tempConditionerNotifier = ValueNotifier(20);

  handleClick(i) {
    setId.value = i;
  }

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      dateTime.value = DateTime.now();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    // var formatTime = DateFormat('HH:mm').format(now);
    // var formattedDate = DateFormat('EEE, d MMM').format(now);
    // var timezoneString = now.timeZoneOffset.toString().split('.').first;
    // var offsetSign = '';
    // if (!timezoneString.startsWith('-')) offsetSign = '+';
    var _page = [
      DarshBoardFirstFloor(
        bloc: widget.bloc,
        statusConditionerNotifier: statusConditionerNotifier,
        statusTVNotifier: statusTVNotifier,
        tempConditionerNotifier: tempConditionerNotifier,
      ),
      DarshBoardSecondFloor(
        bloc: widget.bloc,
      ),
      DarshBoardThirdFloor(
        bloc: widget.bloc,
      ),
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              _widgetTopInfo(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: context.watch<ThemeProvider>().weatherCard,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(
                                      0, 1), // changes position of shadow
                                )
                              ]),
                          child: ValueListenableBuilder<DateTime>(
                              valueListenable: dateTime,
                              builder: (context, value, _) {
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          "assets/images/clock.png",
                                          width: 35.0,
                                          height: 35.0,
                                          fit: BoxFit.cover,
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Time now ",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w100,
                                            color: context
                                                .watch<ThemeProvider>()
                                                .textColor),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${DateFormat('HH:mm').format(value)} | ${DateFormat('EEE, d MMM').format(value)} ",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: context
                                                .watch<ThemeProvider>()
                                                .textColor),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: context.watch<ThemeProvider>().weatherCard,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(
                                      0, 1), // changes position of shadow
                                )
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    "assets/images/flash.png",
                                    width: 35.0,
                                    height: 35.0,
                                    fit: BoxFit.cover,
                                    color: Colors.deepOrange,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Electric used",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w100,
                                      color: context
                                          .watch<ThemeProvider>()
                                          .textColor),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "5 Kw/h | 0.8 \$ ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: context
                                          .watch<ThemeProvider>()
                                          .textColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  decoration: BoxDecoration(
                      color: context.watch<ThemeProvider>().cardDashBoard,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        )
                      ]),
                  child: ValueListenableBuilder<int>(
                      valueListenable: setId,
                      builder: (context, value, _) {
                        return Column(
                          children: [
                            ChooseFloor(handleClick: handleClick, setId: value),
                            _page[value],
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        );
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  decoration: BoxDecoration(
                      color: context.watch<ThemeProvider>().cardDashBoard,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        )
                      ]),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TempHumiChart(bloc: widget.bloc),
                      // DemoWidgetChart(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _widgetTopInfo() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
      height: 80,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome",
                    style: TextStyle(
                        fontSize: 20,
                        color: context.watch<ThemeProvider>().textColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    LocalStorage.getString(LocalStorageKey.fullname),
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: context.watch<ThemeProvider>().textColor),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: LocalStorage.getString(LocalStorageKey.avatar).isNotEmpty ? Image.network(
                    LocalStorage.getString(LocalStorageKey.avatar),
                    width: 60.0,
                    height: 60.0,
                    fit: BoxFit.cover,
                  ): Image.asset(
                    'assets/images/ngotruongan.jpg',
                    width: 60.0,
                    height: 60.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}
