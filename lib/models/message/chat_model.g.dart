// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatedMessages _$UpdatedMessagesFromJson(Map<String, dynamic> json) =>
    UpdatedMessages(
      chatLength: json['chat_length'] as int?,
      unreadMessages: (json['unread_messages'] as List<dynamic>?)
          ?.map((e) => ChatMessages.fromJson(e))
          .toList(),
    );

Map<String, dynamic> _$UpdatedMessagesToJson(UpdatedMessages instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('chat_length', instance.chatLength);
  writeNotNull('unread_messages', instance.unreadMessages);
  return val;
}

ChatMessages _$ChatMessagesFromJson(Map<String, dynamic> json) => ChatMessages(
      userId: json['userId'] as String?,
      name: json['name'] as String?,
      profilePicture: json['profile_pic'] as String?,
      message: json['message'] as String?,
      msgType: json['msgType'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
    );

Map<String, dynamic> _$ChatMessagesToJson(ChatMessages instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('userId', instance.userId);
  writeNotNull('name', instance.name);
  writeNotNull('message', instance.message);
  writeNotNull('msgType', instance.msgType);
  writeNotNull('profile_pic', instance.profilePicture);
  writeNotNull('date', instance.date);
  writeNotNull('time', instance.time);
  return val;
}
