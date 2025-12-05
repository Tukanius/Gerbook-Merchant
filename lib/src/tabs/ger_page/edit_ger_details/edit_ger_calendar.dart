// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/src/tabs/ger_page/edit_ger_details/edit_calendar_lock.dart';
import 'package:provider/provider.dart';

class EditGerCalendarArguments {
  final String id;
  EditGerCalendarArguments({required this.id});
}

class EditGerCalendar extends StatefulWidget {
  final String id;
  static const routeName = "EditGerCalendar";
  const EditGerCalendar({super.key, required this.id});

  @override
  State<EditGerCalendar> createState() => _EditGerCalendarState();
}

class _EditGerCalendarState extends State<EditGerCalendar> {
  bool isLoading = false;
  DateTime _currentMonth = DateTime.now();

  List<DailyInfo> _generateMonthData(DateTime month) {
    List<DailyInfo> data = [];
    int daysInMonth = DateTime(month.year, month.month + 1, 0).day;

    for (int i = 1; i <= daysInMonth; i++) {
      data.add(
        DailyInfo(
          date: DateTime(month.year, month.month, i),
          price: 0,
          bookings: 0,
          available: 1,
          locked: 0,
        ),
      );
    }
    return data;
  }

  // ⬅️ Сар солих: Өмнөх сар
  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    });
  }

  // ➡️ Сар солих: Дараагийн сар
  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    });
  }

  Color primaryTextColor = Color(0xFF344054);
  Color secondaryTextColor = Color(0xFF667085);
  Color borderColor = Color(0xFFEAECF0);
  Color disabledColor = Color(0xFFE5E7EB);
  Color todayColor = Color(0xff326144);

  @override
  Widget build(BuildContext context) {
    final translateKey = Provider.of<LocalizationProvider>(context);
    List<DailyInfo> monthData = _generateMonthData(_currentMonth);
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        shape: Border(bottom: BorderSide(color: gray200, width: 2)),
        toolbarHeight: 56,
        elevation: 0,
        titleSpacing: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: isLoading == true
              ? () {}
              : () {
                  Navigator.of(context).pop();
                },
          child: Row(
            children: [
              SizedBox(width: 16),
              SvgPicture.asset('assets/svg/chevron_left.svg'),
            ],
          ),
        ),
        title: Text(
          '${translateKey.translate('calendar')}',
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: gray800,
          ),
        ),
        // actions: [
        //   Row(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       GestureDetector(
        //         onTap: () {},
        //         child: Container(
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(12),
        //             color: white,
        //             border: Border.all(color: gray200),
        //           ),
        //           padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        //           child: Text(
        //             '${translateKey.translate('house_lock')}',
        //             style: TextStyle(
        //               color: black,
        //               fontSize: 14,
        //               fontWeight: FontWeight.w400,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        //   SizedBox(width: 8),
        // ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ⬅️ Өмнөх сар
                GestureDetector(
                  onTap: _previousMonth,
                  child: Container(
                    // color: blue200,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: gray200),
                    ),
                    padding: EdgeInsets.all(2),
                    child: SvgPicture.asset(
                      'assets/svg/chevron_left.svg',
                      color: black,
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // 2026 он есдүгээр сар
                Text(
                  '${_currentMonth.year} / ${DateFormat('MMMM').format(_currentMonth)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryTextColor,
                  ),
                ),

                GestureDetector(
                  onTap: _nextMonth,
                  child: Container(
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: gray200),
                    ),
                    padding: EdgeInsets.all(2),
                    child: SvgPicture.asset(
                      'assets/svg/chevron_right.svg',
                      color: black,
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: monthData.length,
              itemBuilder: (context, index) {
                return _buildDailyListItem(monthData[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyListItem(DailyInfo item) {
    final translateKey = Provider.of<LocalizationProvider>(context);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final itemDate = DateTime(item.date.year, item.date.month, item.date.day);

    final isPast = itemDate.isBefore(today);
    final isToday = itemDate.isAtSameMomentAs(today);

    // 🎨 Өнгөнүүдийг тодорхойлох
    final dayTextColor = isPast
        ? secondaryTextColor.withOpacity(0.5)
        : (isToday ? todayColor : primaryTextColor);

    final infoTitleColor = isPast
        ? secondaryTextColor.withOpacity(0.5)
        : secondaryTextColor;

    final infoValueColor = isPast
        ? primaryTextColor.withOpacity(0.5)
        : primaryTextColor;

    final greenColor = Color(0xFF00C9A7);
    final redColor = Colors.red;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: GestureDetector(
        onTap: isPast == true
            ? () {}
            : () async {
                final value = await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  isDismissible: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return EditCalendarLock(
                      date: '${today.toLocal()}',
                      id: widget.id,
                    );
                  },
                );
                if (value == true) {}
              },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isToday ? todayColor.withOpacity(0.1) : white,
            border: BoxBorder.all(color: borderColor),
            borderRadius: BorderRadius.circular(12),
            // border: Border(bottom: BorderSide(color: borderColor, width: 1)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 50,
                child: Column(
                  children: [
                    Text(
                      item.date.day.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: dayTextColor,
                      ),
                    ),
                    Text(
                      DateFormat('EEE').format(item.date),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: dayTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(
                      '${translateKey.translate('price')}:',
                      '${item.price}₮',
                      infoTitleColor,
                      infoValueColor,
                    ),
                    _buildInfoRow(
                      '${translateKey.translate('bookings')}:',
                      '${item.bookings}',
                      infoTitleColor,
                      isPast ? infoValueColor : greenColor,
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(
                      '${translateKey.translate('in_stock')}:',
                      '${item.available}',
                      infoTitleColor,
                      infoValueColor,
                    ),
                    _buildInfoRow(
                      '${translateKey.translate('locked')}:',
                      '${item.locked}',
                      infoTitleColor,
                      isPast ? infoValueColor : redColor,
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

  Widget _buildInfoRow(
    String title,
    String value,
    Color titleColor,
    Color valueColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: titleColor,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}

class DailyInfo {
  final DateTime date;
  final double price;
  final int bookings;
  final int available;
  final int locked;

  DailyInfo({
    required this.date,
    required this.price,
    required this.bookings,
    required this.available,
    required this.locked,
  });
}
