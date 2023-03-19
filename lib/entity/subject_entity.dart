import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'subject_entity.g.dart';
@JsonSerializable()
class SubjectEntity{
  String subject;
  String? subjectId;
  SubjectEntity({required this.subject, this.subjectId});

  factory SubjectEntity.fromJson(Map<String, dynamic> json) => _$SubjectEntityFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SubjectEntityToJson(this);


  static CollectionReference<SubjectEntity> collection() {
    return FirebaseFirestore.instance
        .collection('subject')
        .withConverter<SubjectEntity>(
        fromFirestore: (snapshot, _) =>
            SubjectEntity.fromJson(snapshot.data()!),
        toFirestore: (callCenter, _) => callCenter.toJson());
  }

  static DocumentReference subjectDoc({required String subjectId}) {
    return FirebaseFirestore.instance.doc('subject/$subjectId').withConverter<SubjectEntity>(
        fromFirestore: (snapshot, _) => SubjectEntity.fromJson(snapshot.data()!),
        toFirestore: (callCenter, _) => callCenter.toJson());
  }

}