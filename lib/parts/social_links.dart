part of '../models/social_links.dart';

SocialLinks _$SocialLinksFromJson(Map<String, dynamic> json) {
  return SocialLinks(
    facebookLink: json['facebookLink'] != null
        ? json['facebookLink'] as String
        : null,
    viberLink: json['viberLink'] != null ? json['viberLink'] as String : null,
    telegramLink: json['telegramLink'] != null
        ? json['telegramLink'] as String
        : null,
    lineLink: json['lineLink'] != null ? json['lineLink'] as String : null,
    whatsAppLink: json['whatsAppLink'] != null
        ? json['whatsAppLink'] as String
        : null,
  );
}

Map<String, dynamic> _$SocialLinksToJson(SocialLinks instance) {
  Map<String, dynamic> json = {};
  if (instance.facebookLink != null)
    json['facebookLink'] = instance.facebookLink;
  if (instance.viberLink != null) json['viberLink'] = instance.viberLink;
  if (instance.telegramLink != null)
    json['telegramLink'] = instance.telegramLink;
  if (instance.lineLink != null) json['lineLink'] = instance.lineLink;
  if (instance.whatsAppLink != null)
    json['whatsAppLink'] = instance.whatsAppLink;

  return json;
}
