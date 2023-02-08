// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inbox_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InboxDetail _$InboxDetailFromJson(Map<String, dynamic> json) => InboxDetail(
      itemType: json['item_type'] as String?,
      notificationId: json['notification_id'] as int?,
      groupId: json['group_id'] as int?,
      senderId: json['sender_id'] as int?,
      receiverId: json['receiver_id'] as int?,
      notificationType: json['notification_type'] as String?,
      isOnline: json['is_online'] as bool? ?? false,
      userName: json['sender_name'] as String?,
      profilePicture: json['profile_picture'] as String?,
      formattedTime: json['formatted_time'] as String?,
      createdAt: json['created_at'] as String?,
      badgeCount: json['badge_count'] as int?,
      status: json['status'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$InboxDetailToJson(InboxDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('item_type', instance.itemType);
  writeNotNull('notification_id', instance.notificationId);
  writeNotNull('sender_id', instance.senderId);
  writeNotNull('receiver_id', instance.receiverId);
  writeNotNull('group_id', instance.groupId);
  writeNotNull('message', instance.message);
  writeNotNull('badge_count', instance.badgeCount);
  writeNotNull('sender_name', instance.userName);
  writeNotNull('profile_picture', instance.profilePicture);
  writeNotNull('formatted_time', instance.formattedTime);
  writeNotNull('created_at', instance.createdAt);
  writeNotNull('notification_type', instance.notificationType);
  writeNotNull('status', instance.status);
  val['is_online'] = instance.isOnline;
  return val;
}
