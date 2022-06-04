import 'package:flutter/material.dart';
import 'package:my_khairat_admin/DAO/member_dao.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/models/member.dart';
import 'package:my_khairat_admin/pages/members/register/view_member_registration.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/cupertino.dart';

class MemberRegistration extends StatefulWidget {
  const MemberRegistration({Key? key}) : super(key: key);

  @override
  State<MemberRegistration> createState() => _MemberRegistrationState();
}

class _MemberRegistrationState extends State<MemberRegistration> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MemberDAO>(builder: (context, memberDAO, child) {
      List<Member> members = memberDAO.pendingMembers;
      return Column(
        children: [
          Text(
            'Pendaftaran Ahli',
            style: TextStyle(
                color: AppColor.primary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 1.h),
          Expanded(
            child: members.isEmpty
                ? Container(
                    alignment: Alignment.center,
                    child: const Text('Tiada pendaftaran'),
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: members.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      Member member = members[index];
                      return Container(
                        padding: EdgeInsets.all(1.h),
                        child: memberCard(
                          member: Member(
                            name: member.name,
                            ic: member.ic,
                            villageName: member.villageName,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      );
    });
  }

  Widget memberCard({
    required Member member,
  }) {
    return SizedBox(
      child: Card(
        elevation: 5,
        color: Colors.white,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                member.name!,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 0.8.h),
              Text(
                member.ic!,
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                member.villageName!,
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 1.h),
              Container(
                alignment: Alignment.centerRight,
                child: customTextButton(
                    label: 'Lihat Butiran',
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => CheckRegistration(
                                    member: member,
                                  )));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderPage extends StatelessWidget {
  const HeaderPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      padding: EdgeInsets.symmetric(horizontal: 3.h),
      child: Stack(
        children: [
          Container(
            height: 7.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColor.primary,
                  AppColor.secondary,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Pendaftaran Baru',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
