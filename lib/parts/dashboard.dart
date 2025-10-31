part of '../models/dashboard.dart';

Dashboard _$DashboardFromJson(Map<String, dynamic> json) {
  return Dashboard(
    incomingProfit: json['incomingProfit'] != null
        ? json['incomingProfit'] as num
        : null,
    profit: json['profit'] != null ? json['profit'] as num : null,
    totalBookings: json['totalBookings'] != null
        ? json['totalBookings'] as num
        : null,
  );
}

Map<String, dynamic> _$DashboardToJson(Dashboard instance) {
  Map<String, dynamic> json = {};
  if (instance.incomingProfit != null)
    json['incomingProfit'] = instance.incomingProfit;
  if (instance.profit != null) json['profit'] = instance.profit;
  if (instance.totalBookings != null)
    json['totalBookings'] = instance.totalBookings;

  return json;
}
