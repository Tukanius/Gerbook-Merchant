import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';

class CustomLoader extends StatefulWidget {
  const CustomLoader({super.key});

  @override
  State<CustomLoader> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader> {
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? Center(
            child: CircularProgressIndicator(color: primary, strokeWidth: 1),
          )
        : Center(child: CupertinoActivityIndicator(color: primary));
  }
}
