import 'package:flutter/material.dart';
import 'package:my_khairat_admin/DAO/mosque_dao.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:my_khairat_admin/styles/custom_text_field.dart';

class EditBankDetails extends StatefulWidget {
  const EditBankDetails({
    required this.mosqueDAO,
    required this.bankName,
    required this.bankOwnerName,
    required this.bankAccountNo,
    required this.monthlyFee,
    Key? key,
  }) : super(key: key);

  final MosqueDAO mosqueDAO;
  final String bankName;
  final String bankOwnerName;
  final String bankAccountNo;
  final double monthlyFee;

  @override
  State<EditBankDetails> createState() => _EditBankDetailsState();
}

class _EditBankDetailsState extends State<EditBankDetails> {
  late TextEditingController _bankNameController;
  late TextEditingController _bankOwnerController;
  late TextEditingController _bankNoController;
  late TextEditingController _monthlyPaymentController;

  final FocusNode _bankNameFocus = FocusNode();
  final FocusNode _bankOwnerFocus = FocusNode();
  final FocusNode _bankNoFocus = FocusNode();
  final FocusNode _monthlyPaymentFocus = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    _bankNameController = TextEditingController(text: widget.bankName);
    _bankOwnerController = TextEditingController(text: widget.bankOwnerName);
    _bankNoController = TextEditingController(text: widget.bankAccountNo);
    _monthlyPaymentController =
        TextEditingController(text: widget.monthlyFee.toString());
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
            'Maklumat Bank',
            style: TextStyle(color: AppColor.primary),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white54,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Maklumat Bank',
                  style: TextStyle(
                    color: AppColor.primary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  hintText: 'Nama Bank',
                  focusNode: _bankNameFocus,
                  controller: _bankNameController,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  hintText: 'Nama Pemilik Bank',
                  focusNode: _bankOwnerFocus,
                  controller: _bankOwnerController,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  hintText: 'No Bank',
                  focusNode: _bankNoFocus,
                  controller: _bankNoController,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  hintText: 'Bayaran Bulanan',
                  focusNode: _monthlyPaymentFocus,
                  controller: _monthlyPaymentController,
                ),
                const SizedBox(height: 15),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Selesai',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
