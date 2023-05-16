part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationGetDataLoading extends NotificationState {}

class NotificationGetDataFailure extends NotificationState {
  final String errorMessage;

  NotificationGetDataFailure(this.errorMessage);
}

class NotificationGetDataSuccess extends NotificationState {}
