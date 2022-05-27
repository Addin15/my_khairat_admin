import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/DAO/grave_dao.dart';
import 'package:my_khairat_admin/constants/popup.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/models/grave.dart';
import 'package:my_khairat_admin/models/village.dart';
import 'package:my_khairat_admin/pages/home/grave/add_grave.dart';
import 'package:my_khairat_admin/pages/home/grave/edit_grave.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PageGrave extends StatefulWidget {
  const PageGrave({required this.mosqueID, Key? key}) : super(key: key);

  final String mosqueID;

  @override
  State<PageGrave> createState() => _PageGraveState();
}

enum Menu {
  edit,
  delete,
}

class _PageGraveState extends State<PageGrave> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GraveDAO>(
      create: (context) => GraveDAO(widget.mosqueID),
      child: Consumer<GraveDAO>(builder: (context, graveDAO, child) {
        List<Grave> graves = graveDAO.graves;

        return Scaffold(
          appBar: customAppBar(
            context: context,
            title: Text(
              'Kemaskini Kubur',
              style: TextStyle(
                color: AppColor.primary,
              ),
            ),
          ),
          body: Container(
            width: 100.w,
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => AddGrave(
                                  mosqueID: widget.mosqueID,
                                  graveDAO: graveDAO,
                                ))),
                    style: TextButton.styleFrom(
                      backgroundColor: AppColor.primary,
                    ),
                    icon: Icon(
                      Ionicons.add_outline,
                      color: Colors.white,
                      size: 18.sp,
                    ),
                    label: Text(
                      'Tambah Kubur',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                TextFormField(
                  controller: _searchController,
                  focusNode: _searchFocus,
                  decoration: InputDecoration(
                    hintText: 'Cari kubur',
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
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: graves.length,
                    separatorBuilder: (context, index) => SizedBox(height: 1.h),
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
                                  graves[index].name!,
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
                                            builder: (context) => EditGrave(
                                                graveDAO: graveDAO,
                                                grave: graves[index])));

                                    // DELETE
                                  } else if (value == Menu.delete) {
                                    dynamic res = await showDialog(
                                      context: context,
                                      builder: (context) => confirmDeletePopup(
                                        context: context,
                                        title: 'Anda pasti untuk membuang?',
                                        content: Text(
                                          graves[index].name!,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );

                                    if (res != null) {
                                      if (res) {
                                        graveDAO.deleteGrave(graves[index]);
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
                                            style: TextStyle(fontSize: 12.sp)),
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
                                            style: TextStyle(fontSize: 12.sp)),
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
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
