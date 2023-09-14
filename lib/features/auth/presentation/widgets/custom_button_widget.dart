import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_theme/app_text_style.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/extentions/media_query.dart';

class CustomButtonWidget extends StatelessWidget {
  final String textButton;
  final void Function() onPressed;
  const CustomButtonWidget({
    super.key, required this.textButton, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppPadding.paddingTwenty.w),
      child: SizedBox(
        width: context.screenWidth,
        height: context.screenHeight / 13.5,
        child: OutlinedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(radiusTwelve.r)),
              ),
            ),
          ),
          child: Text(
            textButton,
            style: AppTextStyle.textStyle4,
          ),
        ),
      ),
    );
  }
}