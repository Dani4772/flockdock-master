import 'package:json_annotation/json_annotation.dart';
part 'tap_model.g.dart';


@JsonSerializable(includeIfNull: false)
class TapDetail{
  @JsonKey(name: 'tap_id',)
  int? tapId;
  @JsonKey(name: 'tapping_to_user_id',)
  int? tappingToUserId;
  @JsonKey(name: 'tapping_by_user_id',)
  int? tappingByUserId;
  @JsonKey(name: 'user_name',)
  String? userName;
  @JsonKey(name: 'profile_picture',)
  String? profilePicture;
  @JsonKey(name: 'formatted_time',)
  String? formattedTime;
  @JsonKey(name: 'created_at',)
  String? createdAt;
  @JsonKey(name: 'updated_at',)
  String? updatedAt;
  @JsonKey(name: 'is_online',)
  bool isOnline;

  TapDetail({this.tapId,this.tappingToUserId,this.tappingByUserId,this.userName,this.profilePicture,
    this.formattedTime,this.createdAt,this.updatedAt,this.isOnline=false});
  Map<String, dynamic> toJson() => _$TapDetailToJson(this);
  factory TapDetail.fromJson(json) => _$TapDetailFromJson(json);
}