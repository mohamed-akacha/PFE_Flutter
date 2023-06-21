import 'package:pfe_flutter/data/model/evaluation.dart';
import 'package:pfe_flutter/data/model/unit-inspection.dart';

class Bloc {
  final int id;
  final String code;
  final String nom;
  final int etage;
  final UnitInspection? unit;
  final List<Evaluation>? evaluations;

  Bloc({
    required this.id,
    required this.code,
    required this.nom,
    required this.etage,
    this.unit,
    this.evaluations,
  });

  factory Bloc.fromJson(Map<String, dynamic> json) {
    var evaluationsJson = json['evaluations'] as List?;
    var evaluationsList = evaluationsJson != null
        ? evaluationsJson.map((i) => Evaluation.fromJson(i)).toList()
        : null;

    return Bloc(
      id: json['id'],
      code: json['code'],
      nom: json['nom'],
      etage: json['etage'],
      unit: json['unit'] != null ? UnitInspection.fromJson(json['unit']) : null,
      evaluations: evaluationsList,
    );
  }
}

