import 'package:flutter/material.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/styles/app_color.dart';

class PageClaim extends StatefulWidget {
  const PageClaim({Key? key}) : super(key: key);

  @override
  State<PageClaim> createState() => _PageClaimState();
}

class _PageClaimState extends State<PageClaim> {
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
