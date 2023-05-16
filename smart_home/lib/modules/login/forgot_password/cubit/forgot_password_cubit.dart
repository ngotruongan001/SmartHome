import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:smart_home/data/respository.dart';
import 'package:smart_home/modules/login/forgot_password/ForgotPassword.dart';
import 'package:smart_home/modules/login/login/models/request_user.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());
  var emailController = TextEditingController();
  var repo = Repository();
  @override
  void dispose() {
    emailController.dispose();
  }

  void onPressedResetEmail() async {
    emit(ForgotPasswordLoading());

    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text)
        .then((value) {
      handleForgotPasswordSuccess();
    }).catchError((e){
      handleForgotPasswordFailed("reset password failed!!");
    });
  }

  void handleForgotPasswordSuccess() {
    print("reset password success!!");
    emit(ForgotPasswordSuccess());
  }

  void handleForgotPasswordFailed(String errorMessage) {
    print("reset password failed!!");
    emit(ForgotPasswordFailure(errorMessage));
  }

  void handleChangeEmailText(String value) {
    emailController.text = value;
  }

}
