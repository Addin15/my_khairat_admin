import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/DAO/dependent_dao.dart';
import 'package:my_khairat_admin/DAO/member_dao.dart';
import 'package:my_khairat_admin/DAO/mosque_dao.dart';
import 'package:my_khairat_admin/DAO/village_dao.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/models/member.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AddDependent extends StatefulWidget {
  const AddDependent({
    required this.memberDAO,
    required this.dependentDAO,
    Key? key,
  }) : super(key: key);

  final MemberDAO memberDAO;
  final DependentDAO dependentDAO;

  @override
  State<AddDependent> createState() => _AddDependentState();
}

class _AddDependentState extends State<AddDependent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _icController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _icFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _occupationFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();

  final TextEditingController _searchMemberController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  String? selectedRelation;
  String? selectedUser;

  bool isAdding = false;
  String errorText = '';

  @override
  void initState() {
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
              'Tambah Tanggungan Ahli',
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
                      GestureDetector(
                        onTap: () async {
                          List<Member> searchedMember = [];

                          String? selected = await showDialog(
                            context: context,
                            builder: (context) =>
                                StatefulBuilder(builder: (context, setState) {
                              return Dialog(
                                insetPadding: EdgeInsets.symmetric(
                                    horizontal: 3.w, vertical: 2.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.sp),
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3.w, vertical: 2.h),
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: [
                                      Text(
                                        'Pilih Ahli',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 2.h),
                                      customTextFormField(
                                          hintText: 'Cari...',
                                          icon: Ionicons.search,
                                          controller: _searchMemberController,
                                          focusNode: _searchFocus,
                                          onChanged: (val) {
                                            if (val.isEmpty) {
                                              setState(
                                                  () => searchedMember.clear());
                                            } else {
                                              List<Member> searched = widget
                                                  .memberDAO.members
                                                  .where((member) => member
                                                      .name!
                                                      .toLowerCase()
                                                      .contains(
                                                          val.toLowerCase()))
                                                  .toList();
                                              setState(() {
                                                searchedMember = searched;
                                              });
                                            }
                                          }),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: searchedMember.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context,
                                                  searchedMember[index].id);
                                            },
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.sp)),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 2.w,
                                                    vertical: 1.h),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.sp),
                                                ),
                                                child: Text(
                                                    searchedMember[index]
                                                        .name!),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          );

                          if (selected != null) {
                            setState(() {
                              selectedUser = selected;
                            });
                          }
                        },
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.sp),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.sp),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.w, vertical: 3.h),
                            child: Text(
                              selectedUser == null
                                  ? '-- Pilih Ahli --'
                                  : widget.memberDAO.members
                                      .where(
                                          (member) => member.id == selectedUser)
                                      .first
                                      .name!,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      selectedUser == null
                          ? const SizedBox.shrink()
                          : Column(
                              children: [
                                SizedBox(height: 2.h),
                                customTextFormField(
                                  hintText: 'Name Tanggungan',
                                  icon: Icons.person_outline,
                                  controller: _nameController,
                                  focusNode: _nameFocus,
                                  validator: (val) =>
                                      val!.isEmpty ? 'Sila isi nama' : null,
                                ),
                                SizedBox(height: 2.h),
                                customTextFormField(
                                  hintText: 'No Kad Pengenalan  Tanggungan',
                                  icon: Icons.perm_identity,
                                  controller: _icController,
                                  focusNode: _icFocus,
                                  validator: (val) => val!.isEmpty
                                      ? 'Sila isi no. kad pengenalan'
                                      : null,
                                ),
                                SizedBox(height: 2.h),
                                customTextFormField(
                                  hintText: 'No Telefon  Tanggungan',
                                  icon: Icons.phone_outlined,
                                  controller: _phoneController,
                                  focusNode: _phoneFocus,
                                  validator: (val) => val!.isEmpty
                                      ? 'Sila isi no telefon'
                                      : null,
                                ),
                                SizedBox(height: 2.h),
                                customTextFormField(
                                  hintText: 'Pekerjaan  Tanggungan',
                                  icon: Icons.work_outline,
                                  controller: _occupationController,
                                  focusNode: _occupationFocus,
                                  validator: (val) => val!.isEmpty
                                      ? 'Sila isi pekerjaan'
                                      : null,
                                ),
                                SizedBox(height: 2.h),
                                customTextFormField(
                                  hintText: 'Alamat  Tanggungan',
                                  icon: Icons.my_location_outlined,
                                  controller: _addressController,
                                  focusNode: _addressFocus,
                                  validator: (val) =>
                                      val!.isEmpty ? 'Sila isi alamat' : null,
                                ),
                                SizedBox(height: 2.h),
                                DropdownButton(
                                  isExpanded: true,
                                  value: selectedRelation,
                                  hint: const Text('-- Pilih Hubungan --'),
                                  items: const [
                                    DropdownMenuItem(
                                      child: Text('Ayah'),
                                      value: 'Ayah',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Ibu'),
                                      value: 'Ibu',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Nenek'),
                                      value: 'Nenek',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Atuk'),
                                      value: 'Atuk',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Adik'),
                                      value: 'Adik',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Abang'),
                                      value: 'Abang',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Akak'),
                                      value: 'Akak',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Ibu Mertua'),
                                      value: 'Ibu Mertua',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Ayah Mertua'),
                                      value: 'Ayah Mertua',
                                    ),
                                  ],
                                  onChanged: (String? val) {
                                    setState(() {
                                      selectedRelation = val;
                                    });
                                  },
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
                                        selectedRelation != null &&
                                        selectedUser != null) {
                                      MosqueDAO mosqueDAO =
                                          Provider.of<MosqueDAO>(context,
                                              listen: false);
                                      bool res = await widget.dependentDAO
                                          .addDependent(
                                        {
                                          'user_id': selectedUser,
                                          'dependent_name':
                                              _nameController.text,
                                          'dependent_ic': _icController.text,
                                          'dependent_phone':
                                              _phoneController.text,
                                          'dependent_occupation':
                                              _occupationController.text,
                                          'dependent_address':
                                              _addressController.text,
                                          'dependent_relation':
                                              selectedRelation,
                                          'mosque_id': mosqueDAO.mosque!.id,
                                          'verify': 1,
                                          'death_verify': 0,
                                        },
                                      );

                                      if (res) {
                                        Navigator.pop(context);
                                      }

                                      setState(() {
                                        errorText =
                                            'Masalah ketika pendaftaran';
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
