// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:provider/provider.dart';

class WarningDialog {
  final BuildContext? context;
  final Duration duration = const Duration(seconds: 30);

  WarningDialog({this.context});

  void show(String message, {VoidCallback? onPress}) {
    final local = Provider.of<LocalizationProvider>(context!, listen: false);

    final currentContext = context;
    showDialog(
      context: currentContext!,
      barrierDismissible: true,
      builder: (context) {
        // Future.delayed(duration, () {
        //   dialogService!.dialogComplete();
        //   if (Navigator.of(context, rootNavigator: true).canPop()) {
        //   }
        // });
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 75),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.only(top: 90, left: 20, right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      local.translate('warning'),
                      style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      message,
                      style: const TextStyle(
                        fontSize: 14,
                        color: black,
                        fontWeight: FontWeight.normal,
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
                            style: TextStyle(color: black),
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
              // Lottie.asset('assets/lottie/warning.json',
              //     height: 135, repeat: false),
            ],
          ),
        );
      },
    );
  }
}
