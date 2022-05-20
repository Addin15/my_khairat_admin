import 'package:flutter/material.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/styles/app_color.dart';

class ViewPayment extends StatefulWidget {
  const ViewPayment({Key? key}) : super(key: key);

  @override
  State<ViewPayment> createState() => _ViewPaymentState();
}

class _ViewPaymentState extends State<ViewPayment> {
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
