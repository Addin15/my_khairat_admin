import 'package:flutter/material.dart';
import 'package:my_khairat_admin/DAO/mosque_dao.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class NotVerified extends StatelessWidget {
  const NotVerified({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            width: 100.w,
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/forbidden.png',
                  width: 50.sp,
                  height: 50.sp,
                ),
                SizedBox(height: 3.h),
                Text(
                  'Akaun anda belum disahkan',
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 3.h),
                customTextButton(
                  label: 'Log Keluar',
                  onPressed: () {
                    MosqueDAO mosqueDAO =
                        Provider.of<MosqueDAO>(context, listen: false);
                    mosqueDAO.logout();
                  },
                  backgroundColor: Colors.red,
                  borderColor: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
