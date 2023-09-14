import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_theme/app_theme.dart';
import '../../../../core/constants/constants.dart';

class DrawerButtonWidget extends StatelessWidget {
  final void Function() onTap;
  final String imagePath;
  const DrawerButtonWidget({
    super.key,
    required this.onTap,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
          top: AppPadding.paddingTwenty.h,
          left: AppPadding.paddingTwenty.w,
        ),
        child: Container(
          height: 50.h,
          width: 50.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: foregroundColor,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.paddingEight.w,
              vertical: AppPadding.paddingEight.h,
            ),
            child: Center(
              child: CircleAvatar(
                backgroundColor: foregroundColor,
                radius: radiusSeventeen.r,
                backgroundImage: AssetImage(imagePath),
              ),
            ),
          ),
        ),
      ),
    );
  }
}