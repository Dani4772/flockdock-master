// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Messages _$MessagesFromJson(Map<String, dynamic> json) => Messages(
      groupMessageId: json['group_message_id'] as int?,
      groupId: json['group_id'] as int?,
      usersId: json['users_id'] as int?,
      userName: json['user_name'] as String?,
      profilePicture: json['profile_picture'] as String?,
      content: json['content'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$MessagesToJson(Messages instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('group_message_id', instance.groupMessageId);
  writeNotNull('group_id', instance.groupId);
  writeNotNull('users_id', instance.usersId);
  writeNotNull('user_name', instance.userName);
  writeNotNull('content', instance.content);
  writeNotNull('profile_picture', instance.profilePicture);
  writeNotNull('created_at', instance.createdAt);
  return val;
}
