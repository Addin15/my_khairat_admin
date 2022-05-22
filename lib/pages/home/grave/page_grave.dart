import 'package:flutter/material.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/models/village.dart';
import 'package:my_khairat_admin/styles/app_color.dart';

class PageGrave extends StatefulWidget {
  const PageGrave({Key? key}) : super(key: key);

  @override
  State<PageGrave> createState() => _PageGraveState();
}

class _PageGraveState extends State<PageGrave> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetConstants.customAppBar(
        context: context,
        title: Text(
          'Kemaskini Kubur',
          style: TextStyle(
            color: AppColor.primary,
          ),
        ),
      ),
    );
  }
}
