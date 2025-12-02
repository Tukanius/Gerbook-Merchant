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
          SvgPicture.asset(
            widget.data.type == "BOOKING"
                ? 'assets/svg/booking.svg'
                : widget.data.type == "REFUND"
                ? 'assets/svg/refund.svg'
                : widget.data.type == "FEE"
                ? 'assets/svg/fee.svg'
                : widget.data.type == "PROFIT"
                ? 'assets/svg/ashig.svg'
                : 'assets/svg/default_transaction.svg',
            height: 38,
            width: 38,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.data.type == "BOOKING"
                      ? '${translateKey.translate('transaction_type_booking')}'
                      : widget.data.type == "REFUND"
                      ? '${translateKey.translate('transaction_type_refund')}'
                      : widget.data.type == "FEE"
                      ? '${translateKey.translate('transaction_type_fee')}'
                      : widget.data.type == "PROFIT"
                      ? '${translateKey.translate('transaction_type_profit')}'
                      : widget.data.type == "CANCELED"
                      ? '${translateKey.translate('transaction_status_canceled')}'
                      : widget.data.type == "PENDING"
                      ? '${translateKey.translate('transaction_status_pending')}'
                      : widget.data.type == "CONFIRM"
                      ? '${translateKey.translate('transaction_status_confirmed')}'
                      : '-',

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
                '${widget.data.type == "FEE" || widget.data.type == "REFUND" ? '-' : '+'} ${Utils().formatCurrencyDouble(widget.data.amount?.toDouble() ?? 0)}',
                style: TextStyle(
                  color:
                      widget.data.type == "FEE" || widget.data.type == "REFUND"
                      ? redButton
                      : primary,
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
