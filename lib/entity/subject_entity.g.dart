// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectEntity _$SubjectEntityFromJson(Map<String, dynamic> json) =>
    SubjectEntity(
      subject: json['subject'] as String,
      subjectId: json['subjectId'] as String?,
    );

Map<String, dynamic> _$SubjectEntityToJson(SubjectEntity instance) =>
    <String, dynamic>{
      'subject': instance.subject,
      'subjectId': instance.subjectId,
    };
