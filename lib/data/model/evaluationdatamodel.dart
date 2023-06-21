import 'package:pfe_flutter/data/model/bloc.dart';
import 'package:pfe_flutter/data/model/evaluationpoint.dart';
import 'package:pfe_flutter/data/model/inspection.dart';

class Evaluation {
  Inspection? inspection;
  List<Bloc>? blocks;
  List<EvaluationPoint>? criteria;

  Evaluation({this.inspection, this.blocks, this.criteria});

  factory Evaluation.fromJson(Map<String, dynamic> json) {
    return Evaluation(
      inspection: Inspection.fromJson(json['inspection']),
      blocks: (json['blocs'] as List).map((i) => Bloc.fromJson(i)).toList(),
      criteria:
      (json['criteria'] as List).map((i) => EvaluationPoint.fromJson(i)).toList(),
    );
  }
}