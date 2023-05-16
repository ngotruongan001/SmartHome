import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_home/modules/home/cubit/home_cubit.dart';
import 'package:smart_home/themes/app_dimension.dart';

class DarshBoardFirstFloor extends StatefulWidget {
  const DarshBoardFirstFloor({Key? key, required this.bloc, required this.statusConditionerNotifier, required this.statusTVNotifier, required this.tempConditionerNotifier}) : super(key: key);
  final HomeCubit bloc;
  final ValueNotifier<bool> statusConditionerNotifier;
  final ValueNotifier<bool> statusTVNotifier;
  final  ValueNotifier<int> tempConditionerNotifier;

  @override
  State<DarshBoardFirstFloor> createState() => _DarshBoardFirstFloorState();
}

class _DarshBoardFirstFloorState extends State<DarshBoardFirstFloor> {
  // ValueNotifier<bool> statusConditionerNotifier = ValueNotifier(false);
  // ValueNotifier<bool> statusTVNotifier = ValueNotifier(false);
  // ValueNotifier<int> tempConditionerNotifier = ValueNotifier(20);

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ValueListenableBuilder<bool>(
              valueListenable: widget.statusConditionerNotifier,
              builder: (context, value, _) {
                return Stack(
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
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          "assets/images/air-conditioner.png",
                                          width: 50.0,
                                          height: 50.0,
                                          fit: BoxFit.cover,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Switch(
                                        activeColor: Colors.yellow,
                                        value: value,
                                        onChanged: (bool val) {
                                          widget.statusConditionerNotifier.value = val;
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Air Condition",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        ValueListenableBuilder<int>(
                                            valueListenable:
                                            widget.tempConditionerNotifier,
                                            builder: (context, value1, _) {
                                              return Text(
                                                "$value1°C",
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              );
                                            }),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Temperature",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                      ]),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(onTap: (){
                                        widget.tempConditionerNotifier.value = widget.tempConditionerNotifier.value - 1;
                                      },child: Container(
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
                                      ),),
                                      InkWell(onTap: (){
                                        widget.tempConditionerNotifier.value = widget.tempConditionerNotifier.value + 1;
                                      },child: Container(
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
                                      ),),
                                    ],
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                  ],
                );
              }),
          Column(
            children: [
              ValueListenableBuilder<bool>(
                  valueListenable: widget.bloc.statusLedNotifier,
                  builder: (context, value, _) {
                    return Container(
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
                                'assets/images/lamp.jpg',
                                width: 1.sw,
                                height: 1.sh,
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
                                      Switch(
                                        activeColor: Colors.yellow,
                                        value: value,
                                        onChanged: (bool val) {
                                          widget.bloc.updateLed(val);
                                        },
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                    );
                  }),
              const SizedBox(
                height: 10,
              ),
              ValueListenableBuilder<bool>(
                  valueListenable: widget.statusTVNotifier,
                  builder: (context, value, _) {
                    return Container(
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
                                'assets/images/smarttv.jpg',
                                width: 1.sw,
                                height: 1.sh,
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
                                      Switch(
                                        activeColor: Colors.yellow,
                                        value: value,
                                        onChanged: (bool val) {
                                          widget.statusTVNotifier.value = val;
                                        },
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                    );
                  }),
            ],
          )
        ],
      ),
    );
  }
}
