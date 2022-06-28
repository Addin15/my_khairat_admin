import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/DAO/dependent_dao.dart';
import 'package:my_khairat_admin/DAO/member_dao.dart';
import 'package:my_khairat_admin/models/dependent.dart';
import 'package:my_khairat_admin/models/member.dart';
import 'package:my_khairat_admin/pages/members/view_member.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MembersList extends StatefulWidget {
  const MembersList({Key? key}) : super(key: key);

  @override
  State<MembersList> createState() => _MembersListState();
}

class _MembersListState extends State<MembersList> {
  final TextEditingController _searchController = TextEditingController();

  final FocusNode _searchFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      child: Consumer<MemberDAO>(
        builder: (context, memberDAO, child) {
          List<Member> members = memberDAO.members;
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child:
                Consumer<DependentDAO>(builder: (context, dependentDAO, child) {
              List<Dependent> dependents = dependentDAO.dependents;
              return Column(
                children: [
                  Text(
                    'Senarai Ahli',
                    style: TextStyle(
                        color: AppColor.primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _searchController,
                          focusNode: _searchFocus,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Ionicons.search_outline,
                              color: AppColor.primary,
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 2.w),
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.sp),
                              borderSide: BorderSide(color: AppColor.primary),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.sp),
                              borderSide: BorderSide(color: AppColor.primary),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 1.w),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Ionicons.funnel_outline,
                          color: AppColor.primary,
                          size: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.5.h),
                  Expanded(
                    child: members.isNotEmpty
                        ? ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: members.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 2.h);
                            },
                            itemBuilder: (context, index) {
                              Member member = members[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => ViewMember(
                                        member: member,
                                        memberDAO: memberDAO,
                                        dependents: dependents
                                            .where(
                                                (d) => d.dependID == member.id)
                                            .toList(),
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.sp),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 3.w,
                                      vertical: 2.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        8.sp,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                member.memberNo.toString(),
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Tempoh: ' +
                                                  member.expireMonth
                                                      .toString() +
                                                  '/' +
                                                  member.expireYear.toString(),
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 1.5.h),
                                        Text(
                                          member.name!,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: const Text('Tiada ahli'),
                          ),
                  ),
                ],
              );
            }),
          );
        },
      ),
    );
  }
}
