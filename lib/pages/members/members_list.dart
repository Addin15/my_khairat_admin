import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/DAO/member_dao.dart';
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
    return Consumer<MemberDAO>(
      builder: (context, memberDAO, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
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
                        contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
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
                      ))
                ],
              ),
              SizedBox(height: 1.h),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: const Text('Tiada pencarian'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
