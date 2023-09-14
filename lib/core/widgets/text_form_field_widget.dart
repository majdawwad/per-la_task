import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_theme/app_theme.dart';
import '../constants/constants.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final IconData? iconDataSuffix;
  final IconData? iconDataPrefix;
  final TextEditingController textEditingController;
  final String? Function(String?)? validation;
  final void Function()? onTapSuffix;
  final void Function(String)? onChange;
  final bool? obscureText;
  final bool? alignLabelWithHint;
  final bool? filled;
  final bool? readOnly;
  final TextStyle? style;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextAlign? textAlign;
  final FocusNode? focusNode;

  const TextFormFieldWidget({
    Key? key,
    this.labelText,
    this.hintText,
    this.iconDataSuffix,
    this.iconDataPrefix,
    required this.textEditingController,
    this.validation,
    this.onTapSuffix,
    this.onChange,
    this.obscureText,
    this.alignLabelWithHint,
    this.filled,
    this.readOnly,
    this.style,
    this.keyboardType,
    this.textInputAction,
    this.textAlign,
    this.focusNode
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      controller: textEditingController,
      focusNode: focusNode,
      validator: validation,
      cursorColor: primaryColor,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      readOnly: readOnly ?? false,
      style: style ?? const TextStyle(),
      textAlign: textAlign ?? TextAlign.start,
      obscureText: obscureText == null || obscureText == false ? false : true,
      onChanged: onChange,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        alignLabelWithHint: alignLabelWithHint,
        filled: filled,
        fillColor: foregroundColor,
        focusColor: primaryColor,
        hoverColor: foregroundColor,
        label: Text(
          labelText ?? "",
          style: TextStyle(
          fontSize: AppFontSize.fontSizeSixteen.sp,
          color: lightGrey2,
          fontWeight: FontWeight.w400,
          fontFamily: "Montserrat",
        ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: AppFontSize.fontSizeSixteen.sp,
          color: lightGrey2,
          fontWeight: FontWeight.w400,
          fontFamily: "Montserrat",
        ),
        suffixIcon: InkWell(
          onTap: onTapSuffix,
          child: Icon(
            iconDataSuffix,
            color: primaryColor,
          ),
        ),
        prefixIcon: Icon(
          iconDataPrefix,
          color: grey,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.w,
            color: foregroundColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.w,
            color: foregroundColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: red,
            width: 2.0.w,
          ),
        ),
      ),
    );
  }
}
