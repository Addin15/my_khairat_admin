import 'package:flutter/material.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/styles/app_color.dart';

class ViewClaim extends StatefulWidget {
  const ViewClaim({Key? key}) : super(key: key);

  @override
  State<ViewClaim> createState() => _ViewClaimState();
}

class _ViewClaimState extends State<ViewClaim> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetConstants.customAppBar(
        context,
        Text(
          'Semak Tuntutan',
          style: TextStyle(
            color: AppColor.primary,
          ),
        ),
      ),
    );
  }
}
