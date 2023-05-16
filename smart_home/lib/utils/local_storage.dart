import 'package:hive/hive.dart';

import '../environment/app_config.dart';

final LocalStorage = HiveLocalStorage();

class HiveLocalStorage {
  final box = Hive.box('AppLocalStorage');
  void open() {
    Hive.openBox('AppLocalStorage');
  }

  String getString(String key, {String? defaultValue}) {
    try {
      return box.get(key, defaultValue: defaultValue ?? '');
    } catch (_) {
      return '';
    }
  }

  int getInt(String key, {int? defaultValue}) {
    try {
      return box.get(key, defaultValue: defaultValue ?? -1);
    } catch (_) {
      return -1;
    }
  }

  bool getBool(String key, {bool? defaultValue}) {
    try {
      return box.get(key, defaultValue: defaultValue ?? false);
    } catch (_) {
      return false;
    }
  }

  dynamic getObject(String key) {
    try {
      return box.get(key);
    } catch (_) {
      return null;
    }
  }

  void save(String key, dynamic value) {
    box.put(key, value);
  }

  void clearUserInfo() {
    LocalStorage.save(LocalStorageKey.userId, '');
    LocalStorage.save(LocalStorageKey.avatar, '');
    LocalStorage.save(LocalStorageKey.role, '');
    LocalStorage.save(LocalStorageKey.mobile, '');
    LocalStorage.save(LocalStorageKey.address, '');
    LocalStorage.save(LocalStorageKey.access_token, '');
    LocalStorage.save(LocalStorageKey.fullname, '');
    LocalStorage.save(LocalStorageKey.identify, '');
    LocalStorage.save(LocalStorageKey.email, '');
    // LocalStorage.save(LocalStorageKey.password, '');
    LocalStorage.save(LocalStorageKey.isLogin, false);
  }

  void saveUserInfo({
    String? userId,
    String? avatar,
    String? role,
    String? mobile,
    String? address,
    String? access_token,
    String? fullname,
    String? identify,
    String? email,
    String? password,
    String? phoneNumber,
  }) {
    LocalStorage.save(LocalStorageKey.userId, userId ?? '');
    LocalStorage.save(LocalStorageKey.avatar, avatar ?? '');
    LocalStorage.save(LocalStorageKey.role, role ?? '');
    LocalStorage.save(LocalStorageKey.mobile, mobile ?? '');
    LocalStorage.save(LocalStorageKey.access_token, access_token ?? '');
    LocalStorage.save(LocalStorageKey.fullname, fullname ?? '');
    LocalStorage.save(LocalStorageKey.identify, identify ?? '');
    LocalStorage.save(LocalStorageKey.email, email ?? '');
    LocalStorage.save(LocalStorageKey.address, address ?? '');
    LocalStorage.save(LocalStorageKey.phoneNumber, phoneNumber ?? '');
    // LocalStorage.save(LocalStorageKey.password, password ?? '');
    LocalStorage.save(LocalStorageKey.isLogin, true);
  }
}

class LocalStorageKey {
  static const String userId = 'userId';
  static const String isLogin = 'isLogin';
  static const String avatar = 'avatar';
  static const String role = 'role';
  static const String mobile = 'mobile';
  static const String address = 'address';
  static const String access_token = 'access_token';
  static const String fullname = 'fullname';
  static const String identify = 'identify';
  static const String email = 'email';
  static const String phoneNumberLogin = 'phoneNumberLogin';
  static const String phoneNumber = 'phoneNumber';
  static const String tokenFCM = 'tokenFCM';
  static const String password = 'password';
}
