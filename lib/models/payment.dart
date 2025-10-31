import 'package:merchant_gerbook_flutter/models/qpay.dart';

part '../parts/payment.dart';

class Payment {
  String? id;
  String? invoice;
  String? method;
  num? amount;
  String? currency;
  String? description;
  String? status;
  String? statusDate;
  String? booking;
  String? qpayInvoiceId;
  Qpay? qpay;
  String? paymentMethod;
  String? callbackUri;
  // GolomtBank? golomt;
  // PocketPay? pocket;
  String? phone;
  // StorePay? storepay;

  Payment({
    this.id,
    this.invoice,
    this.method,
    this.amount,
    this.currency,
    this.description,
    this.status,
    this.statusDate,
    this.booking,
    this.qpayInvoiceId,
    this.qpay,
    this.paymentMethod,
    this.callbackUri,
    // this.golomt,
    // this.pocket,
    this.phone,
    // this.storepay,
  });
  static $fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
