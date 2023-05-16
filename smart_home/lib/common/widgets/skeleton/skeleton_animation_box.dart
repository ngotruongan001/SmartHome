import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_home/themes/app_colors.dart';

class SkeletonAnimatioBox extends StatefulWidget {
  final double height;
  final double width;
  final double radius;

  const SkeletonAnimatioBox(
      {Key? key,
      required this.height,
      required this.width,
      required this.radius})
      : super(key: key);

  @override
  createState() => SkeletonAnimatioBoxState();
}

class SkeletonAnimatioBoxState extends State<SkeletonAnimatioBox> {


  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey,
      highlightColor: AppColors.grey.withOpacity(0.43),
      period: const Duration(milliseconds: 1500),
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius),
            color: AppColors.grey.withOpacity(0.43),
),
      ),
    );
  }
}
