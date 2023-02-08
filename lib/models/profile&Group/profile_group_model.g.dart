// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileGroupDetail _$ProfileGroupDetailFromJson(Map<String, dynamic> json) =>
    ProfileGroupDetail(
      groupId: json['group_id'] as int?,
      usersId: json['users_id'] as int?,
      name: json['name'] as String?,
      distanceAway: (json['distance_away'] as num?)?.toDouble(),
      picture: json['picture'] as String?,
      objectType: json['object_type'] as String?,
      timeAgo: json['time_ago'] as String?,
      totalActiveMembers: json['total_active_members'] as int?,
      isOnline: json['is_online'] as bool? ?? false,
      isVerified: json['is_verified'] as bool?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitide'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProfileGroupDetailToJson(ProfileGroupDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('group_id', instance.groupId);
  writeNotNull('users_id', instance.usersId);
  writeNotNull('name', instance.name);
  writeNotNull('distance_away', instance.distanceAway);
  writeNotNull('picture', instance.picture);
  writeNotNull('time_ago', instance.timeAgo);
  writeNotNull('total_active_members', instance.totalActiveMembers);
  val['is_online'] = instance.isOnline;
  writeNotNull('is_verified', instance.isVerified);
  writeNotNull('object_type', instance.objectType);
  writeNotNull('latitude', instance.latitude);
  writeNotNull('longitide', instance.longitude);
  return val;
}
