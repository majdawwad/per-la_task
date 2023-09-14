import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/route/router_name.dart';

import '../../../../../core/app_theme/app_text_style.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/extentions/media_query.dart';
import '../../../../../core/util/snackbar_message.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../../../core/widgets/text_form_field_widget.dart';
import '../../../../../dependency_injection.dart' as di;
import '../../../domain/entities/user.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../widgets/custom_auth_text_account.dart';
import '../../widgets/custom_button_widget.dart';

class SignInPageView extends StatefulWidget {
  const SignInPageView({Key? key}) : super(key: key);

  @override
  State<SignInPageView> createState() => _SignInPageViewState();
}

class _SignInPageViewState extends State<SignInPageView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) => di.sl<AuthBloc>(),
      child: Scaffold(
        body: _buildBoby(context: context),
      ),
    );
  }

  Widget _buildBoby({
    required BuildContext context,
  }) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthIsLoadedState) {
          SnackBarMessage.snackBarSuccessMessage(
            context: context,
            message: state.message,
          );
          context.pushReplacementNamed(todoTextRoute);
        } else if (state is AuthIsErrorState) {
          SnackBarMessage.snackBarErrorMessage(
            context: context,
            message: state.message,
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    maxHeight: constraints.maxHeight,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppPadding.paddingTwenty.h,
                      horizontal: AppPadding.paddingTwenty.w,
                    ),
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: AppPadding.paddingTwenty.h,
                                left: AppPadding.paddingTwenty.w,
                              ),
                              child: Text(
                                "welcome".tr(context),
                                style: AppTextStyle.textStyle1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: AppPadding.paddingTwenty.w,
                              ),
                              child: Text(
                                "enter_data".tr(context),
                                style: AppTextStyle.textStyle2,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: AppPadding.paddingThirty.h,
                                  left: AppPadding.paddingTwenty.w,
                                  right: AppPadding.paddingTwenty.w),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: AppPadding.paddingTwenty.h),
                                      child: Text(
                                        'phone number'.tr(context),
                                        style: AppTextStyle.textStyle3,
                                      ),
                                    ),
                                    TextFormFieldWidget(
                                      textEditingController: _phoneController,
                                      hintText: 'enter your phone number'.tr(context),
                                      iconDataPrefix: Icons.phone,
                                      filled: true,
                                      keyboardType: TextInputType.phone,
                                      validation: (value) {
                                        if (value!.isEmpty) {
                                          return "you must to enter your phone number".tr(context);
                                        } else if (value.isNotEmpty &&
                                            value.length < 9) {
                                          return "the name must not to be smaller than nine numbers".tr(context);
                                        }
                                        return null;
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: AppPadding.paddingTwenty.h,
                                          top: AppPadding.paddingTwenty.h),
                                      child: Text(
                                        'password'.tr(context),
                                        style: AppTextStyle.textStyle3,
                                      ),
                                    ),
                                    BlocBuilder<AuthBloc, AuthState>(
                                      builder: (context, state) {
                                        bool obsec = true;
                                        if (state is AuthInitial) {
                                          obsec = state.obscureText;
                                        } else if (state
                                            is AuthObsecureTextState) {
                                          obsec = state.obscureText;
                                        }
                                        return TextFormFieldWidget(
                                          textEditingController:
                                              _passwordController,
                                          hintText: 'enter your password'.tr(context),
                                          iconDataPrefix: Icons.lock,
                                          filled: true,
                                          obscureText: obsec,
                                          iconDataSuffix: obsec
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          onTapSuffix: () {
                                            context.read<AuthBloc>().add(
                                                  AuthToggleObscureTextEvent(
                                                    obscureText: obsec,
                                                  ),
                                                );
                                          },
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          validation: (value) {
                                            RegExp regex = RegExp(
                                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                            if (value!.isEmpty) {
                                              return 'you must to enter your password'.tr(context);
                                            } else {
                                              if (!regex.hasMatch(value)) {
                                                return 'enter valid password'.tr(context);
                                              } else if (value.length < 8) {
                                                return "the password must not to be smaller than eight numbers".tr(context);
                                              } else {
                                                return null;
                                              }
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: context.screenHeight / 2.5),
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                if (state is AuthIsLoadingState) {
                                  return const LoadingWidget();
                                }
                                return CustomButtonWidget(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      User user = User(
                                        phone: _phoneController.text.trim(),
                                        password:
                                            _passwordController.text.trim(),
                                      );

                                      context
                                          .read<AuthBloc>()
                                          .add(AuthSignInEvent(userData: user));
                                    }
                                  },
                                  textButton: "login".tr(context),
                                );
                              },
                            ),
                            CustomAuthTextAccount(
                              onPressed: () {
                                context
                                    .go(Uri(path: '/sign-up-page').toString());
                              },
                              textAccount: "don't have an account?".tr(context),
                              textButton: "register".tr(context),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
