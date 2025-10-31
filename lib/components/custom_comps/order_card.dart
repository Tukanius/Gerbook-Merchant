import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/models/booking_list.dart';
import 'package:merchant_gerbook_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';

class OrderCard extends StatefulWidget {
  final BookingList data;
  const OrderCard({super.key, required this.data});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    final translateKey = Provider.of<LocalizationProvider>(context);
    final mediaQuery = MediaQuery.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: white,
        border: Border.all(color: gray200),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.data.code ?? '-'}',
                      style: TextStyle(
                        color: gray600,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '${DateFormat("yyyy-MM-dd HH:mm").format(DateTime.parse(widget.data.createdAt!).toLocal())}',
                      style: TextStyle(
                        color: gray600,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.data.property?.name ?? '-'}',
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: gray800,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svg/location.svg',
                                width: 14,
                                height: 14,
                              ),
                              Expanded(
                                child: Text(
                                  '${widget.data.property?.addressString ?? '-'}',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: gray600,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          translateKey.translate('transaction_type_fee'),
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: gray600,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${Utils().formatCurrencyDouble(widget.data.totalAmount?.toDouble() ?? 0)}₮',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(width: mediaQuery.size.width, height: 1, color: gray200),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: primary100,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: EdgeInsets.all(8),
                        child: SvgPicture.asset(
                          'assets/svg/calendar_check.svg',
                          width: 16,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.data.days ?? '-'} ${translateKey.translate('nights')}',
                              style: TextStyle(
                                color: gray800,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${'${DateFormat("yyyy/MM/dd").format(DateTime.parse(widget.data.startDate!).toLocal())}'} - ${'${DateFormat("yyyy/MM/dd").format(DateTime.parse(widget.data.endDate!).toLocal())}'} 123312123312123312',
                              style: TextStyle(
                                color: gray600,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: greenSuccess,
                      ),
                      child: Text(
                        '${translateKey.translate('booking_status_label.${widget.data.status}')}',
                        style: TextStyle(
                          color: white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
