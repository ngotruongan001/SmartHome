import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/data/respository.dart';
import 'package:smart_home/data/socket.dart';
import 'package:smart_home/modules/splash_page/StartSplashScreen.dart';
import 'package:smart_home/string/app_strings.dart';
import 'package:smart_home/themes/theme_provider.dart';
import 'package:smart_home/utils/local_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:smart_home/viewmodel/DataProvider.dart';
import 'package:get/get.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print(message.data);
}

Future<void> main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox("AppLocalStorage");
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => DataProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
// This widget is the root of your application.

}

class _MyAppState extends State<MyApp> {
  final DatabaseReference _database = FirebaseDatabase().reference();
  late FirebaseMessaging _fcm;
  late String message;

  // IO.Socket socket = IO.io('https://nodejs-api-7u44.onrender.com/', <String, dynamic>{
  //   'transports': ['websocket'],
  // });

  var repo = Repository();

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      // if (notification != null && android != null) {}
      // context.read<DataProvider>().fetchApiMessage();
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print("Notification in app");
      // if (notification != null && android != null) {}
      // context.read<DataProvider>().fetchApiMessage();
    });


    getToken();
    context.read<DataProvider>().fetchApiMessage();
    // repo.getInfoDevice();
    repo.getMessageNotify();

  }

  @override
  void dispose(){
    super.dispose();
    SocketServer.disconnect();
    LocalStorage.clearUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: context.watch<ThemeProvider>().backgroundFeedback,
        fontFamily: 'LeonSans',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: ScreenUtilInit(
        designSize: const Size(414, 896),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return GetMaterialApp(
            title: 'Smarthome',
            debugShowCheckedModeBanner: false,
            translations: AppStrings(),
            supportedLocales: const [
              Locale('vi', 'VN'),
              Locale('en', 'US'),
            ],
            locale: const Locale('vi', 'VN'),
            fallbackLocale: const Locale('vi', 'VN'),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            home: StartSplashScreen(),
          );
        },
      ),
    );
  }

  getToken() async {
    var token = (await FirebaseMessaging.instance.getToken())!;
    print("token: $token");
    LocalStorage.save(LocalStorageKey.tokenFCM, token);
  }
}
