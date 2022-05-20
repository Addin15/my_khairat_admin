import 'package:flutter/material.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/styles/app_color.dart';

class PagePayment extends StatefulWidget {
  const PagePayment({Key? key}) : super(key: key);

  @override
  State<PagePayment> createState() => _PagePaymentState();
}

class _PagePaymentState extends State<PagePayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetConstants.customAppBar(
        context,
        Text(
          'Rekod Pembayaran',
          style: TextStyle(
            color: AppColor.primary,
          ),
        ),
      ),
    );
  }
}
