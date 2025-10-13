part of '../models/terms_of_condition.dart';

TermsOfCondition _$TermsOfConditionFromJson(Map<String, dynamic> json) {
  return TermsOfCondition(
    id: json['_id'] != null ? json['_id'] as String : null,
    text: json['text'] != null ? json['text'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    answer: json['answer'] != null ? json['answer'] as String : null,
    question: json['question'] != null ? json['question'] as String : null,
  );
}

Map<String, dynamic> _$TermsOfConditionToJson(TermsOfCondition instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.text != null) json['text'] = instance.text;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.answer != null) json['answer'] = instance.answer;
  if (instance.question != null) json['question'] = instance.question;

  return json;
}
