// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(Map<String, dynamic> json) => Client(
      clientId: json['client_id'] as String,
      name: json['name'] as String,
      trainerId: json['trainer_id'] as String,
      gender: json['gender'] as String?,
      age: (json['age'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toDouble(),
      initialWeight: (json['initial_weight'] as num?)?.toDouble(),
      targetWeight: (json['target_weight'] as num?)?.toDouble(),
      goalDeadline: json['goal_deadline'] == null
          ? null
          : DateTime.parse(json['goal_deadline'] as String),
      goalDescription: json['goal_description'] as String?,
      goalSetAt: json['goal_set_at'] == null
          ? null
          : DateTime.parse(json['goal_set_at'] as String),
      goalAchievedAt: json['goal_achieved_at'] == null
          ? null
          : DateTime.parse(json['goal_achieved_at'] as String),
      profileImageUrl: json['profile_image_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'client_id': instance.clientId,
      'name': instance.name,
      'trainer_id': instance.trainerId,
      'gender': instance.gender,
      'age': instance.age,
      'height': instance.height,
      'initial_weight': instance.initialWeight,
      'target_weight': instance.targetWeight,
      'goal_deadline': instance.goalDeadline?.toIso8601String(),
      'goal_description': instance.goalDescription,
      'goal_set_at': instance.goalSetAt?.toIso8601String(),
      'goal_achieved_at': instance.goalAchievedAt?.toIso8601String(),
      'profile_image_url': instance.profileImageUrl,
      'created_at': instance.createdAt.toIso8601String(),
    };
