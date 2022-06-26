import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/DAO/mosque_dao.dart';
import 'package:my_khairat_admin/config/secure_storage.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/controllers/auth_controller.dart';
import 'package:my_khairat_admin/models/mosque.dart';
import 'package:my_khairat_admin/pages/auth/login.dart';
import 'package:my_khairat_admin/pages/nav.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:sizer/sizer.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({required this.mosqueDAO, Key? key}) : super(key: key);

  final MosqueDAO mosqueDAO;

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _postcodeController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _bankOwnerNameController =
      TextEditingController();
  final TextEditingController _bankAccountNoController =
      TextEditingController();
  final TextEditingController _monthlyFeeController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phoneNoFocus = FocusNode();
  final FocusNode _postcodeFocus = FocusNode();
  final FocusNode _stateFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _bankNameFocus = FocusNode();
  final FocusNode _bankOwnerNameFocus = FocusNode();
  final FocusNode _bankAccountNoFocus = FocusNode();
  final FocusNode _monthlyFeeFocus = FocusNode();

  bool isLoading = false;

  XFile? image;

  @override
  Widget build(BuildContext context) {
    Mosque? mosque = widget.mosqueDAO.mosque;

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            color: Colors.white,
            child: SafeArea(
              child: Scaffold(
                body: Container(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 6.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'my',
                            style: TextStyle(
                              color: AppColor.primary,
                              fontWeight: FontWeight.normal,
                              fontSize: 24.sp,
                            ),
                          ),
                          Text(
                            'Khairat',
                            style: TextStyle(
                              color: AppColor.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.sp,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 1.h),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Mengesahkan Pendaftaran',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.sp),
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Form(
                        key: _formKey,
                        child: Expanded(
                          child: Center(
                            child: ListView(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              children: [
                                Text(
                                  'MAKLUMAT MASJID',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 10.sp),
                                ),
                                SizedBox(height: 1.h),
                                customTextFormField(
                                  hintText: 'Nama Masjid',
                                  icon: Ionicons.home,
                                  controller: _nameController,
                                  focusNode: _nameFocus,
                                  validator: (text) => text!.length >= 6
                                      ? null
                                      : 'Nama masjid mesti melebihi dari 6!',
                                ),
                                SizedBox(height: 2.h),
                                customTextFormField(
                                  hintText: 'No Telefon',
                                  icon: Ionicons.call,
                                  controller: _phoneNoController,
                                  focusNode: _phoneNoFocus,
                                  validator: (text) => text!.length >= 6
                                      ? null
                                      : 'Isi nombor telefon anda!',
                                ),
                                SizedBox(height: 2.h),
                                customTextFormField(
                                  hintText: 'Poskod',
                                  icon: Ionicons.locate,
                                  controller: _postcodeController,
                                  focusNode: _postcodeFocus,
                                  validator: (text) => text!.isNotEmpty
                                      ? null
                                      : 'Sila isi poskod',
                                ),
                                SizedBox(height: 2.h),
                                customTextFormField(
                                  hintText: 'Negeri',
                                  icon: Ionicons.navigate,
                                  controller: _stateController,
                                  focusNode: _stateFocus,
                                  validator: (text) => text!.isNotEmpty
                                      ? null
                                      : 'Sila isi maklumat negeri',
                                ),
                                SizedBox(height: 2.h),
                                customTextFormField(
                                  hintText: 'Alamat',
                                  icon: Ionicons.location,
                                  controller: _addressController,
                                  focusNode: _addressFocus,
                                  validator: (text) => text!.length >= 6
                                      ? null
                                      : 'Alamat hendaklah sekurangnya 6 angka!',
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'MAKLUMAT PEMBAYARAN KHAIRAT',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 10.sp),
                                ),
                                SizedBox(height: 1.h),
                                customTextFormField(
                                  hintText: 'Nama Bank',
                                  icon: Ionicons.card,
                                  controller: _bankNameController,
                                  focusNode: _bankNameFocus,
                                  validator: (val) => val!.isEmpty
                                      ? 'Sila isi nama bank'
                                      : null,
                                ),
                                SizedBox(height: 2.h),
                                customTextFormField(
                                  hintText: 'Nama Pemilik Akaun',
                                  icon: Ionicons.card,
                                  controller: _bankOwnerNameController,
                                  focusNode: _bankOwnerNameFocus,
                                  validator: (val) => val!.isEmpty
                                      ? 'Sila isi nama pemilik akaun'
                                      : null,
                                ),
                                SizedBox(height: 2.h),
                                customTextFormField(
                                    hintText: 'No Akaun Bank',
                                    icon: Ionicons.card,
                                    controller: _bankAccountNoController,
                                    focusNode: _bankAccountNoFocus,
                                    inputType: TextInputType.number,
                                    validator: (val) {
                                      if (val == null) {
                                        return null;
                                      }
                                      final n = num.tryParse(val);
                                      if (n == null) {
                                        return 'Sila isi nombor yang sah';
                                      }
                                      return null;
                                    }),
                                SizedBox(height: 2.h),
                                customTextFormField(
                                    hintText: 'Yuran Bulanan (RM)',
                                    icon: Ionicons.cash,
                                    controller: _monthlyFeeController,
                                    focusNode: _monthlyFeeFocus,
                                    inputType: TextInputType.number,
                                    validator: (val) {
                                      if (val == null) {
                                        return null;
                                      }
                                      final n = num.tryParse(val);
                                      if (n == null) {
                                        return 'Sila isi nombor yang sah';
                                      }
                                      return null;
                                    }),
                                SizedBox(height: 2.h),
                                Text(
                                  'SILA BUAT PEMBAYARAN DAN MUAT NAIK RESIT',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 10.sp),
                                ),
                                SizedBox(height: 2.h),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.sp),
                                    border: Border.all(color: AppColor.primary),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.w,
                                    vertical: 1.5.h,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Maybank',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Text(
                                        '7121991281121',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Text(
                                        'RM10',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 0.5.h),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4.w, vertical: 0.5.h),
                                          backgroundColor: image == null
                                              ? Colors.grey
                                              : AppColor.primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.sp),
                                          ),
                                        ),
                                        onPressed: () async {
                                          ImagePicker imagePicker =
                                              ImagePicker();

                                          await showDialog(
                                            context: context,
                                            builder: (context) => Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.sp),
                                              ),
                                              insetPadding:
                                                  EdgeInsets.symmetric(
                                                vertical: 10.h,
                                                horizontal: 10.w,
                                              ),
                                              child: SizedBox(
                                                height: 10.h,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        IconButton(
                                                          onPressed: () async {
                                                            XFile? file =
                                                                await imagePicker
                                                                    .pickImage(
                                                                        source:
                                                                            ImageSource.camera);
                                                            Navigator.pop(
                                                                context);

                                                            if (mounted &&
                                                                file != null) {
                                                              setState(() {
                                                                image = file;
                                                              });
                                                            }
                                                          },
                                                          icon: Icon(Ionicons
                                                              .camera_outline),
                                                        ),
                                                        Text('Kamera'),
                                                      ],
                                                    ),
                                                    SizedBox(width: 2.w),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        IconButton(
                                                          onPressed: () async {
                                                            XFile? file =
                                                                await imagePicker
                                                                    .pickImage(
                                                                        source:
                                                                            ImageSource.gallery);
                                                            Navigator.pop(
                                                                context);

                                                            if (mounted &&
                                                                file != null) {
                                                              setState(() {
                                                                image = file;
                                                              });
                                                            }
                                                          },
                                                          icon: Icon(Ionicons
                                                              .image_outline),
                                                        ),
                                                        Text('Galeri'),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Muat Naik',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      image == null
                                          ? const SizedBox.shrink()
                                          : Text(
                                              image!.name,
                                              textAlign: TextAlign.center,
                                            ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                customTextButton(
                                  label: 'Selesai',
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    setState(() {
                                      isLoading = true;
                                    });

                                    Mosque newMosque = Mosque(
                                      id: mosque!.id,
                                      email: mosque.email,
                                      name: _nameController.text,
                                      phone: _phoneNoController.text,
                                      postcode: _postcodeController.text,
                                      state: _stateController.text,
                                      address: _addressController.text,
                                      bankName: _bankNameController.text,
                                      bankOwnerName:
                                          _bankOwnerNameController.text,
                                      bankAccountNo:
                                          _bankAccountNoController.text,
                                      monthlyFee: double.parse(
                                          _monthlyFeeController.text),
                                    );

                                    if (_formKey.currentState!.validate() &&
                                        image != null) {
                                      // Complete profile logic
                                      log('complete');
                                      await widget.mosqueDAO
                                          .completeProfile(newMosque, image!);
                                    }

                                    setState(() {
                                      isLoading = false;
                                    });
                                  },
                                ),
                                SizedBox(height: 1.h),
                                customTextButton(
                                  label: 'Log Keluar',
                                  backgroundColor: Colors.red,
                                  borderColor: Colors.red,
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    await widget.mosqueDAO.logout();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        isLoading
            ? Container(
                color: Colors.white.withOpacity(0.3),
                alignment: Alignment.center,
                child: SpinKitChasingDots(color: AppColor.primary),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
