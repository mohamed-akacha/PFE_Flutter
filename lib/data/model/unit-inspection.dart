import 'package:pfe_flutter/data/model/bloc.dart';
import 'package:pfe_flutter/data/model/inspection.dart';
import 'package:pfe_flutter/data/model/institution.dart';

class UnitInspection {
  final int id;
  final String nom;
  final String code;
  final Institution? institution;
  final List<Inspection>? inspections;
  final List<Bloc>? blocs;

  UnitInspection({
    required this.id,
    required this.nom,
    required this.code,
    this.institution,
    this.inspections,
    this.blocs,
  });

  factory UnitInspection.fromJson(Map<String, dynamic> json) {
    var inspectionsJson = json['inspections'] as List?;
    var blocsJson = json['blocs'] as List?;

    List<Inspection>? inspectionsList = inspectionsJson?.map((i) => Inspection.fromJson(i)).toList();
    List<Bloc>? blocsList = blocsJson?.map((i) => Bloc.fromJson(i)).toList();

    return UnitInspection(
      id: json['id'],
      nom: json['nom'],
      code: json['code'],
      institution: json['institution'] != null ? Institution.fromJson(json['institution']) : null,  // assign `null` to `institution` if `json['institution']` is null
      inspections: inspectionsList,
      blocs: blocsList,
    );
  }
}

