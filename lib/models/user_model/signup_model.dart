import 'package:flocdock/models/groupModel/category_model.dart';
import 'package:flocdock/models/groupModel/event_model.dart';
import 'package:flocdock/models/user_model/profile_model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'signup_model.g.dart';



@HiveType(typeId: 129)
@JsonSerializable(includeIfNull: false)
class Profile extends HiveObject{
  String? userName;
  String? usernameOrEmail;
  String? userEmail;
  String? confirmPassword;
  String? userPassword;
  String? phoneNumber;
  String? birthday;
  String? gender;
  String? oneSignalId;
  @JsonKey(name: 'temp_password_flag')
  @HiveField(1)
  String? tempPasswordFlag;
  @HiveField(2)
  String? status;
  @HiveField(3)
  UserDetail? data;
  Profile({this.userName,this.usernameOrEmail,this.userEmail,this.userPassword,this.confirmPassword,
    this.phoneNumber,this.birthday,this.gender,this.tempPasswordFlag,this.status,this.data});
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
  factory Profile.fromJson(json) => _$ProfileFromJson(json);
}

@HiveType(typeId: 130)
@JsonSerializable(includeIfNull: false)
class UserDetail extends HiveObject{
  @JsonKey(name: 'users_id',)
  @HiveField(1)
  int? usersId;
  @JsonKey(name: 'user_name',)
  @HiveField(2)
  String? userName;
  @HiveField(3)
  String? email;
  @HiveField(4)
  String? password;
  @JsonKey(name: 'confirm_password',)
  @HiveField(5)
  String? confirmPassword;
  @JsonKey(name: 'account_type',)
  @HiveField(6)
  String? accountType;
  @JsonKey(name: 'profile_picture',)
  @HiveField(7)
  String? profilePicture;
  @JsonKey(name: 'social_acc_type',)
  @HiveField(8)
  String? socialAccType;
  @JsonKey(name: 'google_access_token',)
  @HiveField(9)
  String? googleAccessToken;
  @JsonKey(name: 'apple_id',)
  @HiveField(10)
  String? appleId;
  @HiveField(11)
  String? birthday;
  @HiveField(12)
  String? gender;
  @HiveField(13)
  String? description;
  @JsonKey(name: 'notification_status',)
  @HiveField(14)
  String? notificationStatus;
  @JsonKey(name: 'date_added',)
  @HiveField(15)
  String? dateAdded;
  @HiveField(16)
  String? status;
  @JsonKey(name: 'roles_id',)
  @HiveField(17)
  int? rolesId;
  @JsonKey(name: 'updated_at',)
  @HiveField(18)
  String? updatedAt;
  @JsonKey(name: 'verify_code',)
  @HiveField(19)
  String? verifyCode;
  @JsonKey(name: 'one_signal_id',)
  @HiveField(20)
  String? playerId;
  @JsonKey(name: 'user_lat',)
  @HiveField(21)
  double? latitude;
  @JsonKey(name: 'user_long',)
  @HiveField(22)
  double? longitude;
  @JsonKey(name: 'distance_away',)
  double distanceAway;
  @JsonKey(name: 'phone_number',)
  String? phoneNumber;
  @JsonKey(name: 'show_age',)
  String? showAge;
  String? height;
  String? weight;
  @JsonKey(name: 'ethnicity_id',)
  int? ethnicityId;
  @JsonKey(name: 'body_type_id',)
  int? bodyTypeId;
  @JsonKey(name: 'position_id',)
  int? positionId;
  @JsonKey(name: 'relationship_id',)
  int? relationshipId;
  @JsonKey(name: 'user_seekings',)
  List<int>? userSeeking;
  @JsonKey(name: 'user_tribes',)
  List<int>? userTribes;
  @JsonKey(name: 'hiv_status',)
  String? hivStatus;
  @JsonKey(name: 'date_of_last_test',)
  String? dateOfLastTest;
  @JsonKey(name: 'covid_vaccine',)
  String? covidVaccine;
  @JsonKey(name: 'facebook_link',)
  String? facebookLink;
  @JsonKey(name: 'instagram_link',)
  String? instagramLink;
  @JsonKey(name: 'twitter_link',)
  String? twitterLink;
  @JsonKey(name: 'blocked_users_count',)
  int blockedUsersCount;
  @JsonKey(name: 'unit_system',)
  String? unitSystem;
  @JsonKey(name: 'member_status',)
  String? memberStatus;
  String? verified;
  @JsonKey(name: 'other_private_gallery_access',)
  String? otherPrivateGalleryAccess;
  int? age;
  int? reliability;
  String? ethnicity;
  @JsonKey(name: 'body_type',)
  String? bodyType;
  @JsonKey(name: 'relationship_status',)
  String? relationshipStatus;
  @JsonKey(name: 'is_tapped',)
  bool isTapped;
  @JsonKey(name: 'is_meetup',)
  bool isMeetup;
  @JsonKey(name: 'is_online',)
  bool isOnline;
  @JsonKey(name: 'is_favourite',)
  bool isFavourite;
  @JsonKey(name: 'other_user_seekings',)
  List<Seeking>? seeking;
  @JsonKey(name: 'other_user_tribes',)
  List<Tribe>? tribes;
  @JsonKey(name: 'other_user_stories',)
  List<PictureDetail>? otherUserStories;
  @JsonKey(name: 'attended_groups',)
  List<GroupData>? attendedGroups;
  @JsonKey(name: 'hosted_groups',)
  List<GroupData>? hostedGroups;
  @JsonKey(name: 'group_id',)
  int? groupId;

  UserDetail({
    this.usersId,this.userName,this.email,this.password,this.confirmPassword,this.accountType,
    this.profilePicture,this.socialAccType,this.googleAccessToken,this.appleId,this.notificationStatus,
    this.dateAdded,this.status,this.rolesId, this.updatedAt,this.verifyCode,this.playerId,this.birthday,
    this.description,this.gender,this.phoneNumber,this.showAge,this.height,this.weight,this.facebookLink,
    this.twitterLink, this.instagramLink,this.bodyTypeId,this.relationshipId,this.userSeeking,
    this.userTribes,this.positionId,this.ethnicityId,this.covidVaccine,this.dateOfLastTest,this.hivStatus,
    this.longitude,this.latitude,this.distanceAway=0,this.blockedUsersCount=0,this.unitSystem,
    this.memberStatus,this.verified,this.otherPrivateGalleryAccess,this.age,this.ethnicity,this.bodyType,
    this.relationshipStatus,this.isMeetup=false,this.isTapped=false,this.isOnline=false,
    this.isFavourite=false,this.seeking,this.tribes,this.otherUserStories,this.attendedGroups,
    this.hostedGroups,this.groupId,this.reliability,
});
  Map<String, dynamic> toJson() => _$UserDetailToJson(this);
  factory UserDetail.fromJson(json) => _$UserDetailFromJson(json);
}