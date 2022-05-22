import 'package:flutter/material.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/styles/app_color.dart';

class ViewPlan extends StatefulWidget {
  const ViewPlan({Key? key}) : super(key: key);

  @override
  State<ViewPlan> createState() => _ViewPlanState();
}

class _ViewPlanState extends State<ViewPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetConstants.customAppBar(
        context: context,
        title: Text(
          'Pelan',
          style: TextStyle(color: AppColor.primary),
        ),
      ),
    );
  }
}
