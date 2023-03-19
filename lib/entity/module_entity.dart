import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'module_entity.g.dart';
@JsonSerializable()
class ModuleEntity{
  String module;
  String? moduleId;
  ModuleEntity({required this.module, this.moduleId});

  factory ModuleEntity.fromJson(Map<String, dynamic> json) => _$ModuleEntityFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$ModuleEntityToJson(this);

  static CollectionReference<ModuleEntity> collection() {
    return FirebaseFirestore.instance
        .collection('module')
        .withConverter<ModuleEntity>(
        fromFirestore: (snapshot, _) =>
            ModuleEntity.fromJson(snapshot.data()!),
        toFirestore: (callCenter, _) => callCenter.toJson());
  }

  static DocumentReference moduleDoc({required String subjectId}) {
    return FirebaseFirestore.instance.doc('module/$subjectId').withConverter<ModuleEntity>(
        fromFirestore: (snapshot, _) => ModuleEntity.fromJson(snapshot.data()!),
        toFirestore: (callCenter, _) => callCenter.toJson());
  }

}