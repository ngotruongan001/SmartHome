import 'package:flutter/material.dart';
import 'package:smart_home/themes/app_colors.dart';
import 'package:smart_home/themes/app_dimension.dart';

class CardDesign extends StatelessWidget {
  const CardDesign({
    Key? key,
    this.widgetTop,
    required this.widgetBody,
    this.widgetBottom,
    this.radius,
    this.onPressed,
  }) : super(key: key);

  final Widget? widgetTop;
  final Widget widgetBody;
  final Widget? widgetBottom;
  final double? radius;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onPressed != null ? onPressed!() : print('');
      },
      child: Container(
        width: 1.sw,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 20.0.r),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.05),
                offset: Offset(4, 11),
                blurRadius: 32.r,
                spreadRadius: 10,
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widgetTop ?? const  SizedBox.shrink(),
            widgetTop != null ? SizedBox(
              width: 1.sw,
              height: 1.0.h,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.neutral7,
                ),
              ),
            ) : const SizedBox.shrink(),
            Padding(
              padding: EdgeInsets.only(
                bottom: 12.0.h,
                top: 12.0,
                left: 16.0.w,
                right: 10.w,
              ),
              child: widgetBody,
            ),
            widgetBottom == null
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      SizedBox(
                        width: 1.sw,
                        height: 1.0.h,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColors.neutral7,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 23.0.h,
                          left: 16.0.w,
                          right: 10.0.w,
                        ),
                        child: widgetBottom,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
