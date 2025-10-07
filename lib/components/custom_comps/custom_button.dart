import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String labelText;
  final Function() onClick;
  final bool isLoading;
  final Color buttonColor;
  final Color textColor;
  final Color buttonLoaderColor;
  final double? circular;

  const CustomButton({
    super.key,
    required this.labelText,
    required this.onClick,
    required this.isLoading,
    required this.buttonColor,
    required this.textColor,
    required this.buttonLoaderColor,
    this.circular,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: widget.isLoading == false ? widget.onClick : () {},
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.isLoading == true
                      ? Container(
                          margin: EdgeInsets.only(right: 15),
                          width: 17,
                          height: 17,
                          child: Platform.isAndroid
                              ? CircularProgressIndicator(
                                  color: widget.buttonLoaderColor,
                                  strokeWidth: 2,
                                )
                              : CupertinoActivityIndicator(
                                  color: widget.buttonLoaderColor,
                                ),
                        )
                      : Text(
                          widget.labelText.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: widget.textColor,
                          ),
                        ),
                ],
              ),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.circular ?? 8),
              ),
              shadowColor: Colors.transparent,
              backgroundColor: widget.buttonColor,
            ),
          ),
        ),
      ],
    );
  }
}
