part '../parts/special_dates.dart';

class SpecialDates {
  String? id;
  String? date;
  num? price;

  SpecialDates({this.id, this.date, this.price});
  factory SpecialDates.fromJson(Map<String, dynamic> json) =>
      _$SpecialDatesFromJson(json);
  Map<String, dynamic> toJson() => _$SpecialDatesToJson(this);
}
