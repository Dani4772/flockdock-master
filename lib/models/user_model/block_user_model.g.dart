// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlockUser _$BlockUserFromJson(Map<String, dynamic> json) => BlockUser(
      id: json['id'] as int?,
      blockedUserId: json['blocked_user_id'] as int?,
      blockedByUserId: json['blocked_by_user_id'] as int?,
      userName: json['user_name'] as String?,
      profilePicture: json['profile_picture'] as String?,
      isOnline: json['is_online'] as bool? ?? false,
    );

Map<String, dynamic> _$BlockUserToJson(BlockUser instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('blocked_user_id', instance.blockedUserId);
  writeNotNull('blocked_by_user_id', instance.blockedByUserId);
  writeNotNull('user_name', instance.userName);
  writeNotNull('profile_picture', instance.profilePicture);
  val['is_online'] = instance.isOnline;
  return val;
}
