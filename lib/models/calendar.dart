part '../parts/calendar.dart';

class Calendar {
  String? date;
  int? price;
  int? blockedQuantity;

  Calendar({this.date, this.price, this.blockedQuantity});
  static $fromJson(Map<String, dynamic> json) => _$CalendarFromJson(json);

  factory Calendar.fromJson(Map<String, dynamic> json) =>
      _$CalendarFromJson(json);
  Map<String, dynamic> toJson() => _$CalendarToJson(this);
}
