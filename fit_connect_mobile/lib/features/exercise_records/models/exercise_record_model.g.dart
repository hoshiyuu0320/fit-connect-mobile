// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseRecord _$ExerciseRecordFromJson(Map<String, dynamic> json) =>
    ExerciseRecord(
      id: json['id'] as String,
      clientId: json['client_id'] as String,
      exerciseType: json['exercise_type'] as String,
      memo: json['memo'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      duration: (json['duration'] as num?)?.toInt(),
      distance: (json['distance'] as num?)?.toDouble(),
      calories: (json['calories'] as num?)?.toDouble(),
      recordedAt: DateTime.parse(json['recorded_at'] as String),
      source: json['source'] as String,
      messageId: json['message_id'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ExerciseRecordToJson(ExerciseRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client_id': instance.clientId,
      'exercise_type': instance.exerciseType,
      'memo': instance.memo,
      'images': instance.images,
      'duration': instance.duration,
      'distance': instance.distance,
      'calories': instance.calories,
      'recorded_at': instance.recordedAt.toIso8601String(),
      'source': instance.source,
      'message_id': instance.messageId,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
