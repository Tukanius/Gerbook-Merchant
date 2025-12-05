part of '../models/level_model.dart';

LevelModel _$LevelModelFromJson(Map<String, dynamic> json) {
  return LevelModel(id: json['_id'] != null ? json['_id'] as String : null);
}

Map<String, dynamic> _$LevelModelToJson(LevelModel instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;

  return json;
}
