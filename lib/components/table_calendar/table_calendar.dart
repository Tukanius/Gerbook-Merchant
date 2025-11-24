// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomTableCalendar extends StatefulWidget {
  final Function(DateTime? start, DateTime? end) onDateSelected;
  const CustomTableCalendar({super.key, required this.onDateSelected});

  @override
  State<CustomTableCalendar> createState() => _CustomTableCalendarState();
}

class _CustomTableCalendarState extends State<CustomTableCalendar> {
  bool isLoading = false;
  DateTime? rangeStart;
  DateTime? rangeEnd;
  DateTime focusedDay = DateTime.now();
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOn;
  @override
  Widget build(BuildContext context) {
    final translateKey = Provider.of<LocalizationProvider>(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  translateKey.translate('add_dates'),
                  style: TextStyle(
                    color: gray900,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset('assets/svg/x.svg'),
                ),
              ],
            ),
          ),
          Expanded(
            child: TableCalendar(
              shouldFillViewport: true,
              firstDay: DateTime.now().subtract(const Duration(days: 365)),
              lastDay: DateTime.now(),
              focusedDay: focusedDay,
              rangeSelectionMode: rangeSelectionMode,
              rangeStartDay: rangeStart,
              rangeEndDay: rangeEnd,
              onRangeSelected: (start, end, focus) {
                setState(() {
                  rangeStart = start;
                  rangeEnd = end;
                  focusedDay = focus;
                  rangeSelectionMode = RangeSelectionMode.toggledOn;
                });
              },
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextFormatter: (date, locale) =>
                    "${date.year} / ${date.month}",
                titleTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: black,
                ),
                leftChevronIcon: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: gray500,
                ),
                rightChevronIcon: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: gray500,
                ),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                // dowTextFormatter: (date, locale) {
                //   const days = ['Да', 'Мя', 'Лх', 'Пү', 'Ба', 'Бя', 'Ня'];
                //   return days[date.weekday - 1];
                // },
                weekdayStyle: TextStyle(
                  color: gray400,
                  // fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                weekendStyle: TextStyle(
                  color: gray400,
                  // fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: pinColor,
                  shape: BoxShape.circle,
                ),
                todayTextStyle: TextStyle(
                  color: gray700,
                  fontWeight: FontWeight.bold,
                ),
                selectedTextStyle: TextStyle(
                  color: white,
                  fontWeight: FontWeight.bold,
                ),
                rangeStartDecoration: BoxDecoration(
                  color: primary,
                  shape: BoxShape.circle,
                ),
                rangeStartTextStyle: TextStyle(
                  color: white,
                  fontWeight: FontWeight.bold,
                ),
                rangeEndDecoration: BoxDecoration(
                  color: primary,
                  shape: BoxShape.circle,
                ),
                rangeEndTextStyle: TextStyle(
                  color: white,
                  fontWeight: FontWeight.bold,
                ),
                rangeHighlightColor: primaryRange,
                withinRangeDecoration: BoxDecoration(color: transparent),
                withinRangeTextStyle: TextStyle(
                  color: gray700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: gray300)),
            ),
            padding: EdgeInsets.only(top: 16),
            child: Row(
              children: [
                SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.onDateSelected(null, null);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: gray300),
                        color: white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isLoading == true
                              ? Container(
                                  // margin: EdgeInsets.only(right: 15),
                                  width: 17,
                                  height: 17,
                                  child: Platform.isAndroid
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            color: white,
                                            strokeWidth: 2.5,
                                          ),
                                        )
                                      : Center(
                                          child: CupertinoActivityIndicator(
                                            color: white,
                                          ),
                                        ),
                                )
                              : Text(
                                  '${translateKey.translate('clear')}',
                                  style: TextStyle(
                                    color: black,
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
                      widget.onDateSelected(rangeStart, rangeEnd);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: primary,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isLoading == true
                              ? Container(
                                  // margin: EdgeInsets.only(right: 15),
                                  width: 17,
                                  height: 17,
                                  child: Platform.isAndroid
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            color: white,
                                            strokeWidth: 2.5,
                                          ),
                                        )
                                      : Center(
                                          child: CupertinoActivityIndicator(
                                            color: white,
                                          ),
                                        ),
                                )
                              : Text(
                                  '${translateKey.translate('search')}',
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
                SizedBox(width: 16),
              ],
            ),
          ),
          SizedBox(
            height: Platform.isIOS
                ? MediaQuery.of(context).padding.bottom
                : MediaQuery.of(context).padding.bottom + 16,
          ),
        ],
      ),
    );
  }
}
