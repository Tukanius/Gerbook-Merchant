// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/api/product_api.dart';
import 'package:merchant_gerbook_flutter/components/custom_loader/custom_loader.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/models/cancel_policy.dart';
import 'package:merchant_gerbook_flutter/models/result.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:provider/provider.dart';

class AddCancelPolicy extends StatefulWidget {
  final List<CancelPolicy>? initialSelected;
  final Function(List<CancelPolicy>) onSelectionChange;

  const AddCancelPolicy({
    super.key,
    this.initialSelected,
    required this.onSelectionChange,
  });

  @override
  State<AddCancelPolicy> createState() => _AddCancelPolicyState();
}

class _AddCancelPolicyState extends State<AddCancelPolicy>
    with AfterLayoutMixin {
  int page = 1;
  int limit = 30;
  Result cancelPolicy = Result();
  bool isLoadingCancelPolicy = true;
  bool isNoRefundSelected = false;
  List<CancelPolicy> selectedOffers = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialSelected != null) {
      selectedOffers = List.from(widget.initialSelected!);
    }
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await listOfCancelPolicy(page, limit);
  }

  listOfCancelPolicy(page, limit) async {
    cancelPolicy = await ProductApi().getCancelPolicies(
      ResultArguments(page: page, limit: limit),
    );
    setState(() {
      isLoadingCancelPolicy = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final translateKey = Provider.of<LocalizationProvider>(context);

    return Container(
      width: mediaQuery.size.width,
      height: mediaQuery.size.height * 0.9,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Stack(
        children: [
          isLoadingCancelPolicy == true
              ? CustomLoader()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 6),
                    Center(
                      child: Container(
                        width: 48,
                        height: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: gray800,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        translateKey.translate('add_discount'),
                        style: TextStyle(
                          color: gray900,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isNoRefundSelected = !isNoRefundSelected;

                          if (cancelPolicy.rows != null) {
                            if (isNoRefundSelected) {
                              for (var item in cancelPolicy.rows!) {
                                if (!selectedOffers.any(
                                  (element) => element.id == item.id,
                                )) {
                                  selectedOffers.add(item);
                                }
                              }
                            } else {
                              for (var item in cancelPolicy.rows!) {
                                selectedOffers.removeWhere(
                                  (element) => element.id == item.id,
                                );
                              }
                            }
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: white,
                          border: Border(bottom: BorderSide(color: gray100)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '${translateKey.translate('no_refund')}',
                                style: TextStyle(
                                  color: gray900,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: isNoRefundSelected ? primary : white,
                                border: Border.all(
                                  color: isNoRefundSelected ? primary : gray300,
                                ),
                              ),
                              child: isNoRefundSelected == true
                                  ? Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: SvgPicture.asset(
                                        'assets/svg/check.svg',
                                        color: white,
                                      ),
                                    )
                                  : SizedBox(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child:
                          cancelPolicy.rows != null &&
                              cancelPolicy.rows!.isNotEmpty
                          ? ListView.builder(
                              itemCount: cancelPolicy.rows!.length,
                              itemBuilder: (context, index) {
                                final data = cancelPolicy.rows![index];

                                // Check if this specific item is in our selected list
                                // We compare by ID (assuming _id exists) to be safe
                                final isSelected = selectedOffers.any(
                                  (element) => element.id == data.id,
                                );

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (isSelected) {
                                        // Remove using ID to ensure we remove the correct object
                                        selectedOffers.removeWhere(
                                          (element) => element.id == data.id,
                                        );
                                      } else {
                                        selectedOffers.add(data);
                                      }
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: white,
                                      border: Border(
                                        bottom: BorderSide(color: gray100),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '${data.name}',
                                            style: TextStyle(
                                              color: gray900,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                            color: isSelected ? primary : white,
                                            border: Border.all(
                                              color: isSelected
                                                  ? primary
                                                  : gray300,
                                            ),
                                          ),
                                          child: isSelected
                                              ? Padding(
                                                  padding: const EdgeInsets.all(
                                                    3.0,
                                                  ),
                                                  child: SvgPicture.asset(
                                                    'assets/svg/check.svg',
                                                    color: white,
                                                  ),
                                                )
                                              : SizedBox(),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : SizedBox(),
                    ),

                    SizedBox(height: 80),
                  ],
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: gray300)),
                color: white,
              ),
              padding: EdgeInsets.only(
                bottom: Platform.isIOS
                    ? MediaQuery.of(context).padding.bottom
                    : 16,
                left: 16,
                right: 16,
                top: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: white,
                              border: Border.all(color: gray300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  translateKey.translate('navigation_back'),
                                  style: TextStyle(
                                    color: gray700,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            widget.onSelectionChange(selectedOffers);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  translateKey.translate('save'),
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
