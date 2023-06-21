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

  factory Evaluation.fromJson(Map<String, dynamic> json) {
    return Evaluation(
      inspectionId: json['inspectionId'],
      blocId: json['blocId'],
      evaluationPointId: json['evaluationPointId'],
      score: json['score'],
      pieceJointe: json.containsKey('pieceJointe') ? json['pieceJointe'] : null,
    );
  }
}
