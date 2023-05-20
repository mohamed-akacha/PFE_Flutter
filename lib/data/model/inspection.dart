import 'package:pfe_flutter/data/model/evaluation.dart';
import 'package:pfe_flutter/data/model/unit-inspection.dart';
import 'package:pfe_flutter/data/model/user.dart';

class Inspection {
  final int id;
  final String description;
  final DateTime datePrevue;
  final DateTime? dateInspection;
  final bool statut;
  final String type;
  final User user;
  final UnitInspection unit;
  final List<Evaluation>? evaluations;

  Inspection({
    required this.id,
    required this.description,
    required this.datePrevue,
    required this.dateInspection,
    required this.statut,
    required this.type,
    required this.user,
    required this.unit,
    this.evaluations,
  });

  factory Inspection.fromJson(Map<String, dynamic> json) {
    var evalListJson = json['evaluations'] as List?;
    List<Evaluation>? evalList = evalListJson?.map((i) => Evaluation.fromJson(i)).toList();

    return Inspection(
      id: json['id'],
      description: json['description'],
      datePrevue: DateTime.parse(json['datePrevue']),
      dateInspection: json['dateInspection'] != null
          ? DateTime.parse(json['dateInspection'])
          : null,
      statut: json['statut'],
      type: json['type'],
      user: User.fromJson(json['user']),
      unit: UnitInspection.fromJson(json['unit']),
      evaluations: evalList,
    );
  }
}
