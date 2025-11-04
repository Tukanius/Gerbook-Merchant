part '../parts/address.dart';

class Address {
  String? id;
  // String? name;
  String? nameEng;
  int? level;
  Address({
    this.id,
    // this.name,
    this.nameEng,
    this.level,
  });
  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
