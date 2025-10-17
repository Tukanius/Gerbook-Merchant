part '../parts/avatar_upload.dart';

class Avatar {
  String? id;
  String? url;
  String? blurhash;
  Avatar({this.id, this.url, this.blurhash});
  factory Avatar.fromJson(Map<String, dynamic> json) => _$AvatarFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarToJson(this);
}
