import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/common/widgets/button/main_button.dart';
import 'package:smart_home/common/widgets/textfield/main_textfield.dart';
import 'package:smart_home/data/respository.dart';
import 'package:smart_home/modules/login/login/cubit/login_cubit.dart';
import 'package:smart_home/modules/login/login/widget/biometric_button.dart';
import 'package:smart_home/modules/splash_page/FlashScreen.dart';
import 'package:smart_home/modules/login/forgot_password/ForgotPassword.dart';
import 'package:smart_home/modules/login/register/Register.dart';
import 'package:smart_home/string/app_strings.dart';
import 'package:smart_home/themes/app_colors.dart';
import 'package:smart_home/themes/app_dimension.dart';
import 'package:smart_home/themes/styles_text.dart';
import 'package:smart_home/themes/theme_provider.dart';
import 'package:smart_home/utils/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map? _userData;
  var bloc = LoginCubit();
  final _formKey = GlobalKey<FormState>();
  bool showBiometric = false;
  bool isAuthenticated = false;
  // firebase
  final _auth = FirebaseAuth.instance;
  var repo = Repository();
  // string for displaying the error Message
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    // bloc.emailController.text = 'ngoctinhxx@gmail.com';
    // bloc.passwordController.text = '123456';
    bloc.initLoginCubit();
    isBiometricsAvailable();
  }

  isBiometricsAvailable() async {
    showBiometric = await bloc.hasEnrolledBiometrics();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer(
        bloc: bloc,
        listener: (context, state) {
          if (state is LoginFailure) {
            Fluttertoast.showToast(msg: state.errorMessage);
          }
          if (state is LoginSuccess) {
            Fluttertoast.showToast(msg: "Login success!!!");
            if(bloc.isCheckAccount()){
              onNavigateNextScreen();
            }else{
              var future = _modalBottomSheetMenu();
              future.then((void value) => {
                onNavigateNextScreen(),
              });
            }
            repo.saveLogin();
          }
        },
        builder: (context, state) {
          return Scaffold(
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
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.1),
                      child: const Text(
                        'SIGN IN',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _widgetTextFieldEmail(),
                    _widgetTextFieldPassword(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.1,
                        vertical: 5,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPassword()));
                              },
                              child: const Text(
                                " Forgot Password?",
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            )
                          ]),
                    ),
                    _widgetButtonLogin(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.1, vertical: 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Do not have an account?",
                              style: TextStyle(
                                  fontSize: 15,
                                  color:
                                      context.watch<ThemeProvider>().textColor),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Register()));
                              },
                              child: const Text(
                                " Sign Up",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ]),
                    )
                  ],
                ),
              ),
            ),
          ));
        });
  }

  Widget _widgetTextFieldEmail() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 1.sw * 0.1,
        vertical: 10,
      ),
      child: MainTextField(
        controller: bloc.emailController,
        hint: "Phone Number",
        prefixIcon: Icon(
          Icons.email,
          color: Colors.deepOrange,
        ),
        validator: (value) {
          return Validators.validatePhoneNumber(
              value, "Phone number is wrong.");
        },
      ),
    );
  }

  Widget _widgetButtonLogin() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 1.sw * 0.1,
        vertical: 10,
      ),
      child: Row(
        children: [
          BiometricButton(
            onPressed: () {
              bloc.authenticate();
            },
          ),
          if (isAuthenticated)
            const Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Text(
                'Well done!, Authenticated',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: BlocBuilder(
              bloc: bloc,
              builder: (context, state) {
                if (state is LoginLoading) {
                  return MainButton(
                    height: 50.h,
                    onPressed: () {},
                    widgetInButton: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.loading.tr,
                          style: StylesText.body1.copyWith(
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white),
                        ),
                        SizedBox(
                          width: 5.0.r,
                        ),
                        _widgetCircleLoading(height: 18.0.r, width: 18.0.r),
                      ],
                    ),
                  );
                }
                return MainButton(
                  textStyle: StylesText.body3.copyWith(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white),
                  height: 50.h,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      bloc.login();
                    }
                  },
                  title: "Đăng nhập",
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _widgetTextFieldPassword() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 1.sw * 0.1,
        vertical: 10,
      ),
      child: MainTextField(
        controller: bloc.passwordController,
        hint: "Password",
        isPasswordField: true,
        prefixIcon: Icon(
          Icons.vpn_key,
          color: Colors.deepOrange,
        ),
        obscureText: true,
        validator: (value) {
          return Validators.validateLength(
            value,
            6,
            AppStrings.commonError.tr,
          );
        },
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

  _modalBottomSheetMenu() {
    return showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.white.withOpacity(0),
        barrierColor: AppColors.black.withOpacity(0.1),

        builder: (builder) {
          return Container(
            height: 235.h,
            padding:
            EdgeInsets.only(left: 10.0.r, right: 10.0.r, bottom: 10.0.r,),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0.r),
                      color: AppColors.white
                  ),
                  child: Column(
                    children: [
                      MainButton(
                        onPressed: () async{
                          Navigator.pop(context);
                          // Navigator.push(context,
                          //   MaterialPageRoute(builder: (context) => FlashScreen(),),);
                          bloc.saveAccount();
                        },
                        title: "Lưu tài khoản",
                        textStyle: StylesText.body1.copyWith(
                          color: AppColors.primary1,
                        ),
                        backgroundColor: AppColors.white.withOpacity(0),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0.r,),
                MainButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigator.push(context,
                    //   MaterialPageRoute(builder: (context) => FlashScreen(),),);
                  },
                  title: AppStrings.cancel.tr,
                  textStyle: StylesText.body1.copyWith(
                    color: AppColors.primary2,
                  ),
                  backgroundColor: AppColors.white,
                )
              ],
            ),
          );
        });
  }

  void onNavigateNextScreen(){
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => FlashScreen(),),);
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
