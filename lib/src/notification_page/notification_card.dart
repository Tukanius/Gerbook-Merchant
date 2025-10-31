import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/models/notify_list.dart';

class NotifyCard extends StatefulWidget {
  final NotifyList data;
  final Function() onClick;
  const NotifyCard({super.key, required this.data, required this.onClick});

  @override
  State<NotifyCard> createState() => _NotifyCardState();
}

class _NotifyCardState extends State<NotifyCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      child: Container(
        decoration: BoxDecoration(
          color: widget.data.hasGetItem == true ? white : gray50,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              SvgPicture.asset(
                widget.data.hasGetItem == true
                    ? 'assets/svg/check_not.svg'
                    : 'assets/svg/check.svg',
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.data.title}',
                          style: TextStyle(
                            color: widget.data.hasGetItem == true
                                ? gray600
                                : primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        widget.data.object != null
                            ? Text(
                                '${widget.data.object?.code}',
                                style: TextStyle(
                                  color: widget.data.hasGetItem == true
                                      ? gray600
                                      : primary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                    SizedBox(height: 2),
                    Text(
                      '${widget.data.description}',
                      style: TextStyle(
                        color: gray800,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${DateFormat('yyyy.MM.dd').format(DateTime.parse(widget.data.createdAt!).toLocal())}',
                          style: TextStyle(
                            color: gray500,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '${DateFormat('HH:mm').format(DateTime.parse(widget.data.createdAt!).toLocal())}',
                          style: TextStyle(
                            color: gray500,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
