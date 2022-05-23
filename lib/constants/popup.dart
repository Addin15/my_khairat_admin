import 'package:flutter/material.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:sizer/sizer.dart';

confirmDeletePopup({
  required BuildContext context,
  required String title,
  required Widget content,
}) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.sp),
    ),
    alignment: Alignment.center,
    title: Text(
      title,
      textAlign: TextAlign.center,
    ),
    content: content,
    actionsAlignment: MainAxisAlignment.center,
    actions: [
      customTextButton(
        label: 'Batal',
        labelColor: AppColor.primary,
        backgroundColor: Colors.white,
        onPressed: () => Navigator.pop(context, false),
      ),
      customTextButton(
        label: 'Buang',
        backgroundColor: Colors.red,
        borderColor: Colors.red,
        onPressed: () => Navigator.pop(context, true),
      ),
    ],
  );
}
