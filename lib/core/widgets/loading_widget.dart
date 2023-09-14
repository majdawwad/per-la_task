import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_theme/app_theme.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0.h),
      child: Center(
        child: SizedBox(
          height: 30.0.h,
          width: 30.0.w,
          child: const CircularProgressIndicator(
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}