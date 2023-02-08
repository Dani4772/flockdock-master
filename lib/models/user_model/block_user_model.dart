import 'package:json_annotation/json_annotation.dart';
part 'block_user_model.g.dart';

@JsonSerializable(includeIfNull: false)
class BlockUser{
  @JsonKey(name: 'id',)
  int? id;
  @JsonKey(name: 'blocked_user_id',)
  int? blockedUserId;
  @JsonKey(name: 'blocked_by_user_id',)
  int? blockedByUserId;
  @JsonKey(name: 'user_name',)
  String? userName;
  @JsonKey(name: 'profile_picture',)
  String? profilePicture;
  @JsonKey(name: 'is_online',)
  bool isOnline;

  BlockUser({this.id,this.blockedUserId,this.blockedByUserId,this.userName,this.profilePicture,this.isOnline=false});
  Map<String, dynamic> toJson() => _$BlockUserToJson(this);
  factory BlockUser.fromJson(json) => _$BlockUserFromJson(json);
}