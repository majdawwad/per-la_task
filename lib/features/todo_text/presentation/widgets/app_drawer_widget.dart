import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/loaclization/cubit/locale_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/app_theme/app_text_style.dart';
import '../../../../core/app_theme/app_theme.dart';
import '../../../../core/app_theme/bloc/theme_bloc.dart';
import '../../../../core/constants/app_assets_route.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/extentions/media_query.dart';
import 'drawer_button_widget.dart';

class AppDrawerWidget extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  const AppDrawerWidget({
    Key? key,
    required this.sharedPreferences,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        bool swtVal = false;
        if (state is ThemeInitial) {
          swtVal = state.switchVal;
        } else if (state is LoadedThemeState) {
          swtVal = state.switchVal;
        }
        return Drawer(
          surfaceTintColor: grey,
          elevation: 2,
          width: context.screenWidth / 1.5,
          child: Builder(builder: (context) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.paddingTwenty.w,
                vertical: AppPadding.paddingTwenty.h,
              ),
              child: ListView(
                children: [
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: DrawerButtonWidget(
                      onTap: () => Scaffold.of(context).closeDrawer(),
                      imagePath: AppAssetsRoute.menuOpen,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: AppPadding.paddingTwenty.w,
                      top: AppPadding.paddingThirty.h,
                    ),
                    child: Text(
                      sharedPreferences.getString("USERNAME").toString(),
                      style: AppTextStyle.textStyle7.copyWith(
                        color: swtVal ? white : black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: AppPadding.paddingTwenty.w,
                      top: AppPadding.paddingfifty.h,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          AppAssetsRoute.sun,
                          color: swtVal ? white : black,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          "Dark Mode",
                          style: AppTextStyle.textStyle3.copyWith(
                            color: swtVal ? white : black,
                          ),
                        ),
                        SizedBox(width: 30.w),
                        CupertinoSwitch(
                          activeColor: green,
                          trackColor: grey,
                          value: swtVal,
                          onChanged: (_) {
                            if (swtVal) {
                              context.read<ThemeBloc>().add(
                                    ThemeChangedEvent(
                                      theme: AppTheme.values.first,
                                      switchVal: swtVal,
                                    ),
                                  );
                            } else {
                              context.read<ThemeBloc>().add(
                                    ThemeChangedEvent(
                                      theme: AppTheme.values.last,
                                      switchVal: swtVal,
                                    ),
                                  );
                             
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  BlocConsumer<LocaleCubit, LocaleState>(
                    listener: (context, state) {
                      if (state is ChangeLocaleLanguageState) {
                        context.pop();
                      }
                    },
                    builder: (context, state) {
                      if (state is ChangeLocaleLanguageState) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: AppPadding.paddingTwenty.w,
                            top: AppPadding.paddingThirty.h,
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                AppAssetsRoute.globalLang,
                                color: swtVal ? white : black,
                              ),
                              SizedBox(width: 10.w),
                              TextButton(
                                onPressed: () {
                                  context
                                      .read<LocaleCubit>()
                                      .changeLanguage("ar");
                                },
                                child: Text(
                                  "Arabic",
                                  style: AppTextStyle.textStyle3.copyWith(
                                      color: state.locale == const Locale("ar")
                                          ? primaryColor
                                          : swtVal
                                              ? white
                                              : black),
                                ),
                              ),
                              Text(
                                "/",
                                style: AppTextStyle.textStyle3,
                              ),
                              TextButton(
                                onPressed: () {
                                  context
                                      .read<LocaleCubit>()
                                      .changeLanguage("en");
                                },
                                child: Text(
                                  "English",
                                  style: AppTextStyle.textStyle3.copyWith(
                                      color: state.locale == const Locale("en")
                                          ? primaryColor
                                          : swtVal
                                              ? white
                                              : black),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: AppPadding.paddingTwenty.w,
                      top: AppPadding.paddingThirty.h,
                    ),
                    child: Row(
                      children: [
                        Image.asset(AppAssetsRoute.logout),
                        SizedBox(width: 10.w),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Logout",
                            style: AppTextStyle.textStyle3.copyWith(color: red),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
