
class UserData {
  final String? id;
  final String? avatar;
  final String? role;
  final String? gender;
  final String? mobile;
  final String? address;
  final String? website;
  final String? fullname;
  final String? identify;
  final String? email;
  final String? phoneNumber;
  UserData({
    this.id,
    this.avatar,
    this.role,
    this.gender,
    this.address,
    this.website,
    this.fullname,
    this.identify,
    this.email,
    this.mobile,
    this.phoneNumber
  });

  factory UserData.fromJson(Map<String, dynamic> parsedJson) {
    print("id: ${parsedJson['_id']}");
    print("avatar: ${parsedJson['avatar']}");
    print("role: ${parsedJson['role']}");
    print("gender: ${parsedJson['gender']}");
    print("address: ${parsedJson['address']}");
    print("website: ${parsedJson['website']}");
    print("identify: ${parsedJson['identify']}");
    print("username: ${parsedJson['username']}");
    print("email: ${parsedJson['email']}");
    print("mobile: ${parsedJson['mobile']}");
    return UserData(
      id: parsedJson['_id'] as String,
      avatar: parsedJson['avatar'] as String,
      role: parsedJson['role'] as String,
      gender: parsedJson['gender'] as String,
      address: parsedJson['address'] as String,
      website: parsedJson['website'] as String,
      fullname: parsedJson['fullname'] as String,
      identify: parsedJson['identify'] as String,
      email: parsedJson['email'] as String,
      mobile: parsedJson['mobile'] as String,
      phoneNumber: parsedJson['phoneNumber'] as String,
    );
  }
  @override
  String toString() {
    return "{id: ${id} - fullname: $fullname - identify: $identify - email: $email}";
  }
}

