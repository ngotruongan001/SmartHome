import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_home/common/widgets/bottom_bar.dart';
import 'package:smart_home/data/respository.dart';
import 'package:smart_home/data/socket.dart';
import 'package:smart_home/utils/local_storage.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({Key? key}) : super(key: key);

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {
  // var bloc = HomeCubit();

  var delay = 5;
  var repo = Repository();


  @override
  void initState() {
    // bloc.getUserWeatherLocation();
    super.initState();
    navigateOnBarbottom();
    repo.saveTokenFCM(LocalStorage.getString(LocalStorageKey.tokenFCM));
    String userId = LocalStorage.getString(LocalStorageKey.userId);
    try {
      SocketServer.on('connect', (data) {
        print('Connected to Socket.IO server long');
        print('server long: $data');
        SocketServer.emit('joinUser', {'_id': userId});
      });
    }catch(e){
      print("Connect failed!!");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 300,
                width: 300,
                child: Lottie.asset('assets/json/loading2.json')),
            SizedBox(height: 30),
            Text(
              "Loading...",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange),
            ),
          ],
        ),
      ),
    );
  }

  void  navigateOnBarbottom() async{
    await Timer(Duration(seconds: delay), (){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomBar(),
        ),
      );
    });
  }
}
