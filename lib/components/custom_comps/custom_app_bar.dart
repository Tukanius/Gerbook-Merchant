import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';

class CustomAppBar extends StatefulWidget {
  final Function() onTap;
  const CustomAppBar({super.key, required this.onTap});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: white,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          widget.onTap();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [SvgPicture.asset('assets/svg/leading.svg')],
        ),
      ),
    );
  }
}
