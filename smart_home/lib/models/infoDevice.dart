
class InfoDevice {
  final AntiFire? antiFire;
  final AntiTheft? antiTheft;
  final Temperature? humidity;
  final Temperature? temperature;
  final RainAlarm? rainAlarm;
  final Led? led;


  InfoDevice({
    this.antiFire,
    this.antiTheft,
    this.humidity,
    this.temperature,
    this.rainAlarm,
    this.led,
  });

  factory InfoDevice.fromJson(Map<String, dynamic> parsedJson) {
    return InfoDevice(
      antiFire: AntiFire.fromJson(parsedJson['AntiFire']),
      antiTheft:  AntiTheft.fromJson(parsedJson['AntiTheft']),
      humidity: Temperature.fromJson(parsedJson['Humidity']),
      temperature: Temperature.fromJson(parsedJson['Temperature']),
      rainAlarm: RainAlarm.fromJson(parsedJson['RainAlarm']),
      led: Led.fromJson(parsedJson['Led']),
    );
  }
  @override
  String toString() {
    return "{antiFire: $antiFire - antiTheft: $antiTheft - humidity: $humidity - temperature: $temperature - led: $led}";
  }
}

class Temperature {
  final num? data;

  Temperature({
    this.data,
  });
  factory Temperature.fromJson(Map<String, dynamic> parsedJson) {
    return Temperature(
      data: parsedJson['Data'],
    );
  }
  @override
  String toString() {
    return "{led: $data}";
  }
}


class Led {
  final int? status;
  Led({
    this.status,
  });
  factory Led.fromJson(Map<String, dynamic> parsedJson) {
    return Led(
      status: parsedJson['Status'],
    );
  }
  @override
  String toString() {
    return "{led: $status}";
  }
}

class RainAlarm {
  final String? status;

  RainAlarm({
    this.status,
  });
  factory RainAlarm.fromJson(Map<String, dynamic> parsedJson) {
    return RainAlarm(
      status: parsedJson['Status'],
    );
  }
  @override
  String toString() {
    return "{led: $status}";
  }
}

class AntiFire {
  final String? status;
  final int? PPM;
  AntiFire({
    this.status,
    this.PPM,
  });
  factory AntiFire.fromJson(Map<String, dynamic> parsedJson) {
    return AntiFire(
      PPM: parsedJson['PPM'],
      status: parsedJson['Status'],
    );
  }
  @override
  String toString() {
    return "{led: $status}";
  }
}

class AntiTheft {
  final String? status;
  final int? times;

  AntiTheft({
    this.status,
    this.times,
  });
  factory AntiTheft.fromJson(Map<String, dynamic> parsedJson) {
    return AntiTheft(
      times: parsedJson['Times'],
      status: parsedJson['Status'],
    );
  }
  @override
  String toString() {
    return "{led: $status}";
  }
}