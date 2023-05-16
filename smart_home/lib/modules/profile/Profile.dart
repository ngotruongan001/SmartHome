import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home/authentication/auth_services.dart';
import 'package:smart_home/common/widgets/ProfileMenu.dart';
import 'package:smart_home/common/widgets/Widget/Profile/Feedback.dart';
import 'package:smart_home/common/widgets/Widget/Profile/ViewProfile.dart';
import 'package:smart_home/data/respository.dart';
import 'package:smart_home/data/socket.dart';
import 'package:smart_home/modules/login/login/login_page.dart';
import 'package:smart_home/themes/theme_data.dart';
import 'package:smart_home/themes/theme_provider.dart';
import 'package:smart_home/utils/local_storage.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // bool statuslight = false;
  var repo = Repository();
  ValueNotifier<bool> statusNotifier = ValueNotifier(false);

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences prefs;

  getValue() async {
    prefs = await _prefs;
    setState(() {
      statusNotifier.value = (prefs.containsKey("switchValue")
          ? prefs.getBool("switchValue")
          : false)!;
    });
  }

  @override
  void initState() {
    getValue();
    // print("userId: ${LocalStorage.getString(LocalStorageKey.userId)}");
    super.initState();
    // repo.handleUpdateLightLed(statuslight);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                  decoration: const BoxDecoration(),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Profile",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold, color: context.watch<ThemeProvider>().textColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // const ProfilePic(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: SizedBox(
                        height: 130,
                        width: 130,
                        child: Stack(
                          fit: StackFit.expand,
                          clipBehavior: Clip.none,
                          children: [
                            Image.asset('assets/images/ngotruongan.jpg',
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: CustomColors.pageBackgroundColor,
                      padding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: context.watch<ThemeProvider>().cardProfileCorlor,
                    ),
                    onPressed: null,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/moon.svg",
                          color: context.watch<ThemeProvider>().primaryTextColor,
                          width: 22,
                        ),
                        const SizedBox(width: 20),
                         Expanded(
                            child: Text(
                                "Dark Mode",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: context.watch<ThemeProvider>().textColor,
                                )
                            )),
                        ValueListenableBuilder<bool>(valueListenable: statusNotifier, builder: (context, value, child){
                          return SizedBox(
                            width: 40,
                            height: 26,
                            child: Switch(
                              activeColor: context.watch<ThemeProvider>().switchColor,
                              value: value,
                              onChanged: (bool val) async {
                                // await repo.handleUpdateLightLed(val);
                                statusNotifier.value = val;
                                context.read<ThemeProvider>().updateBg(val);
                                prefs.setBool("switchValue", val);
                              },
                            ),
                          );
                        },),

                      ],
                    ),
                  ),
                ),
                ProfileMenu(
                  text: "Information User",
                  icon: "assets/icons/people.svg",
                  press: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ViewProfile()))
                  },
                ),
                ProfileMenu(
                  text: "Setting",
                  icon: "assets/icons/settings.svg",
                  press: () {},
                ),
                ProfileMenu(
                  text: "Feedback",
                  icon: "assets/icons/feedback.svg",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReportPage()));
                  },
                ),
                ProfileMenu(
                  text: "Logout",
                  icon: "assets/icons/logout.svg",
                  press: () {
                    logout(context);
                  },
                ),
              ],
            )
        ),

      ),
    );
  }
  Future<void> logout(BuildContext context) async {
        LocalStorage.clearUserInfo();
        // SocketServer.disconnect();
        Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage(),),);
  }
}