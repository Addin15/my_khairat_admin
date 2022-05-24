import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/DAO/village_dao.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/controllers/village_controller.dart';
import 'package:my_khairat_admin/models/mosque.dart';
import 'package:my_khairat_admin/models/village.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AddVillage extends StatefulWidget {
  const AddVillage({required this.mosqueID, required this.villageDAO, Key? key})
      : super(key: key);

  final String mosqueID;
  final VillageDAO villageDAO;

  @override
  State<AddVillage> createState() => _AddVillageState();
}

class _AddVillageState extends State<AddVillage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          title: Text(
            'Tambah Kampung',
            style: TextStyle(color: AppColor.primary),
          ),
        ),
        body: Container(
          width: 100.w,
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama Kampung',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 1.h),
              customTextFormField(
                hintText: 'Nama Kampung',
                icon: Ionicons.home,
                controller: _nameController,
                focusNode: _nameFocus,
                validator: (value) =>
                    value!.isNotEmpty ? null : 'Sila isi nama kampung',
              ),
              SizedBox(height: 2.h),
              Text(
                'Alamat Kampung',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 1.h),
              customTextFormField(
                hintText: 'Alamat Kampung',
                icon: Ionicons.map,
                controller: _addressController,
                focusNode: _addressFocus,
                validator: (value) =>
                    value!.isNotEmpty ? null : 'Sila isi alamat kampung',
              ),
              SizedBox(height: 3.h),
              Center(
                child: customTextButton(
                  label: 'Tambah',
                  onPressed: () async {
                    widget.villageDAO.addVillage(
                        widget.mosqueID,
                        Village(
                          name: _nameController.text,
                          address: _addressController.text,
                        ));

                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
