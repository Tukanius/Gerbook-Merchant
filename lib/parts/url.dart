part of '../models/url.dart';

Url _$UrlFromJson(Map<String, dynamic> json) {
  return Url(
    name: json['name'] != null ? json['name'] as String : null,
    description: json['description'] != null
        ? json['description'] as String
        : null,
    logo: json['logo'] != null ? json['logo'] as String : null,
    link: json['link'] != null ? json['link'] as String : null,
  );
}

Map<String, dynamic> _$UrlToJson(Url instance) {
  Map<String, dynamic> json = {};
  if (instance.name != null) json['name'] = instance.name;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.logo != null) json['logo'] = instance.logo;
  if (instance.link != null) json['link'] = instance.link;

  return json;
}
