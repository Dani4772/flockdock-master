// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phrase_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhraseDetail _$PhraseDetailFromJson(Map<String, dynamic> json) => PhraseDetail(
      id: json['id'] as int?,
      phrase: json['phrase'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$PhraseDetailToJson(PhraseDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('phrase', instance.phrase);
  writeNotNull('created_at', instance.createdAt);
  return val;
}
