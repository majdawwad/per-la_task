import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AppTransition {
  static CustomTransitionPage<dynamic> customTransition(
      GoRouterState state, Widget page) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: page,
      transitionDuration: const Duration(milliseconds: 2000),
      transitionsBuilder: (context, animation, anotherAnimation, child) {
        animation = CurvedAnimation(
          curve: Curves.fastLinearToSlowEaseIn,
          parent: animation,
        );
        return SlideTransition(
          position: Tween(
            begin: Offset(1.0.w, 0.0.h),
            end: Offset(0.0.w, 0.0.h),
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}
