import 'package:json_annotation/json_annotation.dart';
part 'inbox_model.g.dart';


@JsonSerializable(includeIfNull: false)
class InboxDetail{
  @JsonKey(name: 'item_type',)
  String? itemType;
  @JsonKey(name: 'notification_id',)
  int? notificationId;
  @JsonKey(name: 'sender_id',)
  int? senderId;
  @JsonKey(name: 'receiver_id',)
  int? receiverId;
  @JsonKey(name: 'group_id',)
  int? groupId;
  String? message;
  @JsonKey(name: 'badge_count',)
  int? badgeCount;
  @JsonKey(name: 'sender_name',)
  String? userName;
  @JsonKey(name: 'profile_picture',)
  String? profilePicture;
  @JsonKey(name: 'formatted_time',)
  String? formattedTime;
  @JsonKey(name: 'created_at',)
  String? createdAt;
  @JsonKey(name: 'notification_type',)
  String? notificationType;
  String? status;
  @JsonKey(name: 'is_online',)
  bool isOnline;

  InboxDetail({this.itemType,this.notificationId,this.groupId,this.senderId,this.receiverId,
    this.notificationType, this.isOnline=false,this.userName,this.profilePicture,this.formattedTime,
    this.createdAt,this.badgeCount, this.status,this.message,
  });
  Map<String, dynamic> toJson() => _$InboxDetailToJson(this);
  factory InboxDetail.fromJson(json) => _$InboxDetailFromJson(json);
}