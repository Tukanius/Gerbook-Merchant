part '../parts/blocked_dates.dart';

class BlockedDates {
  String? id;
  String? date;
  num? quantity;

  BlockedDates({this.id, this.quantity, this.date});
  factory BlockedDates.fromJson(Map<String, dynamic> json) =>
      _$BlockedDatesFromJson(json);
  Map<String, dynamic> toJson() => _$BlockedDatesToJson(this);
}
