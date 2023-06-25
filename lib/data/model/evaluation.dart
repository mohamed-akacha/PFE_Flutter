import 'package:json_annotation/json_annotation.dart';

part 'evaluation.g.dart';

@JsonSerializable()
class Evaluation {
  final int inspectionId;
  final int blocId;
  final int evaluationPointId;
  late  int score;
  late  String? pieceJointe;

  Evaluation({
    required this.inspectionId,
    required this.blocId,
    required this.evaluationPointId,
    required this.score,
    this.pieceJointe,
  });

  factory Evaluation.fromJson(Map<String, dynamic> json) =>
      _$EvaluationFromJson(json);

  Map<String, dynamic> toJson() => _$EvaluationToJson(this);
}
