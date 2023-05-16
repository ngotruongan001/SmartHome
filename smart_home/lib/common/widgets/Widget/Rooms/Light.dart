import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/data/respository.dart';
import 'package:smart_home/data/socket.dart';
import 'package:smart_home/models/infoDevice.dart';
import 'package:smart_home/modules/home/cubit/home_cubit.dart';
import 'package:smart_home/themes/theme_provider.dart';

class LightPage extends StatefulWidget {
  final String title;
  final String floor;
  final HomeCubit bloc;

  const LightPage({Key? key, required this.floor, required this.title, required this.bloc})
      : super(key: key);
  @override
  State<LightPage> createState() => _LightPageState();
}

class _LightPageState extends State<LightPage> {
  // late bool ledstatuslight1 =
  //     false; //boolean value to track LED status, if its ON or OFF
  //  var repo = Repository();

  // late bool connected; //boolean value to track if WebSocket is connected
  @override
  void initState() {
    super.initState();
    // callApi();
    // SocketServer.on('testLight', (data) {
    //   print('testLight, $data');
    //   setState(() {
    //     ledstatuslight1 = data == 1;
    //   });
    // });
  }
  //
  // void callApi() {
  //   getNewsData();
  // }
  // getNewsData() async  {
  //   InfoDevice dataDevice = await repo.getInfoDevice();
  //   setState(() {
  //     ledstatuslight1 = dataDevice.led!.status == 1;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: widget.bloc.statusLedNotifier,
        builder: (context, value, _) {
          return SingleChildScrollView(
            child: Container(
                height: 800,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                            child: (value == true)
                                ? SizedBox(
                                width: 150,
                                child: Image.asset("assets/icons/on.png"))
                                : SizedBox(
                                width: 150,
                                child: Image.asset("assets/icons/off.png")),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            height: 400,
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
                                    color:
                                    context.watch<ThemeProvider>().cardDashBoard,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                "Light 1",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 19,
                                                    color: context
                                                        .watch<ThemeProvider>()
                                                        .textColor),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Switch(
                                                activeColor: Colors.deepOrange,
                                                value: value,
                                                onChanged: (bool val) async {
                                                  // onPressedTurnOffOn(val);
                                                  widget.bloc.updateLed(val);
                                                },
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                "70%",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: context
                                                        .watch<ThemeProvider>()
                                                        .textColor),
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
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Watt total power consumption",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w200,
                                                color: context
                                                    .watch<ThemeProvider>()
                                                    .textColor),
                                          ),
                                          Text('12KW/H',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: context
                                                    .watch<ThemeProvider>()
                                                    .textColor,
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ],
                )),
          );
        });

  }
  // void onPressedTurnOffOn(bool val){
  //   SocketServer.emit('testLight', val ? 1 : 0);
  // }
}
