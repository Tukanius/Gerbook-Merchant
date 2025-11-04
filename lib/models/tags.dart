part '../parts/tags.dart';

class Tags {
  String? id;
  String? name;
  num? sort;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? icon;
  String? selectedIcon;
  int? count;

  Tags({
    this.id,
    this.name,
    this.sort,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.icon,
    this.count,
    this.selectedIcon,
  });
  static $fromJson(Map<String, dynamic> json) => _$TagsFromJson(json);

  factory Tags.fromJson(Map<String, dynamic> json) => _$TagsFromJson(json);
  Map<String, dynamic> toJson() => _$TagsToJson(this);
}
