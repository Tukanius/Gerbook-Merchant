import 'package:flutter/material.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';

class AddService extends StatefulWidget {
  final List<dynamic> data;
  const AddService({super.key, required this.data});

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      width: mediaQuery.size.width,
      height: mediaQuery.size.height * 0.5,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Text('data'),
    );
  }
}
