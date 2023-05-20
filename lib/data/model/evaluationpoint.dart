import 'package:pfe_flutter/data/model/evaluation.dart';

class EvaluationPoint {
  final int id;
  final String description;
  final String type;
  final List<Evaluation>? evaluations;

  EvaluationPoint({
    required this.id,
    required this.description,
    required this.type,
    this.evaluations,
  });

  factory EvaluationPoint.fromJson(Map<String, dynamic> json) {
    var evalListJson = json['evaluations'] as List?;
    List<Evaluation>? evalList = evalListJson?.map((i) => Evaluation.fromJson(i)).toList();

    return EvaluationPoint(
      id: json['id'],
      description: json['description'],
      type: json['type'],
      evaluations: evalList,
    );
  }
}
