part '../parts/dashboard.dart';

class Dashboard {
  num? incomingProfit;
  num? profit;
  num? totalBookings;
  Dashboard({this.incomingProfit, this.profit, this.totalBookings});
  factory Dashboard.fromJson(Map<String, dynamic> json) =>
      _$DashboardFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardToJson(this);
}
