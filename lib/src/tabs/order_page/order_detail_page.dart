import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

class OrderDetailPageArguments {
  final String id;
  OrderDetailPageArguments({required this.id});
}

class OrderDetailPage extends StatefulWidget {
  final String id;
  static const routeName = "OrderDetailPage";
  const OrderDetailPage({super.key, required this.id});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage>
    with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    // var res = await ProductApi().getOrderData(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
/*
model create 
api create 
get data 
 */