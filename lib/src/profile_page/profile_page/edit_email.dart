import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:merchant_gerbook_flutter/api/auth_api.dart';
import 'package:merchant_gerbook_flutter/api/product_api.dart';
import 'package:merchant_gerbook_flutter/components/custom_loader/custom_loader.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/components/ui/form_textfield.dart';
import 'package:merchant_gerbook_flutter/models/user.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/src/profile_page/profile_page/get_otp.dart';
import 'package:provider/provider.dart';

class EditEmail extends StatefulWidget {
  final String type;
  const EditEmail({super.key, required this.type});

  @override
  State<EditEmail> createState() => _EditEmailState();
}

class _EditEmailState extends State<EditEmail> with AfterLayoutMixin {
  bool isLoadingButton = false;
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  TextEditingController controllerUrl = TextEditingController();
  bool isLoadingPage = true;
  User user = User();
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await callUser();
  }

  callUser() async {
    try {
      setState(() {
        isLoadingPage = true;
      });
      user = await AuthApi().me(false);
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = true;
      });
    }
  }

  onSubmit() async {
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isLoadingButton = true;
        });
        User data = User();
        widget.type == "EMAIL"
            ? data.newEmail = controllerUrl.text.trim()
            : data.newPhone = controllerUrl.text.trim();
        user = widget.type == "EMAIL"
            ? await ProductApi().putEmail(data)
            : await ProductApi().putPhone(data);

        final value = await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          isDismissible: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return OtpModal(
              type: widget.type == "EMAIL" ? 'EMAIL' : "PHONE",
              userName: controllerUrl.text,
              user: user,
            );
          },
        );
        if (value == true) {
          Navigator.of(context).pop(true);
        }

        setState(() {
          isLoadingButton = false;
        });
      } catch (e) {
        setState(() {
          isLoadingButton = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final translateKey = Provider.of<LocalizationProvider>(context);

    return Container(
      // height: mediaQuery.size.height * 0.9,
      width: mediaQuery.size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: white,
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: isLoadingPage == true
          ? SizedBox(height: 200, child: CustomLoader(loadColor: primary))
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 24),
                FormBuilder(
                  key: fbkey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormTextField(
                          inputType: TextInputType.text,
                          controller: controllerUrl,
                          colortext: black,
                          name: 'names',
                          color: white,
                          suffixIcon: null,
                          hintText: widget.type == "EMAIL"
                              ? "${translateKey.translate('email')}"
                              : "${translateKey.translate('phone_number')}",
                          hintTextColor: gray500,
                          labelColor: gray700,
                          labelText: widget.type == "EMAIL"
                              ? "${translateKey.translate('email')}"
                              : "${translateKey.translate('phone_number')}",
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: translateKey.translate(
                                'ta_uuriyn_medeelliyg_65b43f00',
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: isLoadingButton == true
                          ? () {}
                          : () async {
                              await onSubmit();
                            },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: primary,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        child: isLoadingButton == true
                            ? CustomLoader(loadColor: white)
                            : Text(
                                '${translateKey.translate('save')}',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(width: 16),
                  ],
                ),
                SizedBox(height: mediaQuery.padding.bottom + 16),
              ],
            ),
    );
  }
}
