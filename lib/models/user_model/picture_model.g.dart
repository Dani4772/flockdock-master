// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picture_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PictureData _$PictureDataFromJson(Map<String, dynamic> json) => PictureData(
      visiblePictures: (json['visible_pictures'] as List<dynamic>?)
          ?.map((e) => PictureDetail.fromJson(e))
          .toList(),
      privatePictures: (json['private_pictures'] as List<dynamic>?)
          ?.map((e) => PictureDetail.fromJson(e))
          .toList(),
    );

Map<String, dynamic> _$PictureDataToJson(PictureData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('visible_pictures', instance.visiblePictures);
  writeNotNull('private_pictures', instance.privatePictures);
  return val;
}

PictureDetail _$PictureDetailFromJson(Map<String, dynamic> json) =>
    PictureDetail(
      userPictureId: json['user_picture_id'] as int?,
      usersId: json['users_id'] as int?,
      picture: json['picture'] as String?,
      pictureType: json['picture_type'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$PictureDetailToJson(PictureDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('user_picture_id', instance.userPictureId);
  writeNotNull('users_id', instance.usersId);
  writeNotNull('picture', instance.picture);
  writeNotNull('picture_type', instance.pictureType);
  writeNotNull('created_at', instance.createdAt);
  writeNotNull('status', instance.status);
  return val;
}
