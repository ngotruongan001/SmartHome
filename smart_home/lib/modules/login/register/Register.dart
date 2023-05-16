import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_home/common/widgets/bottom_bar.dart';
import 'package:smart_home/common/widgets/textfield/main_textfield.dart';
import 'package:smart_home/models/UserModel.dart';
import 'package:smart_home/modules/login/login/login_page.dart';
import 'package:smart_home/modules/login/register/cubit/register_cubit.dart';
import 'package:smart_home/modules/splash_page/FlashScreen.dart';
import 'package:smart_home/string/app_strings.dart';
import 'package:smart_home/themes/app_dimension.dart';
import 'package:smart_home/utils/validators.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  var bloc = RegisterCubit();

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener(
      bloc: bloc,
      listener: (context, state) {
        if (state is RegisterFailure) {
          Fluttertoast.showToast(msg: state.errorMessage);
        }
        if (state is RegisterSuccess) {
          Fluttertoast.showToast(msg: "Register success!!!");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FlashScreen()));
        }
      },
      child: Scaffold(
          body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipPath(
                      clipper: DrawClip(),
                      child: Container(
                        height: 280,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xffee4c14), Color(0xffffc371)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 270,
                      width: double.infinity,
                      child: Lottie.asset('assets/json/login.json'),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _widgetTextField(
                  controller: bloc.fullNameController,
                  hintText: "Full Name",
                  validator: (value) {
                    return Validators.validateFullName(
                        value, "Full name is wrong");
                  },
                ),
                _widgetTextField(
                  controller: bloc.emailController,
                  hintText: "Email",
                  validator: (value) {
                    return Validators.validateEmail(
                        value, "Email is wrong or existed");
                  },
                ),
                _widgetTextField(
                  controller: bloc.identifyNameController,
                  hintText: "Identity",
                  validator: (value) {
                    var message = Validators.validateNotNullOrEmpty(
                        value, "text field is empty");
                    if(message != null){
                      return message;
                    }
                    return Validators.validateIdCardNumber(value, 'ID number is wrong');
                  },
                ),
                _widgetTextField(
                  controller: bloc.phoneNumberNameController,
                  hintText: "Phone number: ",
                  validator: (value) {
                    return Validators.validatePhoneNumber(
                        value, "Phone number is wrong.");
                  },
                ),
                _widgetTextField(
                  controller: bloc.addressController,
                  hintText: "Address",
                  validator: (value) {
                    return Validators.validateNotNullOrEmpty(
                        value, "Address field is empty");
                  },
                ),
                _widgetTextField(
                  controller: bloc.passwordController,
                  hintText: "Password",
                  isPassword: true,
                  validator: (value) {
                    return Validators.validateLength(
                      value,
                      6,
                      AppStrings.commonError.tr,
                    );
                  },
                ),
                _widgetTextField(
                  controller: bloc.confirmPasswordController,
                  hintText: "Confirm password",
                  isPassword: true,
                  validator: (value) {
                    print("password: $value");
                    if (value != bloc.passwordController.text) {
                      return AppStrings.commonError.tr;
                    }
                    return Validators.validateNotNullOrEmpty(
                        value, "text field is empty");
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.1, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Text(
                          " Sign In",
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.1, vertical: 20),
                  child: BlocBuilder(
                    bloc: bloc,
                    builder: (context, stateBloc){
                      if(stateBloc is RegisterLoading){
                        return InkWell(
                            onTap: () {
                              signUp();
                            },
                            child: Material(
                              elevation: 10,
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.deepOrange,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                height: 50,
                                width: 400,
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppStrings.loading.tr,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 5.0.r,
                                    ),
                                    _widgetCircleLoading(height: 18.0.r, width: 18.0.r),
                                  ],
                                ),
                              ),
                            ));
                      }
                      return InkWell(
                          onTap: () {
                            signUp();
                          },
                          child: Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              height: 50,
                              width: 400,
                              child: Center(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ));
                    },

                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget _widgetTextField(
      {required String hintText,
      required TextEditingController controller,
      FormFieldValidator<String>? validator,
      bool? isPassword}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 1.sw * 0.1,
        vertical: 10,
      ),
      child: MainTextField(
        controller: controller,
        hint: hintText,
        isPasswordField: isPassword ?? false,
        prefixIcon: Icon(
          Icons.vpn_key,
          color: Colors.deepOrange,
        ),
        obscureText: true,
        validator: validator,
      ),
    );
  }

  Widget _widgetCircleLoading({
    required double height,
    required double width,
    Color? backgroudColor,
    double? strokeWidth,
  }) {
    return SizedBox(
        width: height,
        height: width,
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 4.0.r,
        ));
  }

  void signUp() async {
    if (_formKey.currentState!.validate()) {
      bloc.register();
    }
  }
}

class DrawClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width * 0.1, size.height - 30);
    path.lineTo(size.width * 0.9, size.height - 30);
    path.lineTo(size.width, size.height - 60);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldCliper) {
    return true;
  }
}
