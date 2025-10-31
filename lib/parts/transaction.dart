part of '../models/transaction.dart';

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return Transaction(
    id: json['_id'] != null ? json['_id'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    description: json['description'] != null
        ? json['description'] as String
        : null,
    amount: json['amount'] != null ? json['amount'] as num : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    currency: json['currency'] != null ? json['currency'] as String : null,
  );
}

Map<String, dynamic> _$TransactionToJson(Transaction instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.amount != null) json['amount'] = instance.amount;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.currency != null) json['currency'] = instance.currency;

  return json;
}
