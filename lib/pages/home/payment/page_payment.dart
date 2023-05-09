import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:my_khairat_admin/DAO/payment_dao.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/controllers/payment_controller.dart';
import 'package:my_khairat_admin/models/mosque.dart';
import 'package:my_khairat_admin/models/payment.dart';
import 'package:my_khairat_admin/pages/home/payment/view_pending_payment.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PagePayment extends StatefulWidget {
  const PagePayment({required this.mosqueID, Key? key}) : super(key: key);

  final String mosqueID;

  @override
  State<PagePayment> createState() => _PagePaymentState();
}

class _PagePaymentState extends State<PagePayment> {
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;

  List<Payment> payments = [];
  List<Payment> filteredPayments = [];
  List<Payment> pendingPayments = [];

  bool isLoading = true;

  getPayments() async {
    List<Payment> payments =
        await PaymentController.getPayments(widget.mosqueID);
    if (mounted) {
      //log('S' + payments.first.id.toString());
      setState(() {
        this.payments = payments;
        isLoading = false;
      });
    }
  }

  filterPendingPayments() {
    pendingPayments.clear();
    for (var payment in payments) {
      if (payment.status == 'pending') {
        pendingPayments.add(payment);
      }
    }
  }

  filterPayments() {
    filteredPayments.clear();
    for (var payment in payments) {
      if (DateTime.parse(payment.date!).month == selectedMonth &&
          payment.status == 'completed') {
        filteredPayments.add(payment);
      }
    }
  }

  @override
  void initState() {
    getPayments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int lastYear = DateTime.now().year - 1;
    if (isLoading) {
      return Container(
        color: Colors.white,
        child: SpinKitChasingDots(
          color: AppColor.primary,
        ),
      );
    } else {
      return ChangeNotifierProvider(
        create: (context) => PaymentDAO(widget.mosqueID),
        child: Consumer<PaymentDAO>(
          builder: (context, dao, child) {
            payments = dao.payments;
            filterPayments();
            filterPendingPayments();
            return Scaffold(
              appBar: customAppBar(
                context: context,
                title: Text(
                  'Rekod Pembayaran',
                  style: TextStyle(
                    color: AppColor.primary,
                  ),
                ),
              ),
              body: SizedBox(
                width: 100.w,
                child: Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                      child: Badge(
                        showBadge: pendingPayments.isNotEmpty ? true : false,
                        badgeContent: pendingPayments.isNotEmpty
                            ? Text(
                                pendingPayments.length.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : const SizedBox.shrink(),
                        position: BadgePosition(end: 2.w),
                        padding: EdgeInsets.all(8.sp),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => ViewPendingPayment(
                                          pendingPayments: pendingPayments,
                                          dao: dao,
                                        )));
                          },
                          style: TextButton.styleFrom(
                            minimumSize: Size(double.infinity, 6.h),
                            backgroundColor: Colors.white,
                            side: BorderSide(color: AppColor.primary),
                          ),
                          child: Text(
                            'Semak Pembayaran',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text('Bulan'),
                                DropdownButton(
                                  isExpanded: true,
                                  items: const [
                                    DropdownMenuItem(
                                      child: Text('Januari'),
                                      value: 1,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Februari'),
                                      value: 2,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Mac'),
                                      value: 3,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('April'),
                                      value: 4,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Mei'),
                                      value: 5,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Jun'),
                                      value: 6,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Julai'),
                                      value: 7,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Ogos'),
                                      value: 8,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('September'),
                                      value: 9,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Oktober'),
                                      value: 10,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('November'),
                                      value: 11,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Disember'),
                                      value: 12,
                                    ),
                                  ],
                                  onChanged: (int? month) {
                                    setState(() {
                                      selectedMonth = month!;
                                      filterPayments();
                                    });
                                  },
                                  value: selectedMonth,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Flexible(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text('Tahun'),
                                DropdownButton(
                                    isExpanded: true,
                                    items: List.generate(
                                      2,
                                      (index) {
                                        return DropdownMenuItem(
                                          child: Text(
                                              (lastYear + index).toString()),
                                          value: lastYear + index,
                                        );
                                      },
                                    ),
                                    value: selectedYear,
                                    onChanged: (int? year) {
                                      setState(() {
                                        selectedYear = year!;
                                        filterPayments();
                                      });
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: filteredPayments.isEmpty
                          ? const Center(child: Text('Tiada rekod'))
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: filteredPayments.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2.h, horizontal: 2.w),
                                  margin: EdgeInsets.only(bottom: 0.2.h),
                                  color: Colors.grey.shade400,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                              DateFormat('yyyy-MM-dd').format(
                                                  DateTime.parse(
                                                      filteredPayments[index]
                                                          .date!)),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                              ))),
                                      SizedBox(width: 1.5.w),
                                      Text(
                                        filteredPayments[index].status!,
                                        style: TextStyle(
                                          color:
                                              filteredPayments[index].status! ==
                                                      'pending'
                                                  ? Colors.white
                                                  : filteredPayments[index]
                                                              .status! ==
                                                          'completed'
                                                      ? Colors.green
                                                      : Colors.red,
                                          fontSize: 12.sp,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
