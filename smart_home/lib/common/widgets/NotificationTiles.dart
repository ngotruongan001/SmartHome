import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/themes/app_colors.dart';
import 'package:smart_home/themes/app_dimension.dart';
import 'package:smart_home/themes/theme_provider.dart';

class NotificationTiles extends StatefulWidget {
  final String title, subtitle;
  final Function onTap;
  final bool enable;
  final String status;
  final String? date;
  const NotificationTiles(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.onTap,
      required this.enable,
      required this.status,
      this.date
      })
      : super(key: key);

  @override
  State<NotificationTiles> createState() => _NotificationTilesState();
}

class _NotificationTilesState extends State<NotificationTiles> {
  getPicture(String status) {
    switch (status) {
      case '1':
        return 'assets/images/anti-theft.png';
      case '2':
        return 'assets/images/fire.png';
      case '3':
        return 'assets/images/rain-warning.png';
      case '4':
        return 'assets/images/temp-warning.png';
      default:
        return 'assets/images/flash.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          height: 50.0,
          width: 50.0,
          padding: EdgeInsets.all(200),
          decoration: BoxDecoration(
              color: context.watch<ThemeProvider>().iconNotiCard,
              image: DecorationImage(
                image: AssetImage(
                  getPicture(
                    widget.status,
                  ),
                ),
                fit: BoxFit.cover,
              ))),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              color: Colors.deepOrange,
            ),
          ),
          Text(
            formarDate(widget.date ?? ''),
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 12.0.sp,
              color: AppColors.grey,
            ),
          )
        ],
      ),
      subtitle: Text(
        widget.subtitle,
        style: TextStyle(
          color: context.watch<ThemeProvider>().textColor,
        ),
      ),
      onTap: () {},
      enabled: widget.enable,
    );
  }

  String formarDate(String data){
    DateTime dateTime = DateTime.parse(data).add(Duration(hours: 7));
    String formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(dateTime);
    return formattedDate;
  }
}
