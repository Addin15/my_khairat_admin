import 'dart:developer';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/DAO/dependent_dao.dart';
import 'package:my_khairat_admin/DAO/member_dao.dart';
import 'package:my_khairat_admin/DAO/mosque_dao.dart';
import 'package:my_khairat_admin/models/mosque.dart';
import 'package:my_khairat_admin/pages/members/members_list.dart';
import 'package:my_khairat_admin/pages/members/register/dependent_registration.dart';
import 'package:my_khairat_admin/pages/members/register/member_registration.dart';
import 'package:my_khairat_admin/pages/home/home.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Members extends StatefulWidget {
  const Members({required this.mosqueDAO, Key? key}) : super(key: key);

  final MosqueDAO mosqueDAO;

  @override
  State<Members> createState() => _MembersState();
}

class _MembersState extends State<Members> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    Mosque? mosque = widget.mosqueDAO.mosque;

    return RefreshIndicator(
      onRefresh: () async {},
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MemberDAO(mosque!.id!)),
          ChangeNotifierProvider(
              create: (context) => DependentDAO(mosque!.id!)),
        ],
        builder: (context, child) {
          MemberDAO memberDAO = Provider.of<MemberDAO>(context, listen: true);
          return Scaffold(
            body: Container(
              width: 100.w,
              height: 100.h,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    isScrollable: false,
                    indicatorColor: AppColor.primary,
                    labelPadding: EdgeInsets.symmetric(vertical: 2.h),
                    tabs: [
                      Icon(
                        Ionicons.people_outline,
                        color: AppColor.primary,
                        size: 16.sp,
                      ),
                      Badge(
                        showBadge:
                            memberDAO.pendingMembers.isEmpty ? false : true,
                        position: BadgePosition.topEnd(),
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        badgeContent: Container(
                          padding: EdgeInsets.all(2.sp),
                          child: Text(
                            memberDAO.pendingMembers.length >= 10
                                ? '9+'
                                : memberDAO.pendingMembers.length.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Icon(
                            Ionicons.person_add_outline,
                            color: AppColor.primary,
                            size: 16.sp,
                          ),
                        ),
                      ),
                      Icon(
                        Ionicons.person_add_outline,
                        color: AppColor.primary,
                        size: 16.sp,
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        MembersList(),
                        MemberRegistration(),
                        DependentRegistration(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
