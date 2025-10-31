import 'package:merchant_gerbook_flutter/models/url.dart';

part '../parts/qpay.dart';

class Qpay {
  String? invoice_id;
  String? qr_text;
  String? qr_image;
  String? qPay_shortUrl;
  List<Url>? urls;

  Qpay({
    this.invoice_id,
    this.qr_text,
    this.qr_image,
    this.qPay_shortUrl,
    this.urls,
  });
  factory Qpay.fromJson(Map<String, dynamic> json) => _$QpayFromJson(json);
  Map<String, dynamic> toJson() => _$QpayToJson(this);
}
