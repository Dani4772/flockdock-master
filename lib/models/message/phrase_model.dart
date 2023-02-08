import 'package:json_annotation/json_annotation.dart';
part 'phrase_model.g.dart';


@JsonSerializable(includeIfNull: false)
class PhraseDetail{
  int? id;
  String? phrase;
  @JsonKey(name: 'created_at',)
  String? createdAt;

  PhraseDetail({this.id,this.phrase,this.createdAt});
  Map<String, dynamic> toJson() => _$PhraseDetailToJson(this);
  factory PhraseDetail.fromJson(json) => _$PhraseDetailFromJson(json);
}