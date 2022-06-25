import 'package:flutter/material.dart';
import 'package:my_khairat_admin/constants/widget_constants.dart';
import 'package:my_khairat_admin/styles/app_color.dart';
import 'package:my_khairat_admin/styles/custom_text_field.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({Key? key}) : super(key: key);

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _bankOwnerController = TextEditingController();
  final TextEditingController _bankNoController = TextEditingController();
  final TextEditingController _monthlyPaymentController =
      TextEditingController();

  final FocusNode _bankNameFocus = FocusNode();
  final FocusNode _bankOwnerFocus = FocusNode();
  final FocusNode _bankNoFocus = FocusNode();
  final FocusNode _monthlyPaymentFocus = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onPressed: () {},
                child: const Text(
                  'Selesai',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
