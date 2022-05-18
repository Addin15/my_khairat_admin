import 'package:flutter/material.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:sizer/sizer.dart';

class WidgetConstants {
  // custom text form field
  static customTextFormField({
    required String hintText,
    required IconData icon,
    required TextEditingController controller,
    required FocusNode focusNode,
    bool isObscured = false,
  }) =>
      TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: AppColor.primary,
          ),
          prefixIconColor: AppColor.primary,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: AppColor.primary, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: AppColor.primary, width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.red.shade700, width: 2),
          ),
        ),
        controller: controller,
        focusNode: focusNode,
        obscureText: isObscured,
      );

  // custom text button
  static customTextButton({
    required String label,
    required Function() onPressed,
    Color? labelColor,
    Color? backgroundColor,
  }) =>
      TextButton(
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColor.primary,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.7.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: AppColor.primary, width: 2),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            color: labelColor ?? Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
}
