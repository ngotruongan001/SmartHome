import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:smart_home/data/socket.dart';
import 'package:smart_home/models/MessageModel.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  RoomCubit() : super(RoomInitial());
  List<MessageModel> listData = [];

  void initStateCubit(){
    SocketServer.on("",(data){

    });
  }

}
