import 'package:flocdock/models/groupModel/category_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'profile_model.g.dart';

@JsonSerializable(includeIfNull: false)
class ProfileDetail{
  List<Ethnicity>? ethnicities;
  @JsonKey(name: 'body_types',)
  List<BodyType>? bodyTypes;
  List<Position>? positions;
  List<RelationShip>? relationships;
  @JsonKey(name: 'seekings',)
  List<Seeking>? seeking;
  List<Tribe>? tribes;
  ProfileDetail({this.ethnicities,this.bodyTypes,this.positions,this.relationships,this.seeking,this.tribes});
  Map<String, dynamic> toJson() => _$ProfileDetailToJson(this);
  factory ProfileDetail.fromJson(json) => _$ProfileDetailFromJson(json);
}

@JsonSerializable(includeIfNull: false)
class PictureDetail{
  @JsonKey(name: 'user_picture_id',)
  int? userPictureId;
  @JsonKey(name: 'users_id',)
  int? usersId;
  String? picture;
  @JsonKey(name: 'picture_type',)
  String? pictureType;
  @JsonKey(name: 'created_at',)
  String? createdAt;
  String? status;

  PictureDetail({this.userPictureId,this.usersId,this.picture,this.pictureType,this.status,this.createdAt});
  Map<String, dynamic> toJson() => _$PictureDetailToJson(this);
  factory PictureDetail.fromJson(json) => _$PictureDetailFromJson(json);
}
@JsonSerializable(includeIfNull: false)
class Ethnicity{
  @JsonKey(name: 'ethnicity_id',)
  int? ethnicityId;
  String? ethnicity;
  @JsonKey(name: 'status',)
  String? status;
  Ethnicity({this.ethnicityId,this.ethnicity,this.status});

  Map<String, dynamic> toJson() => _$EthnicityToJson(this);
  factory Ethnicity.fromJson(json) => _$EthnicityFromJson(json);
}

@JsonSerializable(includeIfNull: false)
class BodyType{
  @JsonKey(name: 'body_type_id',)
  int? bodyTypeId;
  @JsonKey(name: 'body_type',)
  String? bodyType;
  @JsonKey(name: 'status',)
  String? status;
  BodyType({this.bodyTypeId,this.bodyType,this.status});

  Map<String, dynamic> toJson() => _$BodyTypeToJson(this);
  factory BodyType.fromJson(json) => _$BodyTypeFromJson(json);
}

@JsonSerializable(includeIfNull: false)
class Position{
  @JsonKey(name: 'position_id',)
  int? positionId;
  String? position;
  @JsonKey(name: 'status',)
  String? status;
  Position({this.positionId,this.position,this.status});

  Map<String, dynamic> toJson() => _$PositionToJson(this);
  factory Position.fromJson(json) => _$PositionFromJson(json);
}

@JsonSerializable(includeIfNull: false)
class RelationShip{
  @JsonKey(name: 'relationship_id',)
  int? relationshipId;
  String? relationship;
  @JsonKey(name: 'status',)
  String? status;
  RelationShip({this.relationshipId,this.relationship,this.status});

  Map<String, dynamic> toJson() => _$RelationShipToJson(this);
  factory RelationShip.fromJson(json) => _$RelationShipFromJson(json);
}

@JsonSerializable(includeIfNull: false)
class Seeking{
  @JsonKey(name: 'seeking_id',)
  int? seekingId;
  String? seeking;
  @JsonKey(name: 'status',)
  String? status;
  Seeking({this.seekingId,this.seeking,this.status});

  Map<String, dynamic> toJson() => _$SeekingToJson(this);
  factory Seeking.fromJson(json) => _$SeekingFromJson(json);
}