import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/modules/home/cubit/home_cubit.dart';

class DarshBoardThirdFloor extends StatefulWidget {
  const DarshBoardThirdFloor({Key? key, required this.bloc}) : super(key: key);
  final HomeCubit bloc;

  @override
  State<DarshBoardThirdFloor> createState() => _DarshBoardThirdFloorState();
}

class _DarshBoardThirdFloorState extends State<DarshBoardThirdFloor> {
  ValueNotifier<bool> statusConditionerNotifier = ValueNotifier(false);
  ValueNotifier<bool> statusTVNotifier = ValueNotifier(false);
  ValueNotifier<bool> statusLightNotifier = ValueNotifier(false);
  ValueNotifier<int> tempConditionerNotifier = ValueNotifier(20);

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: tempConditionerNotifier,
        builder: (context, temp, _) {
          return Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'assets/images/bedroom.jpg',
                          width: 180.0,
                          height: 300.0,
                          fit: BoxFit.cover,
                        )),
                    Positioned(
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 180,
                              height: 300,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        child: Image.asset(
                                          "assets/images/air-conditioner.png",
                                          width: 50.0,
                                          height: 50.0,
                                          fit: BoxFit.cover,
                                          color: Colors.white,
                                        ),
                                      ),
                                      ValueListenableBuilder<bool>(
                                          valueListenable:
                                          statusConditionerNotifier,
                                          builder: (context, value, _) {
                                            return Switch(
                                              activeColor: Colors.yellow,
                                              value: value,
                                              onChanged: (bool val) {
                                                statusConditionerNotifier
                                                    .value = val;
                                              },
                                            );
                                          }),

                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 0, 0, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children:  [
                                        Text(
                                          "Air Condition",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight:
                                              FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "${temp}°C",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight:
                                              FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Temperature",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight:
                                              FontWeight.w300,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 130,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(20),
                                            // border: Border.all(color: Colors.deepOrange, width: 2)
                                          ),
                                          child: const Center(
                                              child: Text(
                                                "Automatic",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 16),
                                              )),
                                        ),

                                      ]
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          tempConditionerNotifier.value =
                                              tempConditionerNotifier.value - 1;
                                        },
                                        child: Container(
                                          width: 50,
                                          height: 25,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(20),
                                            // border: Border.all(color: Colors.deepOrange, width: 2)
                                          ),
                                          child: const Center(
                                              child: Text(
                                                "-",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold),
                                              )),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          tempConditionerNotifier.value =
                                              tempConditionerNotifier.value + 1;
                                        },
                                        child: Container(
                                          width: 50,
                                          height: 25,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(20),
                                            // border: Border.all(color: Colors.deepOrange, width: 2)
                                          ),
                                          child: const Center(
                                              child: Text(
                                                "+",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 23,
                                                    fontWeight: FontWeight.bold),
                                              )),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),

                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 160,
                      height: 145,
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/light4.jpg',
                                width: 180.0,
                                height: 300.0,
                                fit: BoxFit.cover,
                              )),
                          Positioned(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(0.0),
                                        child: Image.asset(
                                          "assets/images/light-bulb.png",
                                          width: 40.0,
                                          height: 35.0,
                                          fit: BoxFit.cover,
                                          color: Colors.white,
                                        ),
                                      ),
                                      ValueListenableBuilder<bool>(
                                          valueListenable: statusLightNotifier,
                                          builder: (context, value, _) {
                                            return Switch(
                                              activeColor: Colors.yellow,
                                              value: value,
                                              onChanged: (bool val) {
                                                statusLightNotifier.value = val;
                                              },
                                            );
                                          }),

                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Smart Lamp",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "OFF",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Active for 8h",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                        ],

                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 160,
                      height: 145,
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/tv4.jpg',
                                width: 180.0,
                                height: 300.0,
                                fit: BoxFit.cover,
                              )),
                          Positioned(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(0.0),
                                        child: Image.asset(
                                          "assets/images/television.png",
                                          width: 40.0,
                                          height: 35.0,
                                          fit: BoxFit.cover,
                                          color: Colors.white,
                                        ),
                                      ),
                                      ValueListenableBuilder<bool>(
                                          valueListenable: statusTVNotifier,
                                          builder: (context, value, _) {
                                            return Switch(
                                              activeColor: Colors.yellow,
                                              value: value,
                                              onChanged: (bool val) {
                                                statusTVNotifier.value = val;

                                              },
                                            );
                                          }),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Smart TV",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "OFF",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Active for 8h",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                        ],

                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });

  }
}
