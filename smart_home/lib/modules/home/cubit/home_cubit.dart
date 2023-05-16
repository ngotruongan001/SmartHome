import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:smart_home/data/respository.dart';
import 'package:smart_home/data/socket.dart';
import 'package:smart_home/models/infoDevice.dart';
import 'package:smart_home/models/user_token_model.dart';
import 'package:smart_home/models/weather.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  var repo = Repository();
  var _weather = Weather();
  ValueNotifier<int> floorCurrentNotifier = ValueNotifier(0);

  ValueNotifier<num> tempDataNotifier = ValueNotifier(0);
  ValueNotifier<num> humiDataNotifier = ValueNotifier(0);
  ValueNotifier<bool> statusLedNotifier = ValueNotifier(false);

  ValueNotifier<int> countTheftTodayNotifier = ValueNotifier(0);
  ValueNotifier<int> countTheftMonthNotifier = ValueNotifier(0);
  ValueNotifier<int> ppmNotifier = ValueNotifier(0);
  ValueNotifier<UserTokenModel> userTokenNotifier = ValueNotifier(new UserTokenModel());


  void initHomeCubit(){
    SocketServer.on('testLight', (data) {
      print('testLight, $data');
      statusLedNotifier.value = data == 1;
    });

    SocketServer.on('testTemHumi', (data) {
      print("data $data");
      num t = data['temp'];
      num h = data['humi'];
      tempDataNotifier.value = t;
      humiDataNotifier.value = h;
      updateInfoPPM();
    });
    SocketServer.on('antiTheft', (data) {
      updateHandelCountTheft();
    });

  }

  void getInfoDevice() async {
    InfoDevice dataDevice = await repo.getInfoDevice();
    var temperature = dataDevice.temperature!.data ?? 0;
    var humidity = dataDevice.humidity!.data ?? 0;
    tempDataNotifier.value = temperature;
    humiDataNotifier.value = humidity;
    statusLedNotifier.value = dataDevice.led!.status == 1;
    ppmNotifier.value = dataDevice.antiFire!.PPM ?? 0;
    updateHandelCountTheft();
    getInfoUserToken();
    initHomeCubit();
  }

  void updateInfoPPM() async {
    InfoDevice dataDevice = await repo.getInfoDevice();
    ppmNotifier.value = dataDevice.antiFire!.PPM ?? 0;
  }

  void getInfoUserToken() async{
    await repo.getTokenUserNotify(handleAddSuccess,handelFailed);
  }

  void handleAddSuccess(UserTokenModel data){
    userTokenNotifier.value = data;
    print("userTokenNotifier.value: ${userTokenNotifier.value}");
  }

  void updateHandelCountTheft() async{
    await repo.getNumberNotify(handleChangecountTheftToday, handelFailed,reqUrl: 'today');
    await repo.getNumberNotify(handleChangecountTheftMonth, handelFailed,reqUrl: 'month');
  }

  void updateLed(bool val){
    SocketServer.emit('testLight', val ? 1 : 0);
  }

  void getUserWeatherLocation() async {
    print('initial...');
    try {
      emit(HomeGetDataLoading());
      await Geolocator.requestPermission().then((value) async {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        print('position: ${position.latitude}');
        print('position: ${position.longitude}');
        await repo.getCurrentWeatherLocation(
          handleGetDataSuccess,
          handleGetDataFailed,
          lat: position.latitude,
          lon: position.longitude,
        );
      });
    } catch (e) {
      print("home failed!!!");
      handleGetDataFailed('Get data failed!!!');
    }
  }
  void handleGetDataSuccess(Weather weather) {
    print("Home success!!");
    _weather = weather;
    emit(HomeGetDataSuccess(_weather));
  }
  void handleGetDataFailed(String errorMessage) {
    print("Home failed!!");
    emit(HomeGetDataFailure(errorMessage));
  }
  void onChangeFloorNotifier(int value){
    floorCurrentNotifier.value = value;
  }

  void handleChangecountTheftToday(int value){
    countTheftTodayNotifier.value = value;
  }
  void handleChangecountTheftMonth(int value){
    countTheftMonthNotifier.value = value;
  }

  void handelFailed(){
    print("handel Failed");
  }

  void onPressedUpdateUserToken(dynamic body) async{
    if(userTokenNotifier.value.isNotifyAntiTheft! == body['isNotifyAntiTheft']){
      return;
    }
    if(userTokenNotifier.value.isNotifyAntiFire! == body['isNotifyAntiFire']){
      return;
    }
    if(userTokenNotifier.value.isNotifyWarningTemp! == body['isNotifyWarningTemp']){
      return;
    }
    if(userTokenNotifier.value.isNotifyRainAlarm! == body['isNotifyRainAlarm']){
      return;
    }
    repo.updateTokenNotify(handleUpdateTheftSucccess, handelFailed,body: body);
  }

  void handleUpdateTheftSucccess(){
    getInfoUserToken();
  }

}
