part '../parts/discount_item.dart';

class DiscountItem {
  String? id;
  String? type;
  int? value;

  DiscountItem({this.id, this.type, this.value});
  factory DiscountItem.fromJson(Map<String, dynamic> json) =>
      _$DiscountItemFromJson(json);
  Map<String, dynamic> toJson() => _$DiscountItemToJson(this);
}
