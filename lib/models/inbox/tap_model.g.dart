// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tap_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TapDetail _$TapDetailFromJson(Map<String, dynamic> json) => TapDetail(
      tapId: json['tap_id'] as int?,
      tappingToUserId: json['tapping_to_user_id'] as int?,
      tappingByUserId: json['tapping_by_user_id'] as int?,
      userName: json['user_name'] as String?,
      profilePicture: json['profile_picture'] as String?,
      formattedTime: json['formatted_time'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      isOnline: json['is_online'] as bool? ?? false,
    );

Map<String, dynamic> _$TapDetailToJson(TapDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('tap_id', instance.tapId);
  writeNotNull('tapping_to_user_id', instance.tappingToUserId);
  writeNotNull('tapping_by_user_id', instance.tappingByUserId);
  writeNotNull('user_name', instance.userName);
  writeNotNull('profile_picture', instance.profilePicture);
  writeNotNull('formatted_time', instance.formattedTime);
  writeNotNull('created_at', instance.createdAt);
  writeNotNull('updated_at', instance.updatedAt);
  val['is_online'] = instance.isOnline;
  return val;
}
