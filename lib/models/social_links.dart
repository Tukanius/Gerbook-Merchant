part '../parts/social_links.dart';

class SocialLinks {
  String? facebookLink;
  String? viberLink;
  String? telegramLink;
  String? lineLink;
  String? whatsAppLink;

  SocialLinks({
    this.facebookLink,
    this.viberLink,
    this.telegramLink,
    this.lineLink,
    this.whatsAppLink,
  });
  factory SocialLinks.fromJson(Map<String, dynamic> json) =>
      _$SocialLinksFromJson(json);
  Map<String, dynamic> toJson() => _$SocialLinksToJson(this);
}
