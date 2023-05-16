import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/common/widgets/Widget/Rooms/AntiTheft.dart';
import 'package:smart_home/common/widgets/Widget/Rooms/Fire.dart';
import 'package:smart_home/common/widgets/Widget/Rooms/Humidity.dart';
import 'package:smart_home/common/widgets/Widget/Rooms/Light.dart';
import 'package:smart_home/common/widgets/Widget/Rooms/Temperature.dart';
import 'package:smart_home/common/widgets/Widget/Rooms/TopButton.dart';
import 'package:smart_home/modules/home/cubit/home_cubit.dart';
import 'package:smart_home/themes/theme_provider.dart';

class Room extends StatefulWidget {
  final String title;
  final String floor;
  final HomeCubit bloc;
  const Room({
    Key? key,
    required this.floor,
    required this.title,
    required this.bloc,
  }) : super(key: key);

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  ValueNotifier<int> setI = ValueNotifier(0);
  @override
  void initState(){
    super.initState();
  }

  handleClick(i) {
    setI.value = i;
  }

  Widget build(BuildContext context) {
    var _page = [
      Temperature(bloc: widget.bloc),
      Humidity(bloc: widget.bloc),
      LightPage(
        bloc: widget.bloc,
        floor: widget.floor,
        title: widget.title,
      ),
      FirePage(bloc: widget.bloc,),
      AntiTheft(bloc: widget.bloc,)
    ];

    return ValueListenableBuilder<int>(
        valueListenable: setI,
        builder: (context, value, _) {
          return Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Tầng ${widget.floor}",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: context.watch<ThemeProvider>().textColor),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "${widget.title}",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: context.watch<ThemeProvider>().textColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    TopButton(handleClick: handleClick, setId: value),
                    _page[value]
                  ],
                ),
              ),
            ),
          );
        });


  }
}
