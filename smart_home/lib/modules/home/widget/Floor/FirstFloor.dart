import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/modules/home/cubit/home_cubit.dart';
import 'package:smart_home/modules/home/widget/Floor/CardRoom.dart';

class FirstFloor extends StatefulWidget {
  const FirstFloor({Key? key, required this.bloc}) : super(key: key);
  final HomeCubit bloc;

  @override
  State<FirstFloor> createState() => _FirstFloorState();
}

class _FirstFloorState extends State<FirstFloor> {
  @override
  void initState() {
    super.initState();
  }

  var arrayRoom = [
    {
      'title': "Living Room",
      'image': 'assets/images/livingroom.jpg',
      'floor': 1
    },
    {
      'title': "Kitchen Room",
      'image': 'assets/images/kitchenroom.jpg',
      'floor': 1
    },
    {'title': "Bed Room", 'image': 'assets/images/bedroom.jpg', 'floor': 1},
    {
      'title': "Living Room",
      'image': 'assets/images/livingroom.jpg',
      'floor': 1
    },
  ];

  @override
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
