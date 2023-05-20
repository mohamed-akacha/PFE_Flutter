import 'package:pfe_flutter/data/model/bloc.dart';
import 'package:pfe_flutter/data/model/evaluationpoint.dart';
import 'package:pfe_flutter/data/model/inspection.dart';

class Evaluation {
  final int id;
  final int score;
  final String? pieceJointe;
  final Inspection inspection;
  final EvaluationPoint evaluationPoint;
  final Bloc bloc;

  Evaluation({
    required this.id,
    required this.score,
    required this.pieceJointe,
    required this.inspection,
    required this.evaluationPoint,
    required this.bloc,
  });

  factory Evaluation.fromJson(Map<String, dynamic> json) {
    return Evaluation(
      id: json['id'],
      score: json['score'],
      pieceJointe: json['pieceJointe'],
      inspection: Inspection.fromJson(json['inspection']),
      evaluationPoint: EvaluationPoint.fromJson(json['evaluationPoint']),
      bloc: Bloc.fromJson(json['bloc']),
    );
  }
}
