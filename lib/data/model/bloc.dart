import 'package:pfe_flutter/data/model/evaluation.dart';
import 'package:pfe_flutter/data/model/unit-inspection.dart';

class Bloc {
  final int id;
  final String code;
  final String nom;
  final int etage;
  final UnitInspection unit;
  final List<Evaluation>? evaluations;

  Bloc({
    required this.id,
    required this.code,
    required this.nom,
    required this.etage,
    required this.unit,
    this.evaluations,
  });

  factory Bloc.fromJson(Map<String, dynamic> json) {
    var evaluationsJson = json['evaluations'] as List?;
    var evaluationsList = evaluationsJson?.map((i) => Evaluation.fromJson(i)).toList();

    return Bloc(
      id: json['id'],
      code: json['code'],
      nom: json['nom'],
      etage: json['etage'],
      unit: UnitInspection.fromJson(json['unit']),
      evaluations: evaluationsList,
    );
  }
}
