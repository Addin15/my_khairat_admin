import 'package:flutter/material.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/models/payment.dart';
import 'package:my_khairat_admin/styles/app_color.dart';

class ViewPayment extends StatelessWidget {
  const ViewPayment({required this.payment, Key? key}) : super(key: key);

  final Payment payment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetConstants.customAppBar(
        context,
        Text(
          'Pembayaran',
          style: TextStyle(color: AppColor.primary),
        ),
      ),
    );
  }
}
