// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDetail _$EventDetailFromJson(Map<String, dynamic> json) => EventDetail(
      groupId: json['group_id'] as int?,
      usersId: json['users_id'] as int?,
      groupCategoryId: json['group_category_id'] as int?,
      title: json['title'] as String?,
      coverPhoto: json['cover_photo'] as String?,
      startingTime: json['starting_time'] as String?,
      endingTime: json['ending_time'] as String?,
      startingDate: json['starting_date'] as String?,
      endingDate: json['ending_date'] as String?,
      address: json['address'] as String?,
      groupLong: (json['group_long'] as num?)?.toDouble(),
      groupLat: (json['group_lat'] as num?)?.toDouble(),
      additionalInstructions: json['additional_instructions'] as String?,
      maxGroupSize: json['max_group_size'] as String?,
      cost: json['cost'] as int?,
      topToBottomRatio: json['top_to_bottom_ratio'] as String?,
      userGuests: (json['user_guests'] as List<dynamic>?)
          ?.map((e) => UserDetail.fromJson(e))
          .toList(),
      inviteOtherGuests: json['invite_other_guests'] as String?,
      guests: (json['guests'] as List<dynamic>?)?.map((e) => e as int).toList(),
      cover: json['cover'] as String?,
      tribes: (json['tribes'] as List<dynamic>?)?.map((e) => e as int).toList(),
      importantRules: (json['important_rules'] as List<dynamic>?)
          ?.map((e) => Rules.fromJson(e))
          .toList(),
      features:
          (json['features'] as List<dynamic>?)?.map((e) => e as int).toList(),
      groupCategoryName: json['groupCategoryName'] as String?,
      groupCategoryImage: json['groupCategoryImage'] as String?,
      rules: (json['rules'] as List<dynamic>?)?.map((e) => e as int).toList(),
      categories:
          (json['categories'] as List<dynamic>?)?.map((e) => e as int).toList(),
      date: json['date'] as String?,
      fromEdit: json['fromEdit'] as bool? ?? false,
    );

Map<String, dynamic> _$EventDetailToJson(EventDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('group_id', instance.groupId);
  writeNotNull('users_id', instance.usersId);
  writeNotNull('group_category_id', instance.groupCategoryId);
  writeNotNull('groupCategoryName', instance.groupCategoryName);
  writeNotNull('groupCategoryImage', instance.groupCategoryImage);
  writeNotNull('title', instance.title);
  writeNotNull('cover_photo', instance.coverPhoto);
  writeNotNull('starting_time', instance.startingTime);
  writeNotNull('ending_time', instance.endingTime);
  writeNotNull('starting_date', instance.startingDate);
  writeNotNull('ending_date', instance.endingDate);
  writeNotNull('address', instance.address);
  writeNotNull('group_long', instance.groupLong);
  writeNotNull('group_lat', instance.groupLat);
  writeNotNull('additional_instructions', instance.additionalInstructions);
  writeNotNull('max_group_size', instance.maxGroupSize);
  writeNotNull('top_to_bottom_ratio', instance.topToBottomRatio);
  writeNotNull('invite_other_guests', instance.inviteOtherGuests);
  writeNotNull('guests', instance.guests);
  writeNotNull('user_guests', instance.userGuests);
  writeNotNull('cover', instance.cover);
  writeNotNull('cost', instance.cost);
  writeNotNull('tribes', instance.tribes);
  writeNotNull('important_rules', instance.importantRules);
  writeNotNull('features', instance.features);
  writeNotNull('rules', instance.rules);
  writeNotNull('categories', instance.categories);
  writeNotNull('date', instance.date);
  val['fromEdit'] = instance.fromEdit;
  return val;
}

Rules _$RulesFromJson(Map<String, dynamic> json) => Rules(
      importantRuleId: json['important_rule_id'] as int?,
      answer: json['answer'] as String? ?? "No",
    );

Map<String, dynamic> _$RulesToJson(Rules instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('important_rule_id', instance.importantRuleId);
  val['answer'] = instance.answer;
  return val;
}

GroupData _$GroupDataFromJson(Map<String, dynamic> json) => GroupData(
      groupId: json['group_id'] as int?,
      usersId: json['users_id'] as int?,
      groupCategoryId: json['group_category_id'] as int?,
      title: json['title'] as String?,
      coverPhoto: json['cover_photo'] as String?,
      startingTime: json['starting_time'] as String?,
      endingTime: json['ending_time'] as String?,
      startingDate: json['starting_date'] as String?,
      endingDate: json['ending_date'] as String?,
      address: json['address'] as String?,
      groupLong: (json['group_long'] as num?)?.toDouble(),
      groupLat: (json['group_lat'] as num?)?.toDouble(),
      additionalInstructions: json['additional_instructions'] as String?,
      maxGroupSize: json['max_group_size'] as String?,
      topToBottomRatio: json['top_to_bottom_ratio'] as String?,
      inviteOtherGuests: json['invite_other_guests'] as String?,
      category: json['category'] == null
          ? null
          : GroupCategory.fromJson(json['category']),
      formattedFromDatetime: json['formatted_from_datetime'] as String?,
      formattedToDatetime: json['formatted_to_datetime'] as String?,
      status: json['status'] as String?,
      isUserAttending: json['is_user_attending'] as bool?,
      isUserInterested: json['is_user_interested'] as bool?,
      isUserReported: json['is_user_reported'] as bool?,
      createdAt: json['created_at'] as String?,
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => UserDetail.fromJson(e))
          .toList(),
      totalAttendees: json['total_attendees'] as int?,
      tribes: (json['tribes'] as List<dynamic>?)
          ?.map((e) => Tribe.fromJson(e))
          .toList(),
      features: (json['features'] as List<dynamic>?)
          ?.map((e) => Features.fromJson(e))
          .toList(),
      rules: (json['rules'] as List<dynamic>?)
          ?.map((e) => ImportantRules.fromJson(e))
          .toList(),
      distanceAway: (json['distance_away'] as num?)?.toDouble(),
      cover: json['cover'] as String?,
      cost: json['cost'] as int?,
    );

Map<String, dynamic> _$GroupDataToJson(GroupData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('group_id', instance.groupId);
  writeNotNull('users_id', instance.usersId);
  writeNotNull('group_category_id', instance.groupCategoryId);
  writeNotNull('title', instance.title);
  writeNotNull('cover_photo', instance.coverPhoto);
  writeNotNull('starting_time', instance.startingTime);
  writeNotNull('ending_time', instance.endingTime);
  writeNotNull('starting_date', instance.startingDate);
  writeNotNull('ending_date', instance.endingDate);
  writeNotNull('address', instance.address);
  writeNotNull('group_long', instance.groupLong);
  writeNotNull('group_lat', instance.groupLat);
  writeNotNull('additional_instructions', instance.additionalInstructions);
  writeNotNull('max_group_size', instance.maxGroupSize);
  writeNotNull('top_to_bottom_ratio', instance.topToBottomRatio);
  writeNotNull('invite_other_guests', instance.inviteOtherGuests);
  writeNotNull('created_at', instance.createdAt);
  writeNotNull('status', instance.status);
  writeNotNull('total_attendees', instance.totalAttendees);
  writeNotNull('members', instance.members);
  writeNotNull('formatted_from_datetime', instance.formattedFromDatetime);
  writeNotNull('formatted_to_datetime', instance.formattedToDatetime);
  writeNotNull('is_user_attending', instance.isUserAttending);
  writeNotNull('is_user_interested', instance.isUserInterested);
  writeNotNull('is_user_reported', instance.isUserReported);
  writeNotNull('distance_away', instance.distanceAway);
  writeNotNull('cover', instance.cover);
  writeNotNull('cost', instance.cost);
  writeNotNull('category', instance.category);
  writeNotNull('tribes', instance.tribes);
  writeNotNull('features', instance.features);
  writeNotNull('rules', instance.rules);
  return val;
}
