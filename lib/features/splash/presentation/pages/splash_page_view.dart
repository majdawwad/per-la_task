import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app_theme/app_theme.dart';
import '../../../../core/constants/app_assets_route.dart';
import '../../../../core/extentions/media_query.dart';

class SplashPageView extends StatefulWidget {
  const SplashPageView({Key? key}) : super(key: key);

  @override
  SplashPageViewState createState() => SplashPageViewState();
}

class SplashPageViewState extends State<SplashPageView> {
  bool _a = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 700), () {
      if (mounted) {
        setState(() {
          _a = !_a;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _timer = Timer(const Duration(milliseconds: 2000), () {
      if (mounted) {
        setState(() {
          context.go(Uri(path: "/sign-in-page").toString());
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 2000),
            curve: Curves.fastLinearToSlowEaseIn,
            width: _a ? context.screenWidth : 0.w,
            height: context.screenHeight,
            color: white,
          ),
          Center(
            child: Image.asset(
              AppAssetsRoute.logo,
              height: 75.h,
              width: 75.w,
              color: primaryColor,
              filterQuality: FilterQuality.high,
            ),
          ),
        ],
      ),
    );
  }
}


