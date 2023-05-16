class RequestUser {
  final String? phoneNumber;
  final String? password;

  RequestUser({
    this.password,
    this.phoneNumber,

  });

  factory RequestUser.fromJson(Map<String, dynamic> parsedJson) {
    return RequestUser(
      phoneNumber: parsedJson['phoneNumber'] as String,
      password: parsedJson['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['phoneNumber'] = phoneNumber;
    data['password'] = password;
    return data;
  }

  @override
  String toString() {
    return "{phoneNumber: $phoneNumber - password: $password}";
  }
}
