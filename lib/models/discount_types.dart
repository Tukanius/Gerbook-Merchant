part '../parts/discount_types.dart';

class DiscountTypes {
  String? id;
  String? type;
  num? value;
  num? procent;
  num? rate;
  DiscountTypes({this.id, this.type, this.value, this.procent, this.rate});
  factory DiscountTypes.fromJson(Map<String, dynamic> json) =>
      _$DiscountTypesFromJson(json);
  Map<String, dynamic> toJson() => _$DiscountTypesToJson(this);
}
