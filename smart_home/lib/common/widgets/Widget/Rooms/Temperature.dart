import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/data/respository.dart';
import 'package:smart_home/data/socket.dart';
import 'package:smart_home/models/infoDevice.dart';
import 'package:smart_home/models/user_token_model.dart';
import 'package:smart_home/modules/home/cubit/home_cubit.dart';
import 'package:smart_home/themes/app_dimension.dart';
import 'package:smart_home/themes/theme_provider.dart';

class Temperature extends StatefulWidget {
  const Temperature({Key? key, required this.bloc}) : super(key: key);
  final HomeCubit bloc;

  @override
  State<Temperature> createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
  bool status = true;
  bool status1 = true;
  // ValueNotifier<num> temperature = ValueNotifier(0.0);
  // ValueNotifier<num> humidity = ValueNotifier(0.0);

  // var repo = Repository();
  @override
  void initState() {
    super.initState();
    // callApi();
    // SocketServer.on('testTemHumi', (data) {
    //   print("data $data");
    //   num t = data['temp'];
    //   num h = data['humi'];
    //   temperature.value = t;
    //   humidity.value = h;
    // });
  }
  // void callApi() {
  //   getNewsData();
  // }
  // getNewsData() async  {
  //   InfoDevice dataDevice = await repo.getInfoDevice();
  //   temperature.value = dataDevice.temperature!.data!;
  //   humidity.value = dataDevice.humidity!.data!;
  // }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<num>(
        valueListenable: widget.bloc.tempDataNotifier,
        builder: (context, value, _) {
          return Container(
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          CircularPercentIndicator(
                            // animation: true,
                            // animationDuration: 500,
                            radius: 220,
                            lineWidth: 15,
                            percent: value/100,
                            progressColor: context.watch<ThemeProvider>().progressColor,
                            backgroundColor: context.watch<ThemeProvider>().backgroundProgressColor,
                            circularStrokeCap: CircularStrokeCap.butt,
                            center: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Temp", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                    color: context.watch<ThemeProvider>().textColor
                                ),),
                                const SizedBox(height: 10,),
                                Text( '${value.toStringAsFixed(1)}°C', style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                    color: Colors.deepOrange
                                ),)
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),),
                  SizedBox(
                    height: 400 ,
                    child: GridView.count(
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      crossAxisCount: 2,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: context.watch<ThemeProvider>().cardDashBoard,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children:  [
                                      Text(
                                        "Sensor",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 19,
                                            color: context.watch<ThemeProvider>().textColor),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Switch(
                                        activeColor: Colors.deepOrange,
                                        value: status,
                                        onChanged: (bool val) {
                                          setState(() {
                                            status = val;
                                          });
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children:  [
                                      Text(
                                        "70%",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: context.watch<ThemeProvider>().textColor),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: const [
                                      Icon(
                                        Icons.remove_circle_outline,
                                        color: Colors.deepOrange,
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: const [
                                      Icon(
                                        Icons.add_circle,
                                        color: Colors.deepOrange,
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Temperature",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        color: context.watch<ThemeProvider>().textColor),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${value.toStringAsFixed(1)}°C',
                                    style:  TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: context.watch<ThemeProvider>().textColor),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        ValueListenableBuilder<UserTokenModel>(
                            valueListenable: widget.bloc.userTokenNotifier,
                            builder: (context, value1, child) {
                              return Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: context.watch<ThemeProvider>().cardDashBoard,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children:  [
                                            Text(
                                              "Sensor",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 19,
                                                  color: context.watch<ThemeProvider>().textColor),
                                            )
                                          ],
                                        ),
                                        Switch(
                                          activeColor: Colors.deepOrange,
                                          value: value1.isNotifyWarningTemp == true,
                                          onChanged: (bool val) async {
                                            var body = {
                                              "isNotifyWarningTemp": val,
                                            };
                                            widget.bloc.onPressedUpdateUserToken(body);
                                          },
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:  [
                                        Text(
                                          "Notification: ${value1.isNotifyWarningTemp == true ? "On" : "Off"}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: context.watch<ThemeProvider>().textColor, fontSize: 17),
                                        ),
                                        SizedBox(
                                          height: 6.r,
                                        ),

                                        Text(
                                          "Control notification of app Warning > 50°C",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              color: context.watch<ThemeProvider>().textColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),

                      ],
                    ),
                  ),
                ],
              ),
          );
        });
  }
}
