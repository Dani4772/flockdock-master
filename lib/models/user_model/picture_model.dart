import 'package:json_annotation/json_annotation.dart';
part 'picture_model.g.dart';

@JsonSerializable(includeIfNull: false)
class PictureData{
  @JsonKey(name: 'visible_pictures',)
  List<PictureDetail>? visiblePictures;
  @JsonKey(name: 'private_pictures',)
  List<PictureDetail>? privatePictures;

  PictureData({this.visiblePictures,this.privatePictures});
  Map<String, dynamic> toJson() => _$PictureDataToJson(this);
  factory PictureData.fromJson(json) => _$PictureDataFromJson(json);
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