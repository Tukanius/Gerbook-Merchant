import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/models/transaction.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/utils/utils.dart';
import 'package:provider/provider.dart';

class TransactionCard extends StatefulWidget {
  final Transaction data;
  const TransactionCard({super.key, required this.data});

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    final translateKey = Provider.of<LocalizationProvider>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: gray100)),
      ),
      child: Row(
        children: [
          SvgPicture.asset('assets/svg/ashig.svg'),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${translateKey.translate('${widget.data.type}')}',
                  style: TextStyle(
                    color: gray900,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${widget.data.description}',
                  style: TextStyle(
                    color: gray600,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${Utils().formatCurrencyDouble(widget.data.amount?.toDouble() ?? 0)}',
                style: TextStyle(
                  color: gray900,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${DateFormat("yyyy.MM.dd").format(DateTime.parse(widget.data.createdAt!).toLocal())}',
                style: TextStyle(
                  color: gray400,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
