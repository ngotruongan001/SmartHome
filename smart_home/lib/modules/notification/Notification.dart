import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/common/widgets/NotificationTiles.dart';
import 'package:smart_home/common/widgets/skeleton/skeleton_animation_box.dart';
import 'package:smart_home/models/MessageModel.dart';
import 'package:smart_home/modules/notification/cubit/notification_cubit.dart';
import 'package:smart_home/themes/app_colors.dart';
import 'package:smart_home/themes/app_dimension.dart';
import 'package:smart_home/themes/theme_provider.dart';
import 'package:smart_home/viewmodel/DataProvider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  var bloc = NotificationCubit();

  @override
  void initState() {
    bloc.initStateCubit();
    // context.read<DataProvider>().fetchApiMessage();
  }

  @override
  Widget build(BuildContext context) {
    var a = context.watch<ThemeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notification",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold,
              color: a.textColor
          ),
        ),
        backgroundColor: Colors.transparent,
        leadingWidth: 0.0,
        elevation: 0,
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is NotificationGetDataLoading) {
            return SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.all(10.0.r),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for(var i= 0; i < 5; i++) _widgetLoading(),
                  ],
                ),
              ),
            );
          }
          if (state is NotificationGetDataFailure) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Text('${state.errorMessage}')],
            );
          }
          return ValueListenableBuilder<List<MessageModel>>(
              valueListenable: bloc.listData,
              builder: (context, datas, _) {
                if(datas.length == 0) {
                  return Center(child: Text('Notification is empty'),);
                }
                return Container(
                  height: 1000,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: datas.length,
                    itemBuilder: (BuildContext context, int index) {
                      return NotificationTiles(
                        title: datas[index].title,
                        subtitle: datas[index].body,
                        enable: true,
                        status: datas[index].status,
                          date: datas[index].createdAt,
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    NotificationPage())),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                  ),
                );
              });
        },
      ),
    );
  }

  Widget _widgetLoading(){
    return Container(
      height: 80.h,
      width: 1.sw,
      margin: EdgeInsets.only(bottom: 15.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: AppColors.border,
            width: 2.r),
      ),
      padding: EdgeInsets.only(right: 10.r, left: 10.r, top: 8.r, bottom: 8.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SkeletonAnimatioBox(
            height: 1.sh,
            width: 0.15.sw,
            radius: 6.r,
          ),
          SizedBox(width: 5.w,),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonAnimatioBox(
                height: 20.r,
                width: 1.sw,
                radius: 6.r,
              ),
              SizedBox(height: 5.w,),
              SkeletonAnimatioBox(
                height: 15.r,
                width: 0.5.sw,
                radius: 6.r,
              ),
            ],
          ),),
        ],
      ),
    );
  }
}
