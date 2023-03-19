import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'bank_question_entity.dart';

part 'quiz_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class QuizEntity {
    String quizName;
    String module;
    String subjectClass;
    String userRole;
    String quizType;
   String timer;
   String? docId;

  List<BankQuestionEntity>? questions;
    List<int>? quizResult;
    String? quizResultId;
  QuizEntity({
    required this.quizName,
    required this.module,
    required this.subjectClass,
    required this.userRole,
    required this.quizType,
    required this.timer,
    this.questions,
 this.docId,
    this.quizResult,
    this.quizResultId,


  });

  factory QuizEntity.fromJson(Map<String, dynamic> json) =>
      _$QuizEntityFromJson(json);

  Map<String, dynamic> toJson() => _$QuizEntityToJson(this);

  static CollectionReference<QuizEntity> collection() {
    return FirebaseFirestore.instance
        .collection('quiz')
        .withConverter<QuizEntity>(
            fromFirestore: (snapshot, _) =>
                QuizEntity.fromJson(snapshot.data()!),
            toFirestore: (callCenter, _) => callCenter.toJson());
  }

  static DocumentReference<QuizEntity> quizDoc({required String quizId}) {
    return FirebaseFirestore.instance.doc('quiz/$quizId').withConverter<QuizEntity>(
        fromFirestore: (snapshot, _) => QuizEntity.fromJson(snapshot.data()!),
        toFirestore: (callCenter, _) => callCenter.toJson());
  }
}

