class RequestRegisterUser {
  final String? email;
  final String? password;
  final String? fullname;
  final String? identify;
  final String? mobile;
  final String? address;

  RequestRegisterUser({
    this.password,
    this.email,
    this.fullname,
    this.identify,
    this.mobile,
    this.address,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['fullname'] = fullname;
    data['cmnd'] = identify;
    data['mobile'] = mobile;
    data['address'] = address;
    data['phoneNumber'] = mobile;
    return data;
  }

  @override
  String toString() {
    return "{email: $email - password: $password}";
  }
}
