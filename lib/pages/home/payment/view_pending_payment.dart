import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/models/payment.dart';
import 'package:my_khairat_admin/pages/home/payment/view_payment.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ViewPendingPayment extends StatefulWidget {
  const ViewPendingPayment({required this.pendingPayments, Key? key})
      : super(key: key);

  final List<Payment> pendingPayments;

  @override
  State<ViewPendingPayment> createState() => _ViewPendingPaymentState();
}

class _ViewPendingPaymentState extends State<ViewPendingPayment> {
  List<Payment> pendingPayments = [];

  refresh() {
    List<Payment> temp = pendingPayments;
    pendingPayments.clear();
    for (var payment in temp) {
      if (payment.status == 'pending') {
        pendingPayments.add(payment);
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    pendingPayments = widget.pendingPayments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: Text(
          'Semak Pembayaran',
          style: TextStyle(
            color: AppColor.primary,
          ),
        ),
      ),
      body: Container(
        width: 100.w,
        padding: EdgeInsets.only(top: 3.h),
        child: ListView.builder(
          itemCount: pendingPayments.length,
          itemBuilder: (context, index) {
            Payment p = pendingPayments[index];

            return Column(
              children: [
                Text(
                  DateFormat('dd/MM/yyyy')
                      .format(DateTime.parse(p.paymentDate!)),
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => ViewPayment(payment: p)))
                        .then((value) {
                      if (value != null) {
                        if (value) {
                          pendingPayments[index].status == 'completed';
                          refresh();
                        }
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.sp),
                      border: Border.all(color: Colors.black54),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                    margin:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            p.payerName!,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              p.startMonth == p.endMonth &&
                                      p.startYear == p.endYear
                                  ? '${p.startMonth}/${p.startYear}'
                                  : '${p.startMonth}/${p.startYear} hingga ${p.endMonth}/${p.endYear}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              'RM${p.amount!.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: AppColor.primary,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
