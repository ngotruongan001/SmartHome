import 'package:smart_home/models/data_user.dart';

class ResponseDataUser {
  final String? msg;
  final String? access_token;
  final UserData? user;

  ResponseDataUser({
    this.msg,
    this.access_token,
    this.user,
  });

  factory ResponseDataUser.fromJson(Map<String, dynamic> parsedJson) {
    return ResponseDataUser(
      msg: parsedJson['msg'] as String,
      access_token: parsedJson['access_token'] as String,
      user:  UserData.fromJson(parsedJson['user']),
    );
  }
}
