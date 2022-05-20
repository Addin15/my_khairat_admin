import 'package:flutter/material.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:sizer/sizer.dart';

class CheckClaim extends StatefulWidget {
  const CheckClaim({Key? key}) : super(key: key);

  @override
  State<CheckClaim> createState() => _CheckClaimState();
}

class _CheckClaimState extends State<CheckClaim> {
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
