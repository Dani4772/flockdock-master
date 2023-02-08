import 'package:json_annotation/json_annotation.dart';
part 'message_model.g.dart';


@JsonSerializable(includeIfNull: false)
class Messages{
  @JsonKey(name: 'group_message_id',)
  int? groupMessageId;
  @JsonKey(name: 'group_id',)
  int? groupId;
  @JsonKey(name: 'users_id',)
  int? usersId;
  @JsonKey(name: 'user_name',)
  String? userName;
  String? content;
  @JsonKey(name: 'profile_picture',)
  String? profilePicture;
  @JsonKey(name: 'created_at',)
  String? createdAt;

  Messages({this.groupMessageId,this.groupId,this.usersId,this.userName,this.profilePicture,this.content,this.createdAt});
  Map<String, dynamic> toJson() => _$MessagesToJson(this);
  factory Messages.fromJson(json) => _$MessagesFromJson(json);
}