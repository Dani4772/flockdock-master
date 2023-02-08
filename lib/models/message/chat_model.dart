import 'package:json_annotation/json_annotation.dart';
part 'chat_model.g.dart';


@JsonSerializable(includeIfNull: false)
class UpdatedMessages{
  @JsonKey(name: 'chat_length',)
  int? chatLength;
  @JsonKey(name: 'unread_messages',)
  List<ChatMessages>? unreadMessages;

  UpdatedMessages({this.chatLength,this.unreadMessages});
  Map<String, dynamic> toJson() => _$UpdatedMessagesToJson(this);
  factory UpdatedMessages.fromJson(json) => _$UpdatedMessagesFromJson(json);
}

@JsonSerializable(includeIfNull: false)
class ChatMessages{
  String? userId;
  String? name;
  String? message;
  String? msgType;
  @JsonKey(name: 'profile_pic',)
  String? profilePicture;
  String? date;
  String? time;

  ChatMessages({this.userId,this.name,this.profilePicture,this.message,this.msgType,this.date,this.time,});
  Map<String, dynamic> toJson() => _$ChatMessagesToJson(this);
  factory ChatMessages.fromJson(json) => _$ChatMessagesFromJson(json);
}