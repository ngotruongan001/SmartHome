import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:smart_home/data/respository.dart';
import 'package:smart_home/models/response_data_user.dart';
import 'package:smart_home/modules/login/register/models/request_register_user.dart';
import 'package:smart_home/utils/local_storage.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var fullNameController = TextEditingController();
  var identifyNameController = TextEditingController();
  var phoneNumberNameController = TextEditingController();
  var addressController = TextEditingController();

  var repo = Repository();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    fullNameController.dispose();
    identifyNameController.dispose();
    phoneNumberNameController.dispose();
    addressController.dispose();
  }

  void register() async {
    emit(RegisterLoading());
    var req = RequestRegisterUser(
      email: emailController.text,
      password: passwordController.text,
      fullname: fullNameController.text,
      identify: identifyNameController.text,
      mobile: phoneNumberNameController.text,
      address: addressController.text,
    );

    var res = await repo.register(
      handleRegisterSuccess,
      handleRegisterFailaru,
      requestRegisterUser: req,
    );

  }

  void handleRegisterSuccess(ResponseDataUser responseDataUser) {
    var user = responseDataUser.user;
    LocalStorage.saveUserInfo(
        userId: user!.id ?? '',
        identify: user.identify,
        fullname: user.fullname,
        email: user.email,
        avatar: user.avatar,
        address: user.address,
        mobile: user.mobile,
        role: user.role ,
        phoneNumber: user.phoneNumber,
        password: passwordController.text ,
        access_token: responseDataUser.access_token
    );
    emit(RegisterSuccess());
    print("Register success!!");
  }

  void handleRegisterFailaru(String errorMessage) {
    emit(RegisterFailure(errorMessage));
    print("Register failed!!");
  }
}
