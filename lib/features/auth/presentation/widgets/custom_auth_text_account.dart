import 'package:flutter/material.dart';

import '../../../../core/app_theme/app_text_style.dart';

class CustomAuthTextAccount extends StatelessWidget {
  final String textAccount;
  final String textButton;
  final void Function() onPressed;
  const CustomAuthTextAccount({
    super.key, required this.textAccount, required this.textButton, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          textAccount,
          style: AppTextStyle.textStyle5,
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            textButton,
            style: AppTextStyle.textStyle6,
          ),
        ),
      ],
    );
  }
}