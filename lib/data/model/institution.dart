import 'package:pfe_flutter/data/model/unit-inspection.dart';

class Institution {
  final int id;
  final String nom;
  final String adresse;
  final String nature;
  final List<UnitInspection>? unitInspections;

  Institution({
    required this.id,
    required this.nom,
    required this.adresse,
    required this.nature,
     this.unitInspections,
  });

  factory Institution.fromJson(Map<String, dynamic> json) {
    var list = json['unitInspections'] as List?;
    List<UnitInspection>? unitInspectionsList = list?.map((i) => UnitInspection.fromJson(i)).toList();
    return Institution(
      id: json['id'],
      nom: json['nom'],
      adresse: json['adresse'],
      nature: json['nature'],
      unitInspections: unitInspectionsList,
    );
  }
}

