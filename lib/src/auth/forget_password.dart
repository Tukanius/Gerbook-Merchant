import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  static const routeName = "ForgetPassword";
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('ForgetPassword')));
  }
}
