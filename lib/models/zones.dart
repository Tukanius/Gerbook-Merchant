part '../parts/zones.dart';

class Zones {
  String? id;
  String? name;
  int? sort;
  Zones({
    this.id,
    this.name,
    this.sort,
  });

  static $fromJson(Map<String, dynamic> json) => _$ZonesFromJson(json);

  factory Zones.fromJson(Map<String, dynamic> json) => _$ZonesFromJson(json);
  Map<String, dynamic> toJson() => _$ZonesToJson(this);
}
