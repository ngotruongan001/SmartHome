import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/modules/home/cubit/home_cubit.dart';
import 'package:smart_home/modules/home/widget/Floor/CardRoom.dart';

class ThirdFloor extends StatefulWidget {
  const ThirdFloor({Key? key, required this.bloc}) : super(key: key);
  final HomeCubit bloc;

  @override
  State<ThirdFloor> createState() => _ThirdFloorState();
}

class _ThirdFloorState extends State<ThirdFloor> {

  @override
  void initState() {
    super.initState();
  }

  var arrayRoom = [
    {
      'title': "Terrace",
      'image': 'assets/images/terrace.jpg',
      'floor': 3,
    },
    {
      'title': "Bed Room",
      'image': 'assets/images/bedroomt2.jpg',
      'floor': 3,
    },
    {
      'title': "Bath Room",
      'image': 'assets/images/bathroom2.jpg',
      'floor': 3,
    },
  ];

  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(25),
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          crossAxisCount: 2,
          children: arrayRoom
              .map(
                (e) => CardRoom(
                  bloc: widget.bloc,
              title: e['title'].toString(),
              image: e['image'].toString(),
              floor: e['floor'].toString(),
            ),
          )
              .toList()),
    );
  }
}
