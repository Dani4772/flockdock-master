import 'package:json_annotation/json_annotation.dart';
part 'profile_group_model.g.dart';

@JsonSerializable(includeIfNull: false)
class ProfileGroupDetail{
  @JsonKey(name: 'group_id',)
  int? groupId;
  @JsonKey(name: 'users_id',)
  int? usersId;
  String? name;
  @JsonKey(name: 'distance_away',)
  double? distanceAway;
  String? picture;
  @JsonKey(name: 'time_ago',)
  String? timeAgo;
  @JsonKey(name: 'total_active_members',)
  int? totalActiveMembers;
  @JsonKey(name: 'is_online',)
  bool isOnline;
  @JsonKey(name: 'is_verified',)
  bool? isVerified;
  @JsonKey(name: 'object_type',)
  String? objectType;
  double? latitude;
  @JsonKey(name: 'longitide',)
  double? longitude;

  ProfileGroupDetail({this.groupId,this.usersId,this.name,this.distanceAway,
    this.picture,this.objectType,this.timeAgo, this.totalActiveMembers,
    this.isOnline=false,this.isVerified,this.latitude,this.longitude});
  Map<String, dynamic> toJson() => _$ProfileGroupDetailToJson(this);
  factory ProfileGroupDetail.fromJson(json) => _$ProfileGroupDetailFromJson(json);
}