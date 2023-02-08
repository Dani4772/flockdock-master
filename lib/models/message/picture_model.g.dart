// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picture_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pictures _$PicturesFromJson(Map<String, dynamic> json) => Pictures(
      recentImages: (json['recent_images'] as List<dynamic>?)
          ?.map((e) => PictureDetail.fromJson(e))
          .toList(),
      lastWeekImages: (json['last_week_images'] as List<dynamic>?)
          ?.map((e) => PictureDetail.fromJson(e))
          .toList(),
      lastMonthImages: (json['last_month_images'] as List<dynamic>?)
          ?.map((e) => PictureDetail.fromJson(e))
          .toList(),
    );

Map<String, dynamic> _$PicturesToJson(Pictures instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('recent_images', instance.recentImages);
  writeNotNull('last_week_images', instance.lastWeekImages);
  writeNotNull('last_month_images', instance.lastMonthImages);
  return val;
}

PictureDetail _$PictureDetailFromJson(Map<String, dynamic> json) =>
    PictureDetail(
      userName: json['user_name'] as String?,
      picture: json['picture'] as String?,
      createdAt: json['created_at'] as String?,
      formattedDatetime: json['formatted_datetime'] as String?,
    );

Map<String, dynamic> _$PictureDetailToJson(PictureDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('user_name', instance.userName);
  writeNotNull('picture', instance.picture);
  writeNotNull('created_at', instance.createdAt);
  writeNotNull('formatted_datetime', instance.formattedDatetime);
  return val;
}
