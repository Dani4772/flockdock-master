import 'package:flocdock/models/groupModel/category_model.dart';
import 'package:flocdock/models/user_model/signup_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'event_model.g.dart';

@JsonSerializable(includeIfNull: false)
class EventDetail{
  @JsonKey(name: 'group_id',)
  int? groupId;
  @JsonKey(name: 'users_id',)
  int? usersId;
  @JsonKey(name: 'group_category_id',)
  int? groupCategoryId;
  String? groupCategoryName;
  String? groupCategoryImage;
  String? title;
  @JsonKey(name: 'cover_photo',)
  String? coverPhoto;
  @JsonKey(name: 'starting_time',)
  String? startingTime;
  @JsonKey(name: 'ending_time',)
  String? endingTime;
  @JsonKey(name: 'starting_date',)
  String? startingDate;
  @JsonKey(name: 'ending_date',)
  String? endingDate;
  String? address;
  @JsonKey(name: 'group_long',)
  double? groupLong;
  @JsonKey(name: 'group_lat',)
  double? groupLat;
  @JsonKey(name: 'additional_instructions',)
  String? additionalInstructions;
  @JsonKey(name: 'max_group_size',)
  String? maxGroupSize;
  @JsonKey(name: 'top_to_bottom_ratio',)
  String? topToBottomRatio;
  @JsonKey(name: 'invite_other_guests',)
  String? inviteOtherGuests;
  List<int>? guests;
  @JsonKey(name: 'user_guests',)
  List<UserDetail>? userGuests;
  String? cover;
  int? cost;
  List<int>? tribes;
  @JsonKey(name: 'important_rules',)
  List<Rules>? importantRules;
  List<int>? features;
  List<int>? rules;
  List<int>? categories;
  String? date;
  bool fromEdit;

  EventDetail({this.groupId,this.usersId,this.groupCategoryId,this.title,this.coverPhoto,
    this.startingTime, this.endingTime,this.startingDate,this.endingDate, this.address,
    this.groupLong,this.groupLat,this.additionalInstructions,this.maxGroupSize,this.cost,
    this.topToBottomRatio,this.userGuests,this.inviteOtherGuests,this.guests,this.cover,
    this.tribes,this.importantRules,this.features,this.groupCategoryName,this.groupCategoryImage,
    this.rules,this.categories,this.date,this.fromEdit=false});

  Map<String, dynamic> toJson() => _$EventDetailToJson(this);
  factory EventDetail.fromJson(json) => _$EventDetailFromJson(json);
}

// @JsonSerializable(includeIfNull: false)
// class BasicDetail{
//   @JsonKey(name: 'title',)
//   String? title;
//   @JsonKey(name: 'coverPhoto',)
//   String? coverPhoto;
//   @JsonKey(name: 'startingTime',)
//   String? startingTime;
//   @JsonKey(name: 'endingTime',)
//   String? endingTime;
//   @JsonKey(name: 'startingDate',)
//   String? startingDate;
//   @JsonKey(name: 'endingDate',)
//   String? endingDate;
//   @JsonKey(name: 'address',)
//   String? address;
//   @JsonKey(name: 'groupLong',)
//   String? groupLong;
//   @JsonKey(name: 'groupLat',)
//   String? groupLat;
//   @JsonKey(name: 'additionalInstructions',)
//   String? additionalInstructions;
//
//
//   BasicDetail({this.title,this.coverPhoto,this.startingTime,this.endingTime,this.startingDate,this.endingDate,
//   this.address,this.groupLong,this.groupLat,this.additionalInstructions});
//
//   Map<String, dynamic> toJson() => _$BasicDetailToJson(this);
//   factory BasicDetail.fromJson(json) => _$BasicDetailFromJson(json);
// }

@JsonSerializable(includeIfNull: false)
class Rules{
  @JsonKey(name: 'important_rule_id',)
  int? importantRuleId;
  String answer;
  Rules({this.importantRuleId,this.answer="No"});

  Map<String, dynamic> toJson() => _$RulesToJson(this);
  factory Rules.fromJson(json) => _$RulesFromJson(json);
}
@JsonSerializable(includeIfNull: false)
class GroupData{
  @JsonKey(name: 'group_id',)
  int? groupId;
  @JsonKey(name: 'users_id',)
  int? usersId;
  @JsonKey(name: 'group_category_id',)
  int? groupCategoryId;
  String? title;
  @JsonKey(name: 'cover_photo',)
  String? coverPhoto;
  @JsonKey(name: 'starting_time',)
  String? startingTime;
  @JsonKey(name: 'ending_time',)
  String? endingTime;
  @JsonKey(name: 'starting_date',)
  String? startingDate;
  @JsonKey(name: 'ending_date',)
  String? endingDate;
  String? address;
  @JsonKey(name: 'group_long',)
  double? groupLong;
  @JsonKey(name: 'group_lat',)
  double? groupLat;
  @JsonKey(name: 'additional_instructions',)
  String? additionalInstructions;
  @JsonKey(name: 'max_group_size',)
  String? maxGroupSize;
  @JsonKey(name: 'top_to_bottom_ratio',)
  String? topToBottomRatio;
  @JsonKey(name: 'invite_other_guests',)
  String? inviteOtherGuests;
  @JsonKey(name: 'created_at',)
  String? createdAt;
  String? status;
  @JsonKey(name: 'total_attendees',)
  int? totalAttendees;
  List<UserDetail>? members;
  @JsonKey(name: 'formatted_from_datetime',)
  String? formattedFromDatetime;
  @JsonKey(name: 'formatted_to_datetime',)
  String? formattedToDatetime;
  @JsonKey(name: 'is_user_attending',)
  bool? isUserAttending;
  @JsonKey(name: 'is_user_interested',)
  bool? isUserInterested;
  @JsonKey(name: 'is_user_reported',)
  bool? isUserReported;
  @JsonKey(name: 'distance_away',)
  double? distanceAway;
  String? cover;
  int? cost;
  GroupCategory? category;
  List<Tribe>? tribes;
  List<Features>? features;
  List<ImportantRules>? rules;

  GroupData({this.groupId,this.usersId,this.groupCategoryId,this.title,this.coverPhoto,
    this.startingTime,this.endingTime,this.startingDate,this.endingDate,this.address,
    this.groupLong,this.groupLat, this.additionalInstructions,this.maxGroupSize,
    this.topToBottomRatio, this.inviteOtherGuests, this.category,this.formattedFromDatetime,
    this.formattedToDatetime,this.status,this.isUserAttending, this.isUserInterested,
    this.isUserReported,this.createdAt,this.members,this.totalAttendees,this.tribes,
    this.features,this.rules,this.distanceAway,this.cover,this.cost});

  Map<String, dynamic> toJson() => _$GroupDataToJson(this);
  factory GroupData.fromJson(json) => _$GroupDataFromJson(json);
}