import 'package:json_annotation/json_annotation.dart';
part 'picture_model.g.dart';


@JsonSerializable(includeIfNull: false)
class Pictures{
  @JsonKey(name: 'recent_images',)
  List<PictureDetail>? recentImages;
  @JsonKey(name: 'last_week_images',)
  List<PictureDetail>? lastWeekImages;
  @JsonKey(name: 'last_month_images',)
  List<PictureDetail>? lastMonthImages;


  Pictures({this.recentImages,this.lastWeekImages,this.lastMonthImages});
  Map<String, dynamic> toJson() => _$PicturesToJson(this);
  factory Pictures.fromJson(json) => _$PicturesFromJson(json);
}

@JsonSerializable(includeIfNull: false)
class PictureDetail{
  @JsonKey(name: 'user_name',)
  String? userName;
  String? picture;
  @JsonKey(name: 'created_at',)
  String? createdAt;
  @JsonKey(name: 'formatted_datetime',)
  String? formattedDatetime;


  PictureDetail({this.userName,this.picture,this.createdAt,this.formattedDatetime});
  Map<String, dynamic> toJson() => _$PictureDetailToJson(this);
  factory PictureDetail.fromJson(json) => _$PictureDetailFromJson(json);
}