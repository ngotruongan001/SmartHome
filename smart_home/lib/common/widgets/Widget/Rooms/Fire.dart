import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/common/widgets/button/main_button.dart';
import 'package:smart_home/models/user_token_model.dart';
import 'package:smart_home/modules/home/cubit/home_cubit.dart';
import 'package:smart_home/themes/app_colors.dart';
import 'package:smart_home/themes/app_dimension.dart';
import 'package:smart_home/themes/theme_provider.dart';

class FirePage extends StatefulWidget {
  const FirePage({Key? key, required this.bloc}) : super(key: key);
  final HomeCubit bloc;

  @override
  State<FirePage> createState() => _FirePageState();
}

class _FirePageState extends State<FirePage> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValueListenableBuilder<int>(
                  valueListenable: widget.bloc.ppmNotifier,
                  builder: (context, value, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 250,
                            width: 250,
                            child: Lottie.asset('assets/json/tick.json', repeat: false,)),
                        Text(
                          value >= 100? "Dangerous State": "Safe State",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.deepOrange),
                        ),

                        const SizedBox(height: 15),
                        SizedBox(
                          height: 400 ,
                          child: GridView.count(
                            primary: false,
                            padding: const EdgeInsets.all(20),
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            crossAxisCount: 2,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: context.watch<ThemeProvider>().cardDashBoard,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children:  [
                                            Text(
                                              "Sensor 1",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 19,
                                                  color: context.watch<ThemeProvider>().textColor),
                                            )
                                          ],
                                        ),

                                      ],
                                    ),

                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:  [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Active status",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: context.watch<ThemeProvider>().textColor, fontSize: 17),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "flammable gas concentration",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              color: context.watch<ThemeProvider>().textColor),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '$value PPM',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: context.watch<ThemeProvider>().textColor),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              ValueListenableBuilder<UserTokenModel>(
                                  valueListenable: widget.bloc.userTokenNotifier,
                                  builder: (context, value1, child) {
                                    return Container(
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: context.watch<ThemeProvider>().cardDashBoard,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children:  [
                                                  Text(
                                                    "Sensor",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 19,
                                                        color: context.watch<ThemeProvider>().textColor),
                                                  )
                                                ],
                                              ),
                                              Switch(
                                                activeColor: Colors.deepOrange,
                                                value: value1.isNotifyAntiFire == true,
                                                onChanged: (bool val) async {
                                                  var body = {
                                                    "isNotifyAntiFire": val,
                                                  };
                                                  widget.bloc.onPressedUpdateUserToken(body);
                                                },
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:  [
                                              Text(
                                                "Notification: ${value1.isNotifyAntiFire == true ? "On" : "Off"}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: context.watch<ThemeProvider>().textColor, fontSize: 17),
                                              ),
                                               SizedBox(
                                                height: 6.r,
                                              ),

                                              Text(
                                                "Control notification of app",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    color: context.watch<ThemeProvider>().textColor),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),

                      ],
                    );
                  }),


            ],
          )),
    );
  }
}
