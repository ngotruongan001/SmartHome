import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_home/common/widgets/textfield/main_textfield.dart';
import 'package:smart_home/modules/login/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:smart_home/modules/login/login/login_page.dart';
import 'package:smart_home/string/app_strings.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // string for displaying the error Message
  String? errorMessage;
  // our form key
  final _formKey = GlobalKey<FormState>();
  // firebase
  final _auth = FirebaseAuth.instance;

  var bloc = ForgotPasswordCubit();

  @override
  Widget build(BuildContext context) {
    //email field

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                      decoration: const BoxDecoration(
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
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.1, vertical: 10),
                child: MainTextField(
                  hint: AppStrings.email.tr,
                  controller: bloc.emailController,
                  prefixIcon: const Icon(
                    Icons.mail,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.1, vertical: 20),
                child: _widgetButtonSubmit(),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _widgetButtonSubmit() {
    return BlocConsumer(
      bloc: bloc,
      listener: (context, state) {
        if (state is ForgotPasswordFailure) {
          Fluttertoast.showToast(msg: state.errorMessage);
        }
        if (state is ForgotPasswordSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        }
      },
      builder: (context, state) {
        return InkWell(
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                bloc.onPressedResetEmail();
              }
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
                child: state is ForgotPasswordLoading
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.loading.tr,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          _widgetCircleLoading(height: 18.0.r, width: 18.0.r),
                        ],
                      )
                    : Center(
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
