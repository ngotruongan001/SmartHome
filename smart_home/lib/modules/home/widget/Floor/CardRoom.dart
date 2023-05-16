import 'package:flutter/material.dart';
import 'package:smart_home/data/respository.dart';
import 'package:smart_home/data/socket.dart';
import 'package:smart_home/models/infoDevice.dart';
import 'package:smart_home/modules/home/cubit/home_cubit.dart';
import 'package:smart_home/modules/room/Room.dart';

class CardRoom extends StatefulWidget {
  final String title;
  final String image;
  final String floor;
  final HomeCubit bloc;

  const CardRoom({
    Key? key,
    required this.title,
    required this.image,
    required this.floor,
    required this.bloc,
  }) : super(key: key);

  @override
  State<CardRoom> createState() => _CardRoomState();
}

class _CardRoomState extends State<CardRoom> {

  @override
  void initState() {
    // callApi();
    // SocketServer.on('testTemHumi', (data){
    //   print("data temp: $data");
    //   num t = data['temp'];
    //   num h = data['humi'];
    //   dataNotifier.value = Temp(t, h);
    // });
    super.initState();
  }
  //
  // void callApi() {
  //   getNewsData();
  // }
  // getNewsData() async  {
  //   InfoDevice dataDevice = await repo.getInfoDevice();
  //   var temperature = dataDevice.temperature!.data!;
  //   var humidity = dataDevice.humidity!.data!;
  //   dataNotifier.value = Temp(temperature, humidity);
  // }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<num>(
        valueListenable: widget.bloc.tempDataNotifier,
        builder: (context, temp, _) {
          return ValueListenableBuilder<num>(
              valueListenable: widget.bloc.humiDataNotifier,
              builder: (context, humi, _) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Room(
                              bloc: widget.bloc,
                              floor: widget.floor,
                              title: widget.title,
                            )));
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            widget.image,
                            width: 180.0,
                            height: 200.0,
                            fit: BoxFit.cover,
                          )),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(15),
                            backgroundBlendMode: BlendMode.darken),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 0, right: 8, top: 8, bottom: 8),
                                child: Text("${widget.title}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Container(
                                    width: 150,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Temp",
                                              style: TextStyle(
                                                  color: Colors.black, fontSize: 14),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "${temp.toStringAsFixed(1) ?? '0'}°C",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const Text(
                                              "Humi",
                                              style: TextStyle(
                                                  fontSize: 14, color: Colors.black),
                                            ),
                                            const SizedBox(height: 10),
                                            Text("${humi.toStringAsFixed(1) ?? '0'}%",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                        Column(
                                          children: const [
                                            Text("Devi",
                                                style: TextStyle(
                                                    fontSize: 14, color: Colors.black)),
                                            SizedBox(height: 10),
                                            Text("5",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 14)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              });

        });
  }
}
