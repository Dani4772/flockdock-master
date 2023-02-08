// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileDetail _$ProfileDetailFromJson(Map<String, dynamic> json) =>
    ProfileDetail(
      ethnicities: (json['ethnicities'] as List<dynamic>?)
          ?.map((e) => Ethnicity.fromJson(e))
          .toList(),
      bodyTypes: (json['body_types'] as List<dynamic>?)
          ?.map((e) => BodyType.fromJson(e))
          .toList(),
      positions: (json['positions'] as List<dynamic>?)
          ?.map((e) => Position.fromJson(e))
          .toList(),
      relationships: (json['relationships'] as List<dynamic>?)
          ?.map((e) => RelationShip.fromJson(e))
          .toList(),
      seeking: (json['seekings'] as List<dynamic>?)
          ?.map((e) => Seeking.fromJson(e))
          .toList(),
      tribes: (json['tribes'] as List<dynamic>?)
          ?.map((e) => Tribe.fromJson(e))
          .toList(),
    );

Map<String, dynamic> _$ProfileDetailToJson(ProfileDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ethnicities', instance.ethnicities);
  writeNotNull('body_types', instance.bodyTypes);
  writeNotNull('positions', instance.positions);
  writeNotNull('relationships', instance.relationships);
  writeNotNull('seekings', instance.seeking);
  writeNotNull('tribes', instance.tribes);
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

Ethnicity _$EthnicityFromJson(Map<String, dynamic> json) => Ethnicity(
      ethnicityId: json['ethnicity_id'] as int?,
      ethnicity: json['ethnicity'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$EthnicityToJson(Ethnicity instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ethnicity_id', instance.ethnicityId);
  writeNotNull('ethnicity', instance.ethnicity);
  writeNotNull('status', instance.status);
  return val;
}

BodyType _$BodyTypeFromJson(Map<String, dynamic> json) => BodyType(
      bodyTypeId: json['body_type_id'] as int?,
      bodyType: json['body_type'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$BodyTypeToJson(BodyType instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('body_type_id', instance.bodyTypeId);
  writeNotNull('body_type', instance.bodyType);
  writeNotNull('status', instance.status);
  return val;
}

Position _$PositionFromJson(Map<String, dynamic> json) => Position(
      positionId: json['position_id'] as int?,
      position: json['position'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$PositionToJson(Position instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('position_id', instance.positionId);
  writeNotNull('position', instance.position);
  writeNotNull('status', instance.status);
  return val;
}

RelationShip _$RelationShipFromJson(Map<String, dynamic> json) => RelationShip(
      relationshipId: json['relationship_id'] as int?,
      relationship: json['relationship'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$RelationShipToJson(RelationShip instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('relationship_id', instance.relationshipId);
  writeNotNull('relationship', instance.relationship);
  writeNotNull('status', instance.status);
  return val;
}

Seeking _$SeekingFromJson(Map<String, dynamic> json) => Seeking(
      seekingId: json['seeking_id'] as int?,
      seeking: json['seeking'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$SeekingToJson(Seeking instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('seeking_id', instance.seekingId);
  writeNotNull('seeking', instance.seeking);
  writeNotNull('status', instance.status);
  return val;
}
