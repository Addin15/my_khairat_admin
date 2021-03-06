import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/DAO/grave_dao.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/models/grave.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:sizer/sizer.dart';

class AddGrave extends StatefulWidget {
  const AddGrave({required this.mosqueID, required this.graveDAO, Key? key})
      : super(key: key);

  final String mosqueID;
  final GraveDAO graveDAO;

  @override
  State<AddGrave> createState() => _AddGraveState();
}

class _AddGraveState extends State<AddGrave> {
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
            'Tambah Perkuburan',
            style: TextStyle(color: AppColor.primary),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          width: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama Perkuburan',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 1.h),
              customTextFormField(
                hintText: 'Nama Perkuburan',
                icon: Ionicons.browsers_outline,
                controller: _nameController,
                focusNode: _nameFocus,
                validator: (value) =>
                    value!.isEmpty ? 'Sila isi nama perkuburan' : null,
              ),
              SizedBox(height: 2.h),
              Text(
                'Alamat Perkuburan',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 1.h),
              customTextFormField(
                hintText: 'Alamat Perkuburan',
                icon: Ionicons.location_outline,
                controller: _addressController,
                focusNode: _addressFocus,
                validator: (value) =>
                    value!.isEmpty ? 'Sila isi alamt perkuburan' : null,
              ),
              SizedBox(height: 3.h),
              Center(
                child: customTextButton(
                  label: 'Tambah',
                  onPressed: () async {
                    dynamic res = await widget.graveDAO.addGrave(
                        widget.mosqueID,
                        Grave(
                          name: _nameController.text,
                          address: _addressController.text,
                        ));

                    Navigator.pop(context, res);
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
