import 'package:flutter/material.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/styles/app_color.dart';

class ViewVillage extends StatefulWidget {
  const ViewVillage({Key? key}) : super(key: key);

  @override
  State<ViewVillage> createState() => _ViewVillageState();
}

class _ViewVillageState extends State<ViewVillage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetConstants.customAppBar(
        context,
        Text(
          'Kariah',
          style: TextStyle(
            color: AppColor.primary,
          ),
        ),
      ),
    );
  }
}
