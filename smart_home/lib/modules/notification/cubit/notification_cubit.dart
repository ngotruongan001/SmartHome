import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:smart_home/data/respository.dart';
import 'package:smart_home/data/socket.dart';
import 'package:smart_home/models/MessageModel.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());
  // List<MessageModel> listData = [];
  ValueNotifier<List<MessageModel>> listData = ValueNotifier([]);
  var repo = Repository();

  Future<void> getdata() async {
    var datas = await repo.getMessageNotify();
    listData.value = datas;
  }

  void initStateCubit() async{
    try{
      emit(NotificationGetDataLoading());
      await getdata();
      getDataSuccess();
    }catch(e){
      getDataFailed("Get data notification failed!!");
    }
  }

  void getDataSuccess(){
    socketEvent();
    emit(NotificationGetDataSuccess());
  }

  void getDataFailed(String errorMessage){
    emit(NotificationGetDataFailure(errorMessage));
  }

  void socketEvent(){
    SocketServer.on("serviceFCM",(data) {
      getdata();
    });
  }

}
