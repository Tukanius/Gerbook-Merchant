part of '../models/qpay.dart';

Qpay _$QpayFromJson(Map<String, dynamic> json) {
  return Qpay(
    invoice_id: json['invoice_id'] != null
        ? json['invoice_id'] as String
        : null,
    qr_text: json['qr_text'] != null ? json['qr_text'] as String : null,
    qr_image: json['qr_image'] != null ? json['qr_image'] as String : null,
    qPay_shortUrl: json['qPay_shortUrl'] != null
        ? json['qPay_shortUrl'] as String
        : null,
    urls: json['urls'] != null
        ? (json['urls'] as List).map((e) => Url.fromJson(e)).toList()
        : null,
  );
}

Map<String, dynamic> _$QpayToJson(Qpay instance) {
  Map<String, dynamic> json = {};
  if (instance.invoice_id != null) json['invoice_id'] = instance.invoice_id;
  if (instance.qr_text != null) json['qr_text'] = instance.qr_text;
  if (instance.qr_image != null) json['qr_image'] = instance.qr_image;
  if (instance.qPay_shortUrl != null)
    json['qPay_shortUrl'] = instance.qPay_shortUrl;
  if (instance.urls != null) json['urls'] = instance.urls;

  return json;
}
