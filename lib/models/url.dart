part '../parts/url.dart';

class Url {
  String? name;
  String? description;
  String? logo;
  String? link;

  Url({this.name, this.description, this.logo, this.link});
  static $fromJson(Map<String, dynamic> json) => _$UrlFromJson(json);

  factory Url.fromJson(Map<String, dynamic> json) => _$UrlFromJson(json);
  Map<String, dynamic> toJson() => _$UrlToJson(this);
}
