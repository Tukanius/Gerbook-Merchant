// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:provider/provider.dart';

showSuccessDialog(context, String text) async {
  final local = Provider.of<LocalizationProvider>(context, listen: false);
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SvgPicture.asset('assets/svg/success1.svg'),
              Text(
                local.translate('successful'),
                style: TextStyle(
                  color: black,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '$text',
                style: TextStyle(
                  color: gray600,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.center,
              ),
              ButtonBar(
                buttonMinWidth: 100,
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                        Colors.transparent,
                      ),
                    ),
                    child: Text(
                      local.translate('close'),
                      style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
