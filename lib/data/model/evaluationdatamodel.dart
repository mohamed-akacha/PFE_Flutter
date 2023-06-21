import 'package:pfe_flutter/data/model/bloc.dart';
import 'package:pfe_flutter/data/model/evaluationpoint.dart';
import 'package:pfe_flutter/data/model/inspection.dart';

class EvaluationDataModel {
  Inspection? inspection;
  List<Bloc>? blocks;
  List<EvaluationPoint>? criteria;

  EvaluationDataModel({this.inspection, this.blocks, this.criteria});

  factory EvaluationDataModel.fromJson(Map<String, dynamic> json) {
    return EvaluationDataModel(
      inspection: json['inspection'] != null ? Inspection.fromJson(json['inspection']) : null,
      blocks: json['blocs'] != null ? (json['blocs'] as List).map((i) => Bloc.fromJson(i)).toList() : null,
      criteria: json['criteria'] != null ? (json['criteria'] as List).map((i) => EvaluationPoint.fromJson(i)).toList() : null,
    );
  }


}