import 'package:flutter/material.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/styles/app_color.dart';

class ViewGrave extends StatefulWidget {
  const ViewGrave({Key? key}) : super(key: key);

  @override
  State<ViewGrave> createState() => _ViewGraveState();
}

class _ViewGraveState extends State<ViewGrave> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetConstants.customAppBar(
        context,
        Text(
          'Kemaskini Kubur',
          style: TextStyle(
            color: AppColor.primary,
          ),
        ),
      ),
    );
  }
}
