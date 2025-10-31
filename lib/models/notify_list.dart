import 'package:merchant_gerbook_flutter/models/images.dart';
import 'package:merchant_gerbook_flutter/models/notify_object.dart';

part '../parts/notify_list.dart';

class NotifyList {
  String? id;
  String? user;
  String? title;
  String? description;
  String? objectType;
  NotifyObject? object;
  Images? objectImage;
  String? type;
  bool? hasGetItem;
  String? createdAt;

  NotifyList({
    this.id,
    this.user,
    this.title,
    this.description,
    this.objectType,
    this.object,
    this.objectImage,
    this.type,
    this.hasGetItem,
    this.createdAt,
  });
  factory NotifyList.fromJson(Map<String, dynamic> json) =>
      _$NotifyListFromJson(json);
  Map<String, dynamic> toJson() => _$NotifyListToJson(this);
}
