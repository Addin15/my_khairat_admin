import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/DAO/member_dao.dart';
import 'package:my_khairat_admin/DAO/mosque_dao.dart';
import 'package:my_khairat_admin/models/mosque.dart';
import 'package:my_khairat_admin/pages/members/members_list.dart';
import 'package:my_khairat_admin/pages/members/register/dependent_registration.dart';
import 'package:my_khairat_admin/pages/members/register/existing_member_registration.dart';
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

class _MembersState extends State<Members>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();

  final FocusNode _searchFocus = FocusNode();

  int selectedTab = 0;
  TabController? _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    Mosque mosque = widget.mosqueDAO.mosque;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MemberDAO(mosque.id!)),
      ],
      child: Scaffold(
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
                onTap: (index) {
                  setState(() {
                    selectedTab = index;
                  });
                },
                tabs: [
                  Icon(
                    selectedTab == 0
                        ? Ionicons.people
                        : Ionicons.people_outline,
                    color: AppColor.primary,
                    size: 16.sp,
                  ),
                  Icon(
                    selectedTab == 1
                        ? Ionicons.person_add
                        : Ionicons.person_add_outline,
                    color: AppColor.primary,
                    size: 16.sp,
                  ),
                  Icon(
                    selectedTab == 2
                        ? Ionicons.person_add
                        : Ionicons.person_add_outline,
                    color: AppColor.primary,
                    size: 16.sp,
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const BouncingScrollPhysics(),
                  children: const [
                    MembersList(),
                    MemberRegistration(),
                    DependentRegistration(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
