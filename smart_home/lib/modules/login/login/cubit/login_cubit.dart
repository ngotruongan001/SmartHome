import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:meta/meta.dart';
import 'package:smart_home/data/respository.dart';
import 'package:smart_home/models/response_data_user.dart';
import 'package:smart_home/modules/login/login/models/request_user.dart';
import 'package:smart_home/modules/login/login/models/response_user.dart';
import 'package:smart_home/utils/local_storage.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final LocalAuthentication _auth = LocalAuthentication();
  var repo = Repository();

  // @override
  // void initState() {
  //   emailController.text = "ngoctinhxx@gmail.com";
  //   passwordController.text = "123456";
  // }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  bool isCheckAccount(){
    var emailSaved = LocalStorage.getString(LocalStorageKey.phoneNumberLogin);
    var passwordSaved = LocalStorage.getString(LocalStorageKey.password);
    return emailSaved == emailController.text && passwordSaved == passwordController.text;
  }

  // void loginFacebook() async {
  //   emit(LoginLoading());
  //   await repo.loginFacebook(
  //     handleLoginSuccess,
  //     handleLoginFailed,
  //   );
  // }
  //
  // void loginGmail() async {
  //   emit(LoginLoading());
  //   await repo.loginGmail(
  //     handleLoginSuccess,
  //     handleLoginFailed,
  //   );
  // }

  void initLoginCubit()  {
    emailController.text = LocalStorage.getString(LocalStorageKey.phoneNumberLogin) ?? '';
    passwordController.text = LocalStorage.getString(LocalStorageKey.password) ?? '';
  }

  void login() async {
    emit(LoginLoading());
    var requestUser = RequestUser(
      phoneNumber: emailController.text,
      password: passwordController.text,
    );
    await repo.login(
      handleLoginSuccess,
      handleLoginFailed,
      requestUser: requestUser,
    );
    // await repo.handleUpdateLed();
  }

  void handleLoginSuccess(ResponseDataUser responseDataUser) {
    print("Login success!!");
    var user = responseDataUser.user;
    LocalStorage.saveUserInfo(
      userId: user!.id ?? '',
      identify: user.identify,
      fullname: user.fullname,
      email: user.email,
      avatar: user.avatar,
      address: user.address,
      mobile: user.mobile,
      role: user.role,
      phoneNumber: user.phoneNumber,
      // password: passwordController.text,
      access_token: responseDataUser.access_token,
    );
    // emailController.text = '';
    // passwordController.text = '';
    emit(LoginSuccess());
  }

  void saveAccount(){
    LocalStorage.save(LocalStorageKey.phoneNumberLogin, emailController.text);
    LocalStorage.save(LocalStorageKey.password, passwordController.text);
  }

  void handleLoginFailed(String errorMessage) {
    print("Login failed!!");
    emit(LoginFailure(errorMessage));
  }

  void handleChangeEmailText(String value) {
    emailController.text = value;
  }

  void handleChangePasswordText(String value) {
    passwordController.text = value;
  }

  Future<bool> hasEnrolledBiometrics() async {
    final availableBiometrics = await _auth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<bool> authenticate() async {
    final didAuthenticate = await _auth.authenticate(
      localizedReason: 'Vui lòng xác thực để xử lý',
      options: const AuthenticationOptions(biometricOnly: true),
    );
    if (didAuthenticate) {
      emailController.text = LocalStorage.getString(LocalStorageKey.phoneNumberLogin);
      passwordController.text = LocalStorage.getString(LocalStorageKey.password);
      login();
      // LocalStorage.saveUserInfo(
      //     userId: '',
      //     identify: '',
      //     fullname: 'Ngo Truong An',
      //     email: '',
      //     avatar: '',
      //     address: '',
      //     mobile: '',
      //     role: '',
      //     access_token: '');
      emit(LoginSuccess());
    }
    return didAuthenticate;
  }
}
