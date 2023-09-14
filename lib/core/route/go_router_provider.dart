import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/sign_in/sign_in_page_view.dart';
import '../../features/auth/presentation/pages/sign_up/sign_up_page_view.dart';
import '../../features/splash/presentation/pages/splash_page_view.dart';
import '../../features/todo_text/presentation/pages/todo_text_page_view.dart';
import '../util/app_transition.dart';
import 'router_name.dart';

class GoRouterProvider {
  static final GoRouter goRouter = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context, state) {
          return SplashPageView(
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: '/sign-in-page',
        name: signInRoute,
        pageBuilder: (BuildContext context, state) {
          return AppTransition.customTransition(state, const SignInPageView());
        },
      ),
      GoRoute(
        path: '/sign-up-page',
        name: signUpRoute,
        pageBuilder: (BuildContext context, state) {
          return AppTransition.customTransition(state, const SignUpPageView());
        },
      ),
      GoRoute(
        path: '/todo-text-page',
        name: todoTextRoute,
        pageBuilder: (BuildContext context, state) {
          return AppTransition.customTransition(state, const TodoTextPageView());
        },
      ),
    ],
  );
}
