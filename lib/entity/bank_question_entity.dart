import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
part 'bank_question_entity.g.dart';

@JsonSerializable()
class BankQuestionEntity{

  String discription;
  List<String> answerList;
  int correctAnswerIndex;
  String details;
  bool? isCheck=false;
  String reference;
 // String detailsInformation;
  String module;
  String topic;
  String subject;
  String? docId;
  String? imageUrl;
  String? imageName;
  String? descriptionImageUrl;
  String? descriptionImageName;
  String? rating;
  BankQuestionEntity(
      {required this.discription,
        required this.rating,
      required this.answerList,
         this.isCheck,
        this.docId,
this.imageUrl,
        this.imageName,
        this.descriptionImageUrl,
        this.descriptionImageName,
      required this.correctAnswerIndex,
      required this.details,
      required this.reference,
      //required this.detailsInformation,
      required this.module,
      required this.topic,
      required this.subject});
  factory BankQuestionEntity.fromJson(Map<String, dynamic> json) => _$BankQuestionEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BankQuestionEntityToJson(this);


  static CollectionReference<BankQuestionEntity> collection() {
    return FirebaseFirestore.instance
        .collection('questionBank')
        .withConverter<BankQuestionEntity>(
        fromFirestore: (snapshot, _) =>
            BankQuestionEntity.fromJson(snapshot.data()!),
        toFirestore: (callCenter, _) => callCenter.toJson());
  }

  static DocumentReference<BankQuestionEntity> questionDoc({required String questionId}) {
    return FirebaseFirestore.instance.doc('questionBank/$questionId').withConverter<BankQuestionEntity>(
        fromFirestore: (snapshot, _) => BankQuestionEntity.fromJson(snapshot.data()!),
        toFirestore: (callCenter, _) => callCenter.toJson());
  }
}