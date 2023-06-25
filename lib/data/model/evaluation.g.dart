// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evaluation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Evaluation _$EvaluationFromJson(Map<String, dynamic> json) => Evaluation(
      inspectionId: json['inspectionId'] as int,
      blocId: json['blocId'] as int,
      evaluationPointId: json['evaluationPointId'] as int,
      score: json['score'] as int,
      pieceJointe: json['pieceJointe'] as String?,
    );

Map<String, dynamic> _$EvaluationToJson(Evaluation instance) =>
    <String, dynamic>{
      'inspectionId': instance.inspectionId,
      'blocId': instance.blocId,
      'evaluationPointId': instance.evaluationPointId,
      'score': instance.score,
      'pieceJointe': instance.pieceJointe,
    };
