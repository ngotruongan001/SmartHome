part of 'room_cubit.dart';

@immutable
abstract class RoomState {}

class RoomInitial extends RoomState {}

class RoomGetDataLoading extends RoomState {}

class RoomGetDataFailure extends RoomState {
  final String errorMessage;

  RoomGetDataFailure(this.errorMessage);
}

class RoomGetDataSuccess extends RoomState {}
