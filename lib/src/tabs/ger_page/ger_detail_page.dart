import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

class GerDetailPageArguments {
  final String id;
  GerDetailPageArguments({required this.id});
}

class GerDetailPage extends StatefulWidget {
  final String id;
  static const routeName = "GerDetailPage";
  const GerDetailPage({super.key, required this.id});

  @override
  State<GerDetailPage> createState() => _GerDetailPageState();
}

class _GerDetailPageState extends State<GerDetailPage> with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
