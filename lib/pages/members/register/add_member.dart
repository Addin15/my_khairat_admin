import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_khairat_admin/DAO/member_dao.dart';
import 'package:my_khairat_admin/DAO/mosque_dao.dart';
import 'package:my_khairat_admin/DAO/village_dao.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AddMember extends StatefulWidget {
  const AddMember({required this.memberDAO, Key? key}) : super(key: key);

  final MemberDAO memberDAO;

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _memberNoController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _icController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final FocusNode _memberNoFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _icFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _occupationFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();

  String? selectedVillage;
  int? selectedMonth;
  int? selectedYear;
  List<int?> years = [];

  bool isAdding = false;
  String errorText = '';

  calculateYear() {
    int currentYear = DateTime.now().year;

    for (int i = currentYear - 10; i < currentYear + 10; i++) {
      years.add(i);
    }
  }

  @override
  void initState() {
    calculateYear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VillageDAO>(builder: (context, villageDAO, child) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: customAppBar(
            context: context,
            title: Text(
              'Tambah Ahli',
              style: TextStyle(
                color: AppColor.primary,
              ),
            ),
          ),
          body: Stack(
            children: [
              Form(
                key: _formKey,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      errorText.isEmpty
                          ? const SizedBox.shrink()
                          : Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 3.w,
                                    vertical: 1.h,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.sp),
                                      color: Colors.red.withAlpha(150),
                                      border: Border.all(color: Colors.red)),
                                  child: Text(errorText),
                                ),
                                SizedBox(height: 2.h),
                              ],
                            ),
                      customTextFormField(
                        hintText: 'No Ahli',
                        icon: Icons.card_membership,
                        controller: _memberNoController,
                        focusNode: _memberNoFocus,
                        validator: (val) =>
                            val!.isEmpty ? 'Sila isi nombor ahli' : null,
                      ),
                      SizedBox(height: 2.h),
                      customTextFormField(
                        hintText: 'Name',
                        icon: Icons.person_outline,
                        controller: _nameController,
                        focusNode: _nameFocus,
                        validator: (val) =>
                            val!.isEmpty ? 'Sila isi nama' : null,
                      ),
                      SizedBox(height: 2.h),
                      customTextFormField(
                        hintText: 'No Kad Pengenalan',
                        icon: Icons.perm_identity,
                        controller: _icController,
                        focusNode: _icFocus,
                        validator: (val) =>
                            val!.isEmpty ? 'Sila isi no. kad pengenalan' : null,
                      ),
                      SizedBox(height: 2.h),
                      customTextFormField(
                        hintText: 'No Telefon',
                        icon: Icons.phone_outlined,
                        controller: _phoneController,
                        focusNode: _phoneFocus,
                        validator: (val) =>
                            val!.isEmpty ? 'Sila isi no telefon' : null,
                      ),
                      SizedBox(height: 2.h),
                      customTextFormField(
                        hintText: 'Pekerjaan',
                        icon: Icons.work_outline,
                        controller: _occupationController,
                        focusNode: _occupationFocus,
                        validator: (val) =>
                            val!.isEmpty ? 'Sila isi pekerjaan' : null,
                      ),
                      SizedBox(height: 2.h),
                      customTextFormField(
                        hintText: 'Alamat',
                        icon: Icons.my_location_outlined,
                        controller: _addressController,
                        focusNode: _addressFocus,
                        validator: (val) =>
                            val!.isEmpty ? 'Sila isi alamat' : null,
                      ),
                      SizedBox(height: 2.h),
                      DropdownButton(
                        isExpanded: true,
                        value: selectedVillage,
                        hint: const Text('-- Pilih Kampung --'),
                        items: [
                          ...villageDAO.villages.map((village) {
                            return DropdownMenuItem(
                              child: Text(village.name!),
                              value: village.id,
                            );
                          }).toList(),
                        ],
                        onChanged: (String? id) {
                          setState(() {
                            selectedVillage = id;
                          });
                        },
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButton(
                              isExpanded: true,
                              value: selectedMonth,
                              hint: const Text('-- Bulan --'),
                              items: const [
                                DropdownMenuItem(
                                  child: Text('Januari'),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text('Februari'),
                                  value: 2,
                                ),
                                DropdownMenuItem(
                                  child: Text('Mac'),
                                  value: 3,
                                ),
                                DropdownMenuItem(
                                  child: Text('April'),
                                  value: 4,
                                ),
                                DropdownMenuItem(
                                  child: Text('Mei'),
                                  value: 5,
                                ),
                                DropdownMenuItem(
                                  child: Text('Jun'),
                                  value: 6,
                                ),
                                DropdownMenuItem(
                                  child: Text('Julai'),
                                  value: 7,
                                ),
                                DropdownMenuItem(
                                  child: Text('Ogos'),
                                  value: 8,
                                ),
                                DropdownMenuItem(
                                  child: Text('September'),
                                  value: 9,
                                ),
                                DropdownMenuItem(
                                  child: Text('Oktober'),
                                  value: 10,
                                ),
                                DropdownMenuItem(
                                  child: Text('November'),
                                  value: 11,
                                ),
                                DropdownMenuItem(
                                  child: Text('Disember'),
                                  value: 12,
                                ),
                              ],
                              onChanged: (int? val) {
                                setState(() {
                                  selectedMonth = val;
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Expanded(
                            child: DropdownButton(
                              isExpanded: true,
                              value: selectedYear,
                              hint: const Text('-- Tahun --'),
                              items: [
                                ...years.map((year) {
                                  return DropdownMenuItem(
                                    child: Text(year.toString()),
                                    value: year,
                                  );
                                }).toList()
                              ],
                              onChanged: (int? val) {
                                setState(() {
                                  selectedYear = val;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 7.h),
                      customTextButton(
                        label: 'Tambah',
                        onPressed: () async {
                          FocusScope.of(context).unfocus();

                          setState(() {
                            isAdding = true;
                          });

                          if (_formKey.currentState!.validate() &&
                              selectedVillage != null &&
                              selectedMonth != null &&
                              selectedYear != null) {
                            log(selectedMonth.toString());
                            MosqueDAO mosqueDAO =
                                Provider.of<MosqueDAO>(context, listen: false);
                            bool res = await widget.memberDAO
                                .addMember(mosqueDAO.mosque!.id.toString(), {
                              'person_member_no':
                                  int.parse(_memberNoController.text),
                              'person_name': _nameController.text,
                              'person_ic': _icController.text,
                              'person_phone': _phoneController.text,
                              'person_occupation': _occupationController.text,
                              'person_address': _addressController.text,
                              'village_id': selectedVillage,
                              'person_expire_month': selectedMonth!,
                              'person_expire_year': selectedYear!,
                            });

                            if (res) {
                              Navigator.pop(context);
                            }

                            setState(() {
                              errorText = 'Masalah ketika pendaftaran';
                              isAdding = false;
                            });
                          } else {
                            setState(() {
                              isAdding = false;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              !isAdding
                  ? const SizedBox.shrink()
                  : Container(
                      color: Colors.white.withOpacity(0.4),
                      alignment: Alignment.center,
                      child: SpinKitChasingDots(
                        color: AppColor.primary,
                      ),
                    ),
            ],
          ),
        ),
      );
    });
  }
}
