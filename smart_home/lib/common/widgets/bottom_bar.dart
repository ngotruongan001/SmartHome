import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/data/socket.dart';
import 'package:smart_home/modules/chatbot/chatbox_page.dart';
import 'package:smart_home/modules/dashboard/DashBoard.dart';
import 'package:smart_home/modules/home/Home.dart';
import 'package:smart_home/modules/home/cubit/home_cubit.dart';
import 'package:smart_home/modules/notification/Notification.dart';
import 'package:smart_home/modules/profile/Profile.dart';
import 'package:smart_home/themes/theme_provider.dart';
import 'package:smart_home/utils/local_storage.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);
  @override
  State<BottomBar> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BottomBar> {
  int _selectedIndex = 0;
  var bloc = HomeCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = 0;
    bloc.getInfoDevice();
    bloc.getUserWeatherLocation();
    // bloc.initHomeCubit();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  void _onItemTapped(int? index) {
    setState(() {
      _selectedIndex = index!;
    });
  }



  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = [
      MyHomePage(bloc: bloc),
      DashBoard(bloc: bloc),
      const NotificationPage(),
      Profile(),
    ];
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => ChatBot()),
            ),
          );
        },
        child: Lottie.asset('assets/json/chatbot.json'),
        backgroundColor: context.watch<ThemeProvider>().bubblebackgroundColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        hasNotch: true, //new
        hasInk: true,
        backgroundColor: context.watch<ThemeProvider>().pageBackgroundColor,
        fabLocation: BubbleBottomBarFabLocation.end,
        opacity: .2,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ), //border radius doesn't work when the notch is enabled.
        elevation: 8,
        // tilesPadding: EdgeInsets.symmetric(
        //   vertical: 8.0,
        // ),
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            backgroundColor: context.watch<ThemeProvider>().bubblebackgroundColor,
            icon: Icon(
              Icons.home,
              color: context.watch<ThemeProvider>().bubbleBottomBarIcon,
            ),
            activeIcon: Icon(
              Icons.home,
              color: context.watch<ThemeProvider>().bubbleBottomBarIcon,
            ),
            badge: Container(),
            title: Text("Home"),
          ),
          BubbleBottomBarItem(
              backgroundColor: context.watch<ThemeProvider>().bubblebackgroundColor,
              icon: Icon(
                Icons.app_shortcut_sharp,
                color: context.watch<ThemeProvider>().bubbleBottomBarIcon,
              ),
              activeIcon: Icon(
                Icons.app_shortcut_sharp,
                color: context.watch<ThemeProvider>().bubbleBottomBarIcon,
              ),
              badge: Container(),

              title: Text("Dashboard")),
          BubbleBottomBarItem(
            // showBadge: true,
            // badge: Text("5"),
            // badgeColor: Colors.transparent,
              backgroundColor: context.watch<ThemeProvider>().bubblebackgroundColor,
              icon: Icon(
                Icons.notifications,
                color: context.watch<ThemeProvider>().bubbleBottomBarIcon,
              ),
              badge: Container(),

              activeIcon: Icon(
                Icons.notifications,
                color: context.watch<ThemeProvider>().bubbleBottomBarIcon,
              ),
              title: Text("Notify")),
          BubbleBottomBarItem(
              backgroundColor: context.watch<ThemeProvider>().bubblebackgroundColor,
              icon: Icon(
                Icons.person,
                color: context.watch<ThemeProvider>().bubbleBottomBarIcon,
              ),
              badge: Container(),

              activeIcon: Icon(
                Icons.person,
                color: context.watch<ThemeProvider>().bubbleBottomBarIcon,
              ),
              title: Text("Profile"))
        ],
      ),
    );
  }
}