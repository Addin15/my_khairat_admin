import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/DAO/village_dao.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/controllers/village_controller.dart';
import 'package:my_khairat_admin/models/village.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:sizer/sizer.dart';

class EditVillage extends StatefulWidget {
  const EditVillage({required this.villageDAO, required this.village, Key? key})
      : super(key: key);

  final VillageDAO villageDAO;
  final Village village;

  @override
  State<EditVillage> createState() => _EditVillageState();
}

class _EditVillageState extends State<EditVillage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();

  @override
  void initState() {
    _nameController.text = widget.village.name!;
    _addressController.text = widget.village.address!;
    super.initState();
  }

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
                  label: 'Selesai',
                  onPressed: () async {
                    widget.villageDAO.editVillage(Village(
                      id: widget.village.id,
                      mosque: widget.village.mosque,
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
