import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:smart_home/authentication/auth_services.dart';
import 'package:smart_home/models/MessageModel.dart';
import 'package:smart_home/models/infoDevice.dart';
import 'package:smart_home/models/user_token_model.dart';
import 'package:smart_home/models/weather.dart';
import 'package:smart_home/modules/login/login/models/request_user.dart';
import 'package:smart_home/modules/login/register/models/request_register_user.dart';
import 'package:smart_home/models/response_data_user.dart';
import 'package:smart_home/utils/local_storage.dart';

class Repository {
  final dio = Dio();
  final _auth = FirebaseAuth.instance;
  Future<void> login(
      Function(ResponseDataUser) onSuccess, Function(String) onFailure,
      {required RequestUser requestUser}) async {
    try {
      print("requestUser: $requestUser");
      dio
          .post("https://demo-ws.onrender.com/api/login",
              data: requestUser.toJson())
          .then(
        (value) {
          print("data: ${value.data}");
          var res = ResponseDataUser.fromJson(value.data);
          onSuccess(res);
        },
      ).catchError((e) {
        onFailure("login failed!! or This email does not exist.");
      });
    } catch (e) {
      onFailure("login failed!!");
    }
  }

  Future<InfoDevice> getInfoDevice() async {
    try {
      var data = await dio.get(
        "https://demo-ws.onrender.com/api/drives",
      );
      print("value!! $data");
      var res = InfoDevice.fromJson(data.data);
      print("get success!! $res");
      return res;
    } catch (e) {
      print('get failed!! ,$e');
      rethrow;
    }
  }

  Future<void> getNumberNotify(Function(int) onSuccess, Function onFailed,{required String reqUrl}) async {
    try {
      var value = await dio.get(
        "https://demo-ws.onrender.com/api/count-notify-theft-$reqUrl",
      ).then((value){
        int data = value.data['count'];
        onSuccess(data);
      }).catchError((e){
        print('get failed!! ,$e');
        onFailed();
      });
    } catch (e) {
      print('get failed!! ,$e');
      onFailed();
      rethrow;
    }
  }
  
  Future<void> getTokenUserNotify(Function(UserTokenModel) onSuccess, Function onFailed) async {
    try {
      var token = LocalStorage.getString(LocalStorageKey.tokenFCM);
      var value = await dio.get(
        "https://demo-ws.onrender.com/api/token-notify/$token",
      ).then((value){
        var data = UserTokenModel.fromJson(value.data);
        print("data token user: $data");
        onSuccess(data);
      }).catchError((e){
        print('get failed!! ,$e');
        onFailed();
      });
    } catch (e) {
      print('get failed!! ,$e');
      onFailed();
      rethrow;
    }
  }

  Future<void> updateTokenNotify(Function() onSuccess, Function onFailed, {required dynamic body}) async {
    try {
      var token = LocalStorage.getString(LocalStorageKey.tokenFCM);
      var value = await dio.put(
        "https://demo-ws.onrender.com/api/update-token-notify/$token",
        data: body
      ).then((value){
        print("value: $value");
        onSuccess();
      }).catchError((e){
        print('get failed!! ,$e');
        onFailed();
      });
    } catch (e) {
      print('get failed!! ,$e');
      onFailed();
      rethrow;
    }
  }

  Future<List<MessageModel>> getMessageNotify() async {
    try {
      var value = await dio.get(
        "https://demo-ws.onrender.com/api/notifies",
        options: Options(
            headers: {
              "Authorization": LocalStorage.getString(LocalStorageKey.access_token)
            },
           
        ),
      );
      var data = value.data;
      print("data msg: $data");
      List<MessageModel> _list = [];
      for(var i in data){
        _list.add(MessageModel.fromJson(i));
      }
      return _list;
    } catch (e) {
      print('get failed!! ,$e');
      rethrow;
    }
  }

  Future<void> saveTokenFCM(String token) async {
    try {
      dio.post(
        "https://demo-ws.onrender.com/api/token-notify",
        data: {
          'userId': LocalStorage.getString(LocalStorageKey.userId),
          'token': token,
        },
      ).then(
        (value) {
          print("Save success!!");
        },
      ).catchError((e) {
        print('save failed!! ,$e');
      });
    } catch (e) {
      print('save failed!! ,$e');
    }
  }

  Future<void> saveLogin() async {
    try {
      dio.post(
        "https://demo-ws.onrender.com/api/savelogin/create",
        data: {
          'userId': LocalStorage.getString(LocalStorageKey.userId),
          'token': LocalStorage.getString(LocalStorageKey.tokenFCM),
        },
      ).then(
            (value) {
          print("Save success!!");

        },
      ).catchError((e) {
        print('save failed!! ,$e');
      });
    } catch (e) {
      print('save failed!! ,$e');
    }
  }
  Future<void> saveFeedback(Function onSuccess, Function onFailed,{required String description}) async {
    try {
      dio.post(
        "https://demo-ws.onrender.com/api/feedback/create",
        data: {
          'userId': LocalStorage.getString(LocalStorageKey.userId),
          'description': description,
        },
      ).then(
            (value) {
          print("Save success!!");
          onSuccess();
        },
      ).catchError((e) {
        print('save failed!! ,$e');
        onFailed();
      });
    } catch (e) {
      print('save failed!! ,$e');
      onFailed();
    }
  }

  Future<void> register(
      Function(ResponseDataUser) onSuccess, Function(String) onFailure,
      {required RequestRegisterUser requestRegisterUser}) async {
    try {
      print("value: $requestRegisterUser");

      dio
          .post(
        "https://demo-ws.onrender.com/api/register",
        data: requestRegisterUser.toJson(),
      )
          .then(
        (value) {
          print("value: $value");
          var res = ResponseDataUser.fromJson(value.data);
          onSuccess(res);
        },
      ).catchError((e) {
        print("E: $e");
        onFailure("register failed!! (user name or email existed!!!)");
      });
    } catch (e) {
      onFailure("register failed!! (user name or email existed!!!)");
    }
  }

  // Future<void> handleUpdateLightLed(bool isActive) async {
  //   try {
  //     dio.post("https://nodejs-276x.vercel.app/api/drive", data: {
  //       "AntiFire": {"PPM": 0, "Status": "no"},
  //       "AntiTheft": {"Status": "no", "Times": 9},
  //       "Humidity": {"Data": 62.3},
  //       "Led": {"Status": isActive ? 1 : 0},
  //       "RainAlarm": {"Status": "no"},
  //       "Temperature": {"Data": 26.5}
  //     });
  //   } catch (e) {
  //     throw e;
  //   }
  // }
  //
  // Future<void> loginGmail(
  //     Function onSuccess, Function(String) onFailure) async {
  //   try {
  //     await FirebaseServices()
  //         .signInWithGoogle()
  //         .then((value) => print("value: $value"));
  //     onSuccess();
  //   } catch (e) {
  //     onFailure("Login failed!!!");
  //   }
  // }

  Future<void> getCurrentWeatherLocation(
    Function(Weather) onSuccess,
    Function(String) onFailure, {
    required double lat,
    required double lon,
  }) async {
    try {
      String apiKey = "026de487fd6c8b4cc0bb10493dd97183";
      var url =
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";
      print("url: $url");
      await dio.get(url).then((value) {
        var weather = Weather.fromJson(value.data);
        onSuccess(weather);
      });
    } catch (e) {
      onFailure("Get data failed");
    }
  }
}
