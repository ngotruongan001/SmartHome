
class UserTokenModel {
  final String? id;
  final String? token;
  final String? userId;
  final bool? isNotifyAntiTheft;
  final bool? isNotifyWarningTemp;
  final bool? isNotifyAntiFire;
  final bool? isNotifyRainAlarm;

  UserTokenModel({
    this.id,
    this.token,
    this.userId,
    this.isNotifyAntiTheft,
    this.isNotifyWarningTemp,
    this.isNotifyAntiFire,
    this.isNotifyRainAlarm,
  });

  factory UserTokenModel.fromJson(Map<String, dynamic> parsedJson) {
    return UserTokenModel(
      id: parsedJson['_id'],
      token: parsedJson['token'],
      userId: parsedJson['userId'],
      isNotifyAntiTheft: parsedJson['isNotifyAntiTheft'],
      isNotifyWarningTemp: parsedJson['isNotifyWarningTemp'],
      isNotifyAntiFire: parsedJson['isNotifyAntiFire'],
      isNotifyRainAlarm: parsedJson['isNotifyRainAlarm'],
    );
  }
  @override
  String toString() {
    return "{token: $token - userId: $userId - isNotifyAntiTheft: $isNotifyAntiTheft}";
  }
}