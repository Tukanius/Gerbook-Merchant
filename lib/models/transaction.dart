part '../parts/transaction.dart';

class Transaction {
  String? id;
  String? type;
  String? description;
  num? amount;
  String? createdAt;
  String? currency;

  Transaction({
    this.id,
    this.type,
    this.description,
    this.amount,
    this.createdAt,
    this.currency,
  });
  static $fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
