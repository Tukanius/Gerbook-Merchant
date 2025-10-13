part '../parts/terms_of_condition.dart';

class TermsOfCondition {
  String? id;
  String? text;
  String? question;
  String? answer;
  String? createdAt;
  String? updatedAt;

  TermsOfCondition({
    this.id,
    this.text,
    this.createdAt,
    this.updatedAt,
    this.question,
    this.answer,
  });
  static $fromJson(Map<String, dynamic> json) =>
      _$TermsOfConditionFromJson(json);

  factory TermsOfCondition.fromJson(Map<String, dynamic> json) =>
      _$TermsOfConditionFromJson(json);
  Map<String, dynamic> toJson() => _$TermsOfConditionToJson(this);
}
