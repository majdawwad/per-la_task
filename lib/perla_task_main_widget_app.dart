import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/app_theme/bloc/theme_bloc.dart';
import 'core/extentions/media_query.dart';
import 'core/loaclization/cubit/locale_cubit.dart';
import 'core/route/go_router_provider.dart';
import 'dependency_injection.dart' as di;
import 'features/todo_text/presentation/bloc/todo_text/todo_text_bloc.dart';

class PerlaTaskMainWidgetApp extends StatelessWidget {
  PerlaTaskMainWidgetApp({super.key});

  final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<TodoTextBloc>()
            ..add(
              GetAllTodosTextsEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => LocaleCubit()..getSavedLanguage(),
        ),
        BlocProvider(
          create: (context) => ThemeBloc()..add(GetCurrentThemeEvent()),
        ),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, statelang) {
          if (statelang is ChangeLocaleLanguageState) {
            return ScreenUtilInit(
              designSize: Size(context.screenWidth, context.screenHeight),
              minTextAdapt: true,
              useInheritedMediaQuery: true,
              builder: (_, child) {
                return BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                    if (state is LoadedThemeState) {
                      return MaterialApp.router(
                        debugShowCheckedModeBanner: false,
                        locale: statelang.locale,
                        supportedLocales: localization.supportedLocales,
                        localizationsDelegates:
                            localization.localizationsDelegates,
                        localeResolutionCallback:
                            (deviceLocale, supportedLocales) {
                          for (var locale in supportedLocales) {
                            if (deviceLocale != null &&
                                deviceLocale.languageCode ==
                                    locale.languageCode) {
                              return deviceLocale;
                            }
                          }
                          return supportedLocales.first;
                        },
                        title: 'Perla Task App',
                        showSemanticsDebugger: false,
                        restorationScopeId: 'root',
                        routerConfig: GoRouterProvider.goRouter,
                        theme: state.themeData,
                        //darkTheme: appDarkTheme,
                        //themeMode: ThemeMode.light,
                      );
                    }
                    return const SizedBox();
                  },
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
