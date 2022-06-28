import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_khairat_admin/DAO/member_dao.dart';
import 'package:my_khairat_admin/DAO/mosque_dao.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/models/member.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class UpdateMember extends StatefulWidget {
  const UpdateMember({
    required this.member,
    required this.memberDAO,
    Key? key,
  }) : super(key: key);

  final MemberDAO memberDAO;
  final Member member;

  @override
  State<UpdateMember> createState() => _UpdateMemberState();
}

class _UpdateMemberState extends State<UpdateMember> {
  late TextEditingController _memberNoController;
  final FocusNode _memberNoFocus = FocusNode();

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
    _memberNoController = TextEditingController(
        text: widget.member.memberNo == null
            ? ''
            : widget.member.memberNo.toString());
    selectedMonth = widget.member.expireMonth;
    selectedYear = widget.member.expireYear;
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
            'Sunting',
            style: TextStyle(color: AppColor.primary),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          alignment: Alignment.center,
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                'No Ahli',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 1.h),
              customTextFormField(
                hintText: 'No Ahli',
                icon: Ionicons.person,
                controller: _memberNoController,
                focusNode: _memberNoFocus,
              ),
              SizedBox(height: 2.h),
              Text(
                'Tempoh',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 1.h),
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
              SizedBox(height: 3.h),
              customTextButton(
                label: 'Simpan',
                onPressed: () async {
                  MosqueDAO mosqueDAO =
                      Provider.of<MosqueDAO>(context, listen: false);
                  bool res = await widget.memberDAO
                      .updateMember(mosqueDAO.mosque!.id!, {
                    'person_ic': widget.member.ic,
                    'person_member_no': _memberNoController.text,
                    'person_expire_month': selectedMonth,
                    'person_expire_year': selectedYear,
                  });

                  widget.member.memberNo = int.parse(_memberNoController.text);
                  widget.member.expireMonth = selectedMonth;
                  widget.member.expireYear = selectedYear;

                  Navigator.pop(context, widget.member);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
