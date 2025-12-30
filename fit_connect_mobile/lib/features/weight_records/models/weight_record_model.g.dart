// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeightRecord _$WeightRecordFromJson(Map<String, dynamic> json) => WeightRecord(
      id: json['id'] as String,
      clientId: json['client_id'] as String,
      weight: (json['weight'] as num).toDouble(),
      notes: json['notes'] as String?,
      recordedAt: DateTime.parse(json['recorded_at'] as String),
      source: json['source'] as String,
      messageId: json['message_id'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$WeightRecordToJson(WeightRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client_id': instance.clientId,
      'weight': instance.weight,
      'notes': instance.notes,
      'recorded_at': instance.recordedAt.toIso8601String(),
      'source': instance.source,
      'message_id': instance.messageId,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
