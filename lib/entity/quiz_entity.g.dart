// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizEntity _$QuizEntityFromJson(Map<String, dynamic> json) => QuizEntity(
      quizName: json['quizName'] as String,
      module: json['module'] as String,
      subjectClass: json['subjectClass'] as String,
      userRole: json['userRole'] as String,
      quizType: json['quizType'] as String,
      timer: json['timer'] as String,
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => BankQuestionEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      docId: json['docId'] as String?,
      quizResult:
          (json['quizResult'] as List<dynamic>?)?.map((e) => e as int).toList(),
      quizResultId: json['quizResultId'] as String?,
    );

Map<String, dynamic> _$QuizEntityToJson(QuizEntity instance) =>
    <String, dynamic>{
      'quizName': instance.quizName,
      'module': instance.module,
      'subjectClass': instance.subjectClass,
      'userRole': instance.userRole,
      'quizType': instance.quizType,
      'timer': instance.timer,
      'docId': instance.docId,
      'questions': instance.questions?.map((e) => e.toJson()).toList(),
      'quizResult': instance.quizResult,
      'quizResultId': instance.quizResultId,
    };
