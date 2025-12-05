part '../parts/level_model.dart';

class LevelModel {
  String? id;
  LevelModel({this.id});
  static $fromJson(Map<String, dynamic> json) => _$LevelModelFromJson(json);

  factory LevelModel.fromJson(Map<String, dynamic> json) =>
      _$LevelModelFromJson(json);
  Map<String, dynamic> toJson() => _$LevelModelToJson(this);
}
