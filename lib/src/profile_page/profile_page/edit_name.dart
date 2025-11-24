import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:merchant_gerbook_flutter/api/auth_api.dart';
import 'package:merchant_gerbook_flutter/api/product_api.dart';
import 'package:merchant_gerbook_flutter/components/custom_loader/custom_loader.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/components/ui/form_textfield.dart';
import 'package:merchant_gerbook_flutter/models/user.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:provider/provider.dart';

class EditName extends StatefulWidget {
  final String name;
  final String type;

  const EditName({super.key, required this.name, required this.type});

  @override
  State<EditName> createState() => _EditNameState();
}

class _EditNameState extends State<EditName> with AfterLayoutMixin {
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
      if (widget.type == "firstName") {
        controllerUrl.text = user.firstName ?? '';
      } else if (widget.type == "lastName") {
        controllerUrl.text = user.lastName ?? '';
      } else if (widget.type == "registerNo") {
        controllerUrl.text = user.registerNo ?? '';
      }
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
        if (widget.type == "firstName") {
          data.firstName = controllerUrl.text;
          data.lastName = user.lastName ?? '';
          data.registerNo = user.registerNo ?? '';
        } else if (widget.type == "lastName") {
          data.firstName = user.firstName ?? '';
          data.lastName = controllerUrl.text;
          data.registerNo = user.registerNo ?? '';
        } else if (widget.type == "registerNo") {
          data.firstName = user.firstName ?? '';
          data.lastName = user.lastName ?? '';
          data.registerNo = controllerUrl.text;
        }
        await ProductApi().putNames(data);
        Navigator.of(context).pop(true);
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
                          hintText: "${widget.name}",
                          hintTextColor: gray500,
                          labelColor: gray700,
                          labelText: "${widget.name}",
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
