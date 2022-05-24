import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/DAO/village_dao.dart';
import 'package:my_khairat_admin/constants/popup.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/controllers/village_controller.dart';
import 'package:my_khairat_admin/models/mosque.dart';
import 'package:my_khairat_admin/models/village.dart';
import 'package:my_khairat_admin/pages/home/village/add_village.dart';
import 'package:my_khairat_admin/pages/home/village/edit_village.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PageVillage extends StatefulWidget {
  const PageVillage({required this.mosque, Key? key}) : super(key: key);

  final Mosque mosque;

  @override
  State<PageVillage> createState() => _PageVillageState();
}

enum Menu {
  edit,
  delete,
}

class _PageVillageState extends State<PageVillage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VillageDAO>(
      create: (context) => VillageDAO(widget.mosque.id!),
      child: Consumer<VillageDAO>(
        builder: (context, villageDAO, child) {
          List<Village> villages = villageDAO.villages;
          return Scaffold(
            appBar: customAppBar(
              context: context,
              title: Text(
                'Kariah',
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
                    width: double.infinity,
                    margin:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    child: TextButton.icon(
                      onPressed: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => AddVillage(
                                    mosqueID: widget.mosque.id!,
                                    villageDAO: villageDAO,
                                  ))).whenComplete(() {
                        setState(() {});
                      }),
                      style: TextButton.styleFrom(
                        backgroundColor: AppColor.primary,
                      ),
                      icon: Icon(
                        Ionicons.add_outline,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                      label: Text(
                        'Tambah Kariah',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    child: TextFormField(
                      controller: _searchController,
                      focusNode: _searchFocus,
                      decoration: InputDecoration(
                        hintText: 'Cari kariah',
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
                  SizedBox(height: 2.h),
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: villages.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 1.h),
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          margin: EdgeInsets.symmetric(horizontal: 3.w),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.sp),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.sp),
                            ),
                            padding: EdgeInsets.only(
                              left: 5.w,
                              top: 2.h,
                              bottom: 2.h,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    villages[index].name!,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                PopupMenuButton(
                                  color: Colors.white,
                                  elevation: 20,
                                  enabled: true,
                                  onSelected: (value) async {
                                    // EDIT
                                    if (value == Menu.edit) {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) => EditVillage(
                                                  villageDAO: villageDAO,
                                                  village: villages[index])));

                                      // DELETE
                                    } else if (value == Menu.delete) {
                                      dynamic res = await showDialog(
                                        context: context,
                                        builder: (context) =>
                                            confirmDeletePopup(
                                          context: context,
                                          title: 'Anda pasti untuk membuang?',
                                          content: Text(
                                            villages[index].name!,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );

                                      if (res != null) {
                                        if (res) {
                                          villageDAO
                                              .deleteVillage(villages[index]);
                                        }
                                      }
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      child: Row(
                                        children: [
                                          Icon(Ionicons.pencil,
                                              size: 12.sp, color: Colors.blue),
                                          SizedBox(width: 2.w),
                                          Text('Sunting',
                                              style:
                                                  TextStyle(fontSize: 12.sp)),
                                        ],
                                      ),
                                      value: Menu.edit,
                                    ),
                                    PopupMenuItem(
                                      child: Row(
                                        children: [
                                          Icon(Ionicons.trash,
                                              size: 12.sp, color: Colors.red),
                                          SizedBox(width: 2.w),
                                          Text('Buang',
                                              style:
                                                  TextStyle(fontSize: 12.sp)),
                                        ],
                                      ),
                                      value: Menu.delete,
                                    ),
                                  ],
                                ),
                                // IconButton(
                                //     onPressed: () {},
                                //     icon: Icon(
                                //       Ionicons.ellipsis_vertical_outline,
                                //       color: AppColor.primary,
                                //       size: 12.sp,
                                //     ))
                              ],
                            ),
                          ),
                        );
                      },
                    ),
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
