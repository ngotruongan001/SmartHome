import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/modules/home/cubit/home_cubit.dart';
import 'package:smart_home/common/widgets/ChooseFloor.dart';
import 'package:smart_home/modules/home/widget/Floor/FirstFloor.dart';
import 'package:smart_home/modules/home/widget/Floor/SecondFloor.dart';
import 'package:smart_home/modules/home/widget/Floor/ThirdFloor.dart';
import 'package:smart_home/themes/theme_provider.dart';
import 'package:smart_home/themes/app_dimension.dart';
import 'package:smart_home/modules/weather/WeatherHome.dart';
import 'package:smart_home/utils/local_storage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.bloc}) : super(key: key);
  final HomeCubit bloc;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  // var bloc = HomeCubit();
  @override
  void initState() {
    super.initState();

  }


  Image getWeatherIcon(String _icon) {
    String path = 'assets/images/';
    String imageExtension = ".png";
    return Image.asset(
      _icon.isEmpty
          ? path + "loading" + imageExtension
          : path + _icon + imageExtension,
      width: 70.r,
      height: 70.r,
    );
  }

  @override
  Widget build(BuildContext context) {
    var _page = [
      FirstFloor(bloc: widget.bloc,),
      SecondFloor(bloc: widget.bloc,),
      ThirdFloor(bloc: widget.bloc,),
    ];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _widgetTopInfo(),
              _widgetCurrentWeather(),
              ValueListenableBuilder<int>(
                  valueListenable: widget.bloc.floorCurrentNotifier,
                  builder: (context, index, _) {
                    return Column(
                      children: [
                        ChooseFloor(
                            handleClick: widget.bloc.onChangeFloorNotifier,
                            setId: index),
                        _page[index],
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
    // This trailing comma makes auto-formatting nicer for build methods.
  }

  Widget _widgetCurrentWeather() {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  WeatherHome(),),);
      },
      child: Container(
        decoration: BoxDecoration(
            color: context.watch<ThemeProvider>().weatherCard,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 1), // changes position of shadow
              )
            ]),
        margin: EdgeInsets.only(left: 16, right: 16, top: 30),
        child: BlocBuilder(
          bloc: widget.bloc,
          builder: (context, state) {
            // var weather = state.weather;

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                          top: 8,
                          bottom: 8,
                        ),
                        child: Text(
                          "Weather",
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: context.watch<ThemeProvider>().textColor,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 8,
                          right: 8,
                          top: 0,
                          bottom: 0,
                        ),
                        child: Row(
                          children: [
                            _widgetTextDesign("Temperature: "),
                            state is HomeInitial || state is HomeGetDataLoading
                                ? _widgetTextDesign("...°C")
                                : state is HomeGetDataSuccess
                                    ? _widgetTextDesign("${state.weather.temp}°C")
                                    : _widgetTextDesign("NOT FOUND"),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                          top: 8,
                          bottom: 8,
                        ),
                        child: Row(
                          children: [
                            _widgetTextDesign("Humidity: "),
                            state is HomeInitial || state is HomeGetDataLoading
                                ? _widgetTextDesign("...%")
                                : state is HomeGetDataSuccess
                                    ? _widgetTextDesign(
                                        "${state.weather.humidity}%")
                                    : _widgetTextDesign("NOT FOUND"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    state is HomeInitial || state is HomeGetDataLoading
                        ? getWeatherIcon('')
                        : state is HomeGetDataSuccess
                            ? getWeatherIcon(state.weather.icon ?? '')
                            : getWeatherIcon(''),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                        top: 8,
                        bottom: 8,
                      ),
                      child: state is HomeInitial || state is HomeGetDataLoading
                          ? _widgetTextDesign("...")
                          : state is HomeGetDataSuccess
                              ? _widgetTextDesign(state.weather.description ?? '')
                              : _widgetTextDesign("NOT FOUND"),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _widgetTopInfo() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
      height: 80,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome",
                    style: TextStyle(
                        fontSize: 20,
                        color: context.watch<ThemeProvider>().textColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    LocalStorage.getString(LocalStorageKey.fullname),
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: context.watch<ThemeProvider>().textColor),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: LocalStorage.getString(LocalStorageKey.avatar).isNotEmpty ? Image.network(
                    LocalStorage.getString(LocalStorageKey.avatar),
                    width: 60.0,
                    height: 60.0,
                    fit: BoxFit.cover,
                  ): Image.asset(
                    'assets/images/ngotruongan.jpg',
                    width: 60.0,
                    height: 60.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _widgetTextDesign(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        color: context.watch<ThemeProvider>().textColor,
      ),
    );
  }
}
