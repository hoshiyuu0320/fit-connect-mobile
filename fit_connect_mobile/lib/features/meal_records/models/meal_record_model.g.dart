// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealRecord _$MealRecordFromJson(Map<String, dynamic> json) => MealRecord(
      id: json['id'] as String,
      clientId: json['client_id'] as String,
      mealType: json['meal_type'] as String,
      notes: json['notes'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      calories: (json['calories'] as num?)?.toDouble(),
      recordedAt: DateTime.parse(json['recorded_at'] as String),
      source: json['source'] as String,
      messageId: json['message_id'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$MealRecordToJson(MealRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client_id': instance.clientId,
      'meal_type': instance.mealType,
      'notes': instance.notes,
      'images': instance.images,
      'calories': instance.calories,
      'recorded_at': instance.recordedAt.toIso8601String(),
      'source': instance.source,
      'message_id': instance.messageId,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
