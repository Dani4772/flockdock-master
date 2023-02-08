// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileAdapter extends TypeAdapter<Profile> {
  @override
  final int typeId = 129;

  @override
  Profile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Profile(
      tempPasswordFlag: fields[1] as String?,
      status: fields[2] as String?,
      data: fields[3] as UserDetail?,
    );
  }

  @override
  void write(BinaryWriter writer, Profile obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.tempPasswordFlag)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserDetailAdapter extends TypeAdapter<UserDetail> {
  @override
  final int typeId = 130;

  @override
  UserDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDetail(
      usersId: fields[1] as int?,
      userName: fields[2] as String?,
      email: fields[3] as String?,
      password: fields[4] as String?,
      confirmPassword: fields[5] as String?,
      accountType: fields[6] as String?,
      profilePicture: fields[7] as String?,
      socialAccType: fields[8] as String?,
      googleAccessToken: fields[9] as String?,
      appleId: fields[10] as String?,
      notificationStatus: fields[14] as String?,
      dateAdded: fields[15] as String?,
      status: fields[16] as String?,
      rolesId: fields[17] as int?,
      updatedAt: fields[18] as String?,
      verifyCode: fields[19] as String?,
      playerId: fields[20] as String?,
      birthday: fields[11] as String?,
      description: fields[13] as String?,
      gender: fields[12] as String?,
      longitude: fields[22] as double?,
      latitude: fields[21] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, UserDetail obj) {
    writer
      ..writeByte(22)
      ..writeByte(1)
      ..write(obj.usersId)
      ..writeByte(2)
      ..write(obj.userName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.password)
      ..writeByte(5)
      ..write(obj.confirmPassword)
      ..writeByte(6)
      ..write(obj.accountType)
      ..writeByte(7)
      ..write(obj.profilePicture)
      ..writeByte(8)
      ..write(obj.socialAccType)
      ..writeByte(9)
      ..write(obj.googleAccessToken)
      ..writeByte(10)
      ..write(obj.appleId)
      ..writeByte(11)
      ..write(obj.birthday)
      ..writeByte(12)
      ..write(obj.gender)
      ..writeByte(13)
      ..write(obj.description)
      ..writeByte(14)
      ..write(obj.notificationStatus)
      ..writeByte(15)
      ..write(obj.dateAdded)
      ..writeByte(16)
      ..write(obj.status)
      ..writeByte(17)
      ..write(obj.rolesId)
      ..writeByte(18)
      ..write(obj.updatedAt)
      ..writeByte(19)
      ..write(obj.verifyCode)
      ..writeByte(20)
      ..write(obj.playerId)
      ..writeByte(21)
      ..write(obj.latitude)
      ..writeByte(22)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      userName: json['userName'] as String?,
      usernameOrEmail: json['usernameOrEmail'] as String?,
      userEmail: json['userEmail'] as String?,
      userPassword: json['userPassword'] as String?,
      confirmPassword: json['confirmPassword'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      birthday: json['birthday'] as String?,
      gender: json['gender'] as String?,
      tempPasswordFlag: json['temp_password_flag'] as String?,
      status: json['status'] as String?,
      data: json['data'] == null ? null : UserDetail.fromJson(json['data']),
    )..oneSignalId = json['oneSignalId'] as String?;

Map<String, dynamic> _$ProfileToJson(Profile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('userName', instance.userName);
  writeNotNull('usernameOrEmail', instance.usernameOrEmail);
  writeNotNull('userEmail', instance.userEmail);
  writeNotNull('confirmPassword', instance.confirmPassword);
  writeNotNull('userPassword', instance.userPassword);
  writeNotNull('phoneNumber', instance.phoneNumber);
  writeNotNull('birthday', instance.birthday);
  writeNotNull('gender', instance.gender);
  writeNotNull('oneSignalId', instance.oneSignalId);
  writeNotNull('temp_password_flag', instance.tempPasswordFlag);
  writeNotNull('status', instance.status);
  writeNotNull('data', instance.data);
  return val;
}

UserDetail _$UserDetailFromJson(Map<String, dynamic> json) => UserDetail(
      usersId: json['users_id'] as int?,
      userName: json['user_name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      confirmPassword: json['confirm_password'] as String?,
      accountType: json['account_type'] as String?,
      profilePicture: json['profile_picture'] as String?,
      socialAccType: json['social_acc_type'] as String?,
      googleAccessToken: json['google_access_token'] as String?,
      appleId: json['apple_id'] as String?,
      notificationStatus: json['notification_status'] as String?,
      dateAdded: json['date_added'] as String?,
      status: json['status'] as String?,
      rolesId: json['roles_id'] as int?,
      updatedAt: json['updated_at'] as String?,
      verifyCode: json['verify_code'] as String?,
      playerId: json['one_signal_id'] as String?,
      birthday: json['birthday'] as String?,
      description: json['description'] as String?,
      gender: json['gender'] as String?,
      phoneNumber: json['phone_number'] as String?,
      showAge: json['show_age'] as String?,
      height: json['height'] as String?,
      weight: json['weight'] as String?,
      facebookLink: json['facebook_link'] as String?,
      twitterLink: json['twitter_link'] as String?,
      instagramLink: json['instagram_link'] as String?,
      bodyTypeId: json['body_type_id'] as int?,
      relationshipId: json['relationship_id'] as int?,
      userSeeking: (json['user_seekings'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      userTribes: (json['user_tribes'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      positionId: json['position_id'] as int?,
      ethnicityId: json['ethnicity_id'] as int?,
      covidVaccine: json['covid_vaccine'] as String?,
      dateOfLastTest: json['date_of_last_test'] as String?,
      hivStatus: json['hiv_status'] as String?,
      longitude: (json['user_long'] as num?)?.toDouble(),
      latitude: (json['user_lat'] as num?)?.toDouble(),
      distanceAway: (json['distance_away'] as num?)?.toDouble() ?? 0,
      blockedUsersCount: json['blocked_users_count'] as int? ?? 0,
      unitSystem: json['unit_system'] as String?,
      memberStatus: json['member_status'] as String?,
      verified: json['verified'] as String?,
      otherPrivateGalleryAccess:
          json['other_private_gallery_access'] as String?,
      age: json['age'] as int?,
      ethnicity: json['ethnicity'] as String?,
      bodyType: json['body_type'] as String?,
      relationshipStatus: json['relationship_status'] as String?,
      isMeetup: json['is_meetup'] as bool? ?? false,
      isTapped: json['is_tapped'] as bool? ?? false,
      isOnline: json['is_online'] as bool? ?? false,
      isFavourite: json['is_favourite'] as bool? ?? false,
      seeking: (json['other_user_seekings'] as List<dynamic>?)
          ?.map((e) => Seeking.fromJson(e))
          .toList(),
      tribes: (json['other_user_tribes'] as List<dynamic>?)
          ?.map((e) => Tribe.fromJson(e))
          .toList(),
      otherUserStories: (json['other_user_stories'] as List<dynamic>?)
          ?.map((e) => PictureDetail.fromJson(e))
          .toList(),
      attendedGroups: (json['attended_groups'] as List<dynamic>?)
          ?.map((e) => GroupData.fromJson(e))
          .toList(),
      hostedGroups: (json['hosted_groups'] as List<dynamic>?)
          ?.map((e) => GroupData.fromJson(e))
          .toList(),
      groupId: json['group_id'] as int?,
      reliability: json['reliability'] as int?,
    );

Map<String, dynamic> _$UserDetailToJson(UserDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('users_id', instance.usersId);
  writeNotNull('user_name', instance.userName);
  writeNotNull('email', instance.email);
  writeNotNull('password', instance.password);
  writeNotNull('confirm_password', instance.confirmPassword);
  writeNotNull('account_type', instance.accountType);
  writeNotNull('profile_picture', instance.profilePicture);
  writeNotNull('social_acc_type', instance.socialAccType);
  writeNotNull('google_access_token', instance.googleAccessToken);
  writeNotNull('apple_id', instance.appleId);
  writeNotNull('birthday', instance.birthday);
  writeNotNull('gender', instance.gender);
  writeNotNull('description', instance.description);
  writeNotNull('notification_status', instance.notificationStatus);
  writeNotNull('date_added', instance.dateAdded);
  writeNotNull('status', instance.status);
  writeNotNull('roles_id', instance.rolesId);
  writeNotNull('updated_at', instance.updatedAt);
  writeNotNull('verify_code', instance.verifyCode);
  writeNotNull('one_signal_id', instance.playerId);
  writeNotNull('user_lat', instance.latitude);
  writeNotNull('user_long', instance.longitude);
  val['distance_away'] = instance.distanceAway;
  writeNotNull('phone_number', instance.phoneNumber);
  writeNotNull('show_age', instance.showAge);
  writeNotNull('height', instance.height);
  writeNotNull('weight', instance.weight);
  writeNotNull('ethnicity_id', instance.ethnicityId);
  writeNotNull('body_type_id', instance.bodyTypeId);
  writeNotNull('position_id', instance.positionId);
  writeNotNull('relationship_id', instance.relationshipId);
  writeNotNull('user_seekings', instance.userSeeking);
  writeNotNull('user_tribes', instance.userTribes);
  writeNotNull('hiv_status', instance.hivStatus);
  writeNotNull('date_of_last_test', instance.dateOfLastTest);
  writeNotNull('covid_vaccine', instance.covidVaccine);
  writeNotNull('facebook_link', instance.facebookLink);
  writeNotNull('instagram_link', instance.instagramLink);
  writeNotNull('twitter_link', instance.twitterLink);
  val['blocked_users_count'] = instance.blockedUsersCount;
  writeNotNull('unit_system', instance.unitSystem);
  writeNotNull('member_status', instance.memberStatus);
  writeNotNull('verified', instance.verified);
  writeNotNull(
      'other_private_gallery_access', instance.otherPrivateGalleryAccess);
  writeNotNull('age', instance.age);
  writeNotNull('reliability', instance.reliability);
  writeNotNull('ethnicity', instance.ethnicity);
  writeNotNull('body_type', instance.bodyType);
  writeNotNull('relationship_status', instance.relationshipStatus);
  val['is_tapped'] = instance.isTapped;
  val['is_meetup'] = instance.isMeetup;
  val['is_online'] = instance.isOnline;
  val['is_favourite'] = instance.isFavourite;
  writeNotNull('other_user_seekings', instance.seeking);
  writeNotNull('other_user_tribes', instance.tribes);
  writeNotNull('other_user_stories', instance.otherUserStories);
  writeNotNull('attended_groups', instance.attendedGroups);
  writeNotNull('hosted_groups', instance.hostedGroups);
  writeNotNull('group_id', instance.groupId);
  return val;
}
