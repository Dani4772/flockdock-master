// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupDetail _$GroupDetailFromJson(Map<String, dynamic> json) => GroupDetail(
      groupCategories: (json['group_categories'] as List<dynamic>?)
          ?.map((e) => GroupCategory.fromJson(e))
          .toList(),
      tribes: (json['tribes'] as List<dynamic>?)
          ?.map((e) => Tribe.fromJson(e))
          .toList(),
      features: (json['features'] as List<dynamic>?)
          ?.map((e) => Features.fromJson(e))
          .toList(),
      importantRules: (json['important_rules'] as List<dynamic>?)
          ?.map((e) => ImportantRules.fromJson(e))
          .toList(),
    );

Map<String, dynamic> _$GroupDetailToJson(GroupDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('group_categories', instance.groupCategories);
  writeNotNull('tribes', instance.tribes);
  writeNotNull('features', instance.features);
  writeNotNull('important_rules', instance.importantRules);
  return val;
}

GroupCategory _$GroupCategoryFromJson(Map<String, dynamic> json) =>
    GroupCategory(
      categoryId: json['group_category_id'] as int?,
      category: json['category'] as String?,
      categoryImage: json['category_image'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$GroupCategoryToJson(GroupCategory instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('group_category_id', instance.categoryId);
  writeNotNull('category', instance.category);
  writeNotNull('category_image', instance.categoryImage);
  writeNotNull('status', instance.status);
  return val;
}

Tribe _$TribeFromJson(Map<String, dynamic> json) => Tribe(
      tribeId: json['tribe_id'] as int?,
      tribe: json['tribe'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$TribeToJson(Tribe instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('tribe_id', instance.tribeId);
  writeNotNull('tribe', instance.tribe);
  writeNotNull('status', instance.status);
  return val;
}

Features _$FeaturesFromJson(Map<String, dynamic> json) => Features(
      featureId: json['feature_id'] as int?,
      feature: json['feature'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$FeaturesToJson(Features instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('feature_id', instance.featureId);
  writeNotNull('feature', instance.feature);
  writeNotNull('status', instance.status);
  return val;
}

ImportantRules _$ImportantRulesFromJson(Map<String, dynamic> json) =>
    ImportantRules(
      importantRuleId: json['important_rule_id'] as int?,
      importantRule: json['important_rule'] as String?,
      status: json['status'] as String?,
      answer: json['answer'] as String?,
      groupImportantRuleId: json['group_important_rule_id'] as int?,
    );

Map<String, dynamic> _$ImportantRulesToJson(ImportantRules instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('important_rule_id', instance.importantRuleId);
  writeNotNull('important_rule', instance.importantRule);
  writeNotNull('status', instance.status);
  writeNotNull('answer', instance.answer);
  writeNotNull('group_important_rule_id', instance.groupImportantRuleId);
  return val;
}
