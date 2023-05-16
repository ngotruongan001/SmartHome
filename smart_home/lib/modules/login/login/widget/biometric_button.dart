import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_home/themes/app_colors.dart';
import 'package:smart_home/utils/app_images.dart';


class BiometricButton extends StatelessWidget {
  final Function onPressed;
  const BiometricButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SvgPicture.asset(
        AssetSVG.finger,
        color: AppColors.primary2,
        height: 50,
      ),
      onTap: () {
        onPressed();
      },
    );
  }
}
