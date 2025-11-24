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
import 'package:merchant_gerbook_flutter/models/social_links.dart';
import 'package:merchant_gerbook_flutter/models/user.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:provider/provider.dart';

class EditSocials extends StatefulWidget {
  final String name;
  final String url;

  const EditSocials({super.key, required this.name, required this.url});

  @override
  State<EditSocials> createState() => _EditSocialsState();
}

class _EditSocialsState extends State<EditSocials> with AfterLayoutMixin {
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
        SocialLinks data = SocialLinks();
        if (widget.name == 'Facebook') {
          data.facebookLink = controllerUrl.text;
          data.viberLink = user.viberLink ?? '';
          data.telegramLink = user.telegramLink ?? '';
          data.lineLink = user.lineLink ?? '';
          data.whatsAppLink = user.whatsAppLink ?? '';
        } else if (widget.name == 'Viber') {
          data.facebookLink = user.facebookLink ?? '';
          data.viberLink = controllerUrl.text;
          data.telegramLink = user.telegramLink ?? '';
          data.lineLink = user.lineLink ?? '';
          data.whatsAppLink = user.whatsAppLink ?? '';
        } else if (widget.name == 'Telegram') {
          data.facebookLink = user.facebookLink ?? '';
          data.viberLink = user.viberLink ?? '';
          data.telegramLink = controllerUrl.text;
          data.lineLink = user.lineLink ?? '';
          data.whatsAppLink = user.whatsAppLink ?? '';
        } else if (widget.name == 'Line') {
          data.facebookLink = user.facebookLink ?? '';
          data.viberLink = user.viberLink ?? '';
          data.telegramLink = user.telegramLink ?? '';
          data.lineLink = controllerUrl.text;
          data.whatsAppLink = user.whatsAppLink ?? '';
        } else if (widget.name == 'Whats App') {
          data.facebookLink = user.facebookLink ?? '';
          data.viberLink = user.viberLink ?? '';
          data.telegramLink = user.telegramLink ?? '';
          data.lineLink = user.lineLink ?? '';
          data.whatsAppLink = controllerUrl.text;
        }
        await ProductApi().putSocials(data);
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
                          name: 'url',
                          color: white,
                          suffixIcon: null,
                          hintText: "${widget.url}",
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
