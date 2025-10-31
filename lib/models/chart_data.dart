part '../parts/chart_data.dart';

class ChartData {
  String? id;
  num? totalBookings;
  num? totalAmount;
  num? profit;
  ChartData({this.id, this.totalBookings, this.totalAmount, this.profit});
  factory ChartData.fromJson(Map<String, dynamic> json) =>
      _$ChartDataFromJson(json);
  Map<String, dynamic> toJson() => _$ChartDataToJson(this);
}
