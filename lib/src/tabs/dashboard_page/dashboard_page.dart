// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/api/product_api.dart';
import 'package:merchant_gerbook_flutter/components/controller/refresher.dart';
import 'package:merchant_gerbook_flutter/components/custom_comps/transaction_card.dart';
import 'package:merchant_gerbook_flutter/components/custom_loader/custom_loader.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/models/chart_data.dart';
import 'package:merchant_gerbook_flutter/models/dashboard.dart';
import 'package:merchant_gerbook_flutter/models/result.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/src/tabs/dashboard_page/transaction_list_page.dart';
import 'package:merchant_gerbook_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with AfterLayoutMixin {
  Dashboard dashBoard = Dashboard();
  // ChartData profitChart = ChartData();
  Result profitchart = Result();
  Result orderchart = Result();
  bool isLoadingPage = true;
  int page = 1;
  int limit = 10;
  Result transactionList = Result();
  bool isLoadingTransaction = true;
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      dashBoard = await ProductApi().getDashBoardData();
      orderchart = await ProductApi().getOrderChart();
      profitchart = await ProductApi().getProfitChart();
      await listOfTransaction(page, limit);
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = true;
      });
    }
  }

  listOfTransaction(page, limit) async {
    transactionList = await ProductApi().getTransactionList(
      ResultArguments(page: page, limit: limit),
    );
    setState(() {
      isLoadingTransaction = false;
    });
  }

  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() {
      limit = 10;
    });
    await listOfTransaction(page, limit);
    refreshController.refreshCompleted();
  }

  onLoading() async {
    if (!mounted) return;
    setState(() {
      limit += 10;
    });
    await listOfTransaction(page, limit);
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final translateKey = Provider.of<LocalizationProvider>(context);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: white,
      body: isLoadingPage == true
          ? CustomLoader()
          : Column(
              children: [
                SizedBox(height: mediaQuery.padding.top + 16),
                Expanded(
                  child: Refresher(
                    refreshController: refreshController,
                    onLoading: onLoading,
                    onRefresh: onRefresh,
                    color: primary,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: white,
                                border: Border.all(color: gray200),
                              ),
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SvgPicture.asset('assets/svg/wallet.svg'),
                                      SizedBox(width: 4),
                                      Text(
                                        '${translateKey.translate('niyt_orlogo')}',
                                        style: TextStyle(
                                          color: gray600,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${Utils().formatCurrencyDouble(dashBoard.profit?.toDouble() ?? 0)}₮',
                                    style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                      color: primary,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              translateKey.translate('sales'),
                                              style: TextStyle(
                                                fontFamily: 'Lato',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: gray600,
                                              ),
                                            ),
                                            Text(
                                              '${Utils().formatCurrencyDouble(dashBoard.incomingProfit?.toDouble() ?? 0)}₮',
                                              style: TextStyle(
                                                // overflow: TextOverflow.ellipsis,
                                                fontFamily: 'Lato',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 24),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                translateKey.translate(
                                                  'total_orders',
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontFamily: 'Lato',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: gray600,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                '${dashBoard.totalBookings ?? 0}',
                                                style: TextStyle(
                                                  // overflow: TextOverflow.ellipsis,
                                                  fontFamily: 'Lato',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  color: black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              '${translateKey.translate('order_chart')}',
                              style: TextStyle(
                                color: gray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              width: mediaQuery.size.width,
                              height: 240,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: white,
                                border: Border.all(color: gray200),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: BarChart(
                                BarChartData(
                                  maxY: _getMaxOrder(),
                                  minY: 0,
                                  alignment: BarChartAlignment.spaceAround,
                                  gridData: FlGridData(
                                    horizontalInterval: _getMaxOrder() / 5,
                                    show: true,
                                    drawVerticalLine: false,
                                  ),
                                  borderData: FlBorderData(show: false),
                                  backgroundColor: white,
                                  extraLinesData: ExtraLinesData(
                                    horizontalLines: [
                                      HorizontalLine(
                                        y: 0,
                                        color: unselectedBar,
                                        strokeWidth: 1,
                                      ),
                                      HorizontalLine(
                                        y: _getMaxOrder(),
                                        color: unselectedBar,
                                        strokeWidth: 1,
                                        dashArray: [10, 10],
                                      ),
                                    ],
                                  ),
                                  titlesData: FlTitlesData(
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    topTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    rightTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 24,
                                        getTitlesWidget: (value, meta) {
                                          final index = value.toInt();
                                          if (index < 0 ||
                                              index >=
                                                  orderchart.rows!.length) {
                                            return const SizedBox.shrink();
                                          }
                                          final data =
                                              orderchart.rows![index]
                                                  as ChartData;
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8,
                                            ),
                                            child: Text(
                                              data.id ?? '',
                                              style: TextStyle(
                                                color: gray900,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  barTouchData: BarTouchData(
                                    enabled: true,
                                    touchTooltipData: BarTouchTooltipData(
                                      getTooltipColor: (_) => primary,
                                      tooltipBorderRadius:
                                          BorderRadius.circular(8),
                                      tooltipBorder: BorderSide(
                                        color: primary200,
                                      ),
                                      getTooltipItem:
                                          (group, groupIndex, rod, rodIndex) {
                                            return BarTooltipItem(
                                              '${Utils().formatCurrencyDouble(rod.toY.toDouble())}₮',
                                              TextStyle(
                                                color: white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            );
                                          },
                                    ),
                                  ),
                                  barGroups: orderchart.rows!
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                        final index = entry.key;
                                        final data = entry.value as ChartData;
                                        return BarChartGroupData(
                                          x: index,
                                          barRods: [
                                            BarChartRodData(
                                              toY: (data.totalAmount ?? 0)
                                                  .toDouble(),
                                              // color: primary,
                                              gradient: LinearGradient(
                                                begin: AlignmentGeometry
                                                    .bottomCenter,
                                                end:
                                                    AlignmentGeometry.topCenter,
                                                tileMode: TileMode.clamp,
                                                colors: [
                                                  primary,
                                                  primaryDrawer,
                                                ],
                                              ),
                                              width: 24,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              backDrawRodData:
                                                  BackgroundBarChartRodData(
                                                    show: true,
                                                    toY: _getMaxOrder(),
                                                    color: unselectedBar,
                                                  ),
                                            ),
                                          ],
                                        );
                                      })
                                      .toList(),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              '${translateKey.translate('profit_chart')}',
                              style: TextStyle(
                                color: gray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              width: mediaQuery.size.width,
                              height: 240,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: white,
                                border: Border.all(color: gray200),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: BarChart(
                                BarChartData(
                                  maxY: _getMaxProfit(),
                                  minY: 0,
                                  alignment: BarChartAlignment.spaceAround,
                                  gridData: FlGridData(
                                    horizontalInterval: _getMaxProfit() / 5,
                                    show: true,
                                    drawVerticalLine: false,
                                  ),
                                  borderData: FlBorderData(show: false),
                                  backgroundColor: white,
                                  extraLinesData: ExtraLinesData(
                                    horizontalLines: [
                                      HorizontalLine(
                                        y: 0,
                                        color: unselectedBar,
                                        strokeWidth: 1,
                                      ),
                                      HorizontalLine(
                                        y: _getMaxProfit(),
                                        color: unselectedBar,
                                        strokeWidth: 1,
                                        dashArray: [10, 10],
                                      ),
                                    ],
                                  ),
                                  titlesData: FlTitlesData(
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    topTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    rightTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 24,
                                        getTitlesWidget: (value, meta) {
                                          final index = value.toInt();
                                          if (index < 0 ||
                                              index >=
                                                  profitchart.rows!.length) {
                                            return const SizedBox.shrink();
                                          }
                                          final data =
                                              profitchart.rows![index]
                                                  as ChartData;
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8,
                                            ),
                                            child: Text(
                                              data.id ?? '',
                                              style: TextStyle(
                                                color: gray900,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  barTouchData: BarTouchData(
                                    enabled: true,
                                    touchTooltipData: BarTouchTooltipData(
                                      getTooltipColor: (_) => primary,
                                      tooltipBorderRadius:
                                          BorderRadius.circular(8),
                                      tooltipBorder: BorderSide(
                                        color: primary200,
                                      ),
                                      getTooltipItem:
                                          (group, groupIndex, rod, rodIndex) {
                                            return BarTooltipItem(
                                              '${Utils().formatCurrencyDouble(rod.toY.toDouble())}₮',
                                              TextStyle(
                                                color: white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            );
                                          },
                                    ),
                                  ),
                                  barGroups: profitchart.rows!
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                        final index = entry.key;
                                        final data = entry.value as ChartData;
                                        return BarChartGroupData(
                                          x: index,
                                          barRods: [
                                            BarChartRodData(
                                              toY: (data.totalAmount ?? 0)
                                                  .toDouble(),
                                              // color: primary,
                                              gradient: LinearGradient(
                                                begin: AlignmentGeometry
                                                    .bottomCenter,
                                                end:
                                                    AlignmentGeometry.topCenter,
                                                tileMode: TileMode.clamp,
                                                colors: [
                                                  primary,
                                                  primaryDrawer,
                                                ],
                                              ),
                                              width: 24,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              backDrawRodData:
                                                  BackgroundBarChartRodData(
                                                    show: true,
                                                    toY: _getMaxProfit(),
                                                    color: unselectedBar,
                                                  ),
                                            ),
                                          ],
                                        );
                                      })
                                      .toList(),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${translateKey.translate('transactions')}: ',
                                      style: TextStyle(
                                        color: gray900,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      '${transactionList.count}',
                                      style: TextStyle(
                                        color: gray900,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(
                                      context,
                                    ).pushNamed(TransactionListPage.routeName);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        '${translateKey.translate('all')}',
                                        style: TextStyle(
                                          color: primary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: 2),
                                      SvgPicture.asset(
                                        'assets/svg/chevron_right.svg',
                                        color: primary,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            isLoadingTransaction == true
                                ? CustomLoader()
                                : transactionList.rows!.isEmpty
                                ? Center(
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/empty_box.svg',
                                          width: 141,
                                        ),
                                        SizedBox(height: 16),
                                        Text(
                                          translateKey.translate('no_data'),
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: gray900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: white,
                                        border: Border.all(color: gray100),
                                      ),
                                      child: Column(
                                        children: transactionList.rows!
                                            .map(
                                              (data) =>
                                                  TransactionCard(data: data),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ),
                            SizedBox(height: mediaQuery.padding.bottom + 24),
                          ],
                        ),
                      ),
                    ),
                    // Center(child: Text('DashboardPage')),
                  ),
                ),
              ],
            ),
    );
  }

  double _getMaxOrder() {
    double max = 1;

    if (orderchart.rows!.isNotEmpty) {
      for (ChartData data in orderchart.rows!) {
        if (data.totalAmount! > max) max = data.totalAmount!.toDouble();
      }
    }
    return max;
  }

  double _getMaxProfit() {
    double max = 1;

    if (profitchart.rows!.isNotEmpty) {
      for (ChartData data in profitchart.rows!) {
        if (data.profit! > max) max = data.profit!.toDouble();
      }
    }
    return max;
  }
}
