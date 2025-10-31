part of '../models/payment.dart';

Payment _$PaymentFromJson(Map<String, dynamic> json) {
  return Payment(
    id: json['_id'] != null ? json['_id'] as String : null,
    invoice: json['invoice'] != null ? json['invoice'] as String : null,
    method: json['method'] != null ? json['method'] as String : null,
    amount: json['amount'] != null ? json['amount'] as num : null,
    currency: json['currency'] != null ? json['currency'] as String : null,
    description: json['description'] != null
        ? json['description'] as String
        : null,
    status: json['status'] != null ? json['status'] as String : null,
    statusDate: json['statusDate'] != null
        ? json['statusDate'] as String
        : null,
    booking: json['booking'] != null ? json['booking'] as String : null,
    qpayInvoiceId: json['qpayInvoiceId'] != null
        ? json['qpayInvoiceId'] as String
        : null,
    qpay: json['qpay'] != null ? Qpay.fromJson(json['qpay']) : null,
    paymentMethod: json['paymentMethod'] != null
        ? json['paymentMethod'] as String
        : null,
    callbackUri: json['callbackUri'] != null
        ? json['callbackUri'] as String
        : null,
    // golomt: json['golomt'] != null ? GolomtBank.fromJson(json['golomt']) : null,
    // pocket: json['pocket'] != null ? PocketPay.fromJson(json['pocket']) : null,
    phone: json['phone'] != null ? json['phone'] as String : null,
    // storepay:
    //     json['storepay'] != null ? StorePay.fromJson(json['storepay']) : null,
  );
}

Map<String, dynamic> _$PaymentToJson(Payment instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['_id'] = instance.id;
  if (instance.invoice != null) json['invoice'] = instance.invoice;
  if (instance.method != null) json['method'] = instance.method;
  if (instance.amount != null) json['amount'] = instance.amount;
  if (instance.currency != null) json['currency'] = instance.currency;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.status != null) json['status'] = instance.status;
  if (instance.statusDate != null) json['statusDate'] = instance.statusDate;
  if (instance.qpayInvoiceId != null)
    json['qpayInvoiceId'] = instance.qpayInvoiceId;
  if (instance.qpay != null) json['qpay'] = instance.qpay;
  if (instance.paymentMethod != null)
    json['paymentMethod'] = instance.paymentMethod;
  if (instance.callbackUri != null) json['callbackUri'] = instance.callbackUri;
  // if (instance.golomt != null) json['golomt'] = instance.golomt;
  // if (instance.pocket != null) json['pocket'] = instance.pocket;
  if (instance.phone != null) json['phone'] = instance.phone;
  // if (instance.storepay != null) json['storepay'] = instance.storepay;

  return json;
}
