import 'package:json_annotation/json_annotation.dart';
part 'category_model.g.dart';

@JsonSerializable(includeIfNull: false)
class GroupDetail{
  @JsonKey(name: 'group_categories',)
  List<GroupCategory>? groupCategories;
  @JsonKey(name: 'tribes',)
  List<Tribe>? tribes;
  @JsonKey(name: 'features',)
  List<Features>? features;
  @JsonKey(name: 'important_rules',)
  List<ImportantRules>? importantRules;
  GroupDetail({this.groupCategories,this.tribes,this.features,this.importantRules});

  Map<String, dynamic> toJson() => _$GroupDetailToJson(this);
  factory GroupDetail.fromJson(json) => _$GroupDetailFromJson(json);
}

@JsonSerializable(includeIfNull: false)
class GroupCategory{
  @JsonKey(name: 'group_category_id',)
  int? categoryId;
  @JsonKey(name: 'category',)
  String? category;
  @JsonKey(name: 'category_image',)
  String? categoryImage;
  @JsonKey(name: 'status',)
  String? status;
  GroupCategory({this.categoryId,this.category,this.categoryImage,this.status});

  Map<String, dynamic> toJson() => _$GroupCategoryToJson(this);
  factory GroupCategory.fromJson(json) => _$GroupCategoryFromJson(json);
}

@JsonSerializable(includeIfNull: false)
class Tribe{
  @JsonKey(name: 'tribe_id',)
  int? tribeId;
  @JsonKey(name: 'tribe',)
  String? tribe;
  @JsonKey(name: 'status',)
  String? status;
  Tribe({this.tribeId,this.tribe,this.status});

  Map<String, dynamic> toJson() => _$TribeToJson(this);
  factory Tribe.fromJson(json) => _$TribeFromJson(json);
}

@JsonSerializable(includeIfNull: false)
class Features{
  @JsonKey(name: 'feature_id',)
  int? featureId;
  @JsonKey(name: 'feature',)
  String? feature;
  @JsonKey(name: 'status',)
  String? status;
  Features({this.featureId,this.feature,this.status});

  Map<String, dynamic> toJson() => _$FeaturesToJson(this);
  factory Features.fromJson(json) => _$FeaturesFromJson(json);
}

@JsonSerializable(includeIfNull: false)
class ImportantRules{
  @JsonKey(name: 'important_rule_id',)
  int? importantRuleId;
  @JsonKey(name: 'important_rule',)
  String? importantRule;
  String? status;
  String? answer;
  @JsonKey(name: 'group_important_rule_id',)
  int? groupImportantRuleId;

  ImportantRules({this.importantRuleId,this.importantRule,this.status,this.answer,this.groupImportantRuleId});

  Map<String, dynamic> toJson() => _$ImportantRulesToJson(this);
  factory ImportantRules.fromJson(json) => _$ImportantRulesFromJson(json);
}