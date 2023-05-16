import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:smart_home/models/MessageModel.dart';

class DataProvider extends ChangeNotifier {
  List<MessageModel> list = [];

  void fetchApiMessage() async {
    try {
      List<MessageModel> _newList = [];
      var response = await Dio().get('https://demo-ws.onrender.com/api/notify');
      print("response");
      // Message newsResponse = Message.fromJson(response.data);
      var m = response.data;
      for(var i in m){
        _newList.add(new MessageModel.fromJson(i));
      }
      for(var i in _newList){
        print("title: "+i.title+" - "+i.body+" - "+i.status+" - "+i.createdAt);
      }
      list = _newList;
      notifyListeners();
    } catch (e) {
      print("err");
      print(e);
    }
  }
}