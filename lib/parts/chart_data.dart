part of '../models/chart_data.dart';

ChartData _$ChartDataFromJson(Map<String, dynamic> json) {
  return ChartData(
    id: json['_id'] != null ? json['_id'] as String : null,
    totalBookings: json['totalBookings'] != null
        ? json['totalBookings'] as num
        : null,
    totalAmount: json['totalAmount'] != null
        ? json['totalAmount'] as num
        : null,
    profit: json['profit'] != null ? json['profit'] as num : null,
  );
}

Map<String, dynamic> _$ChartDataToJson(ChartData instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.totalBookings != null)
    json['totalBookings'] = instance.totalBookings;
  if (instance.totalAmount != null) json['totalAmount'] = instance.totalAmount;
  if (instance.profit != null) json['profit'] = instance.profit;

  return json;
}
