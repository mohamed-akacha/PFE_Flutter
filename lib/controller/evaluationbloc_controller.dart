import 'dart:io';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pfe_flutter/core/class/statusrequest.dart';
import 'package:pfe_flutter/core/services/services.dart';
import 'package:pfe_flutter/data/datasource/remote/firebase_api.dart';
import 'package:pfe_flutter/data/datasource/remote/sendevaluation.dart';
import 'package:pfe_flutter/data/model/evaluation.dart';
import 'package:pfe_flutter/data/model/evaluationpoint.dart';


class EvaluationBlocController extends GetxController {
  final int blockId;
  final int inspectionId;
  RxList<Evaluation> evaluations = RxList<Evaluation>();
  List<EvaluationPoint>? criteria = [];
  RxList<String?> fileNames = RxList<String?>(
  ); // Liste pour stocker les noms des fichiers sélectionnés
  RxList<String?> downloadUrls = RxList<String?>(
  ); // Liste pour stocker les liens de téléchargement après l'upload
  final MyServices myServices = Get.find();
  var statusRequest = StatusRequest.none.obs;
  late final SendEvaluation sendEvaluation;

  EvaluationBlocController(
      {required this.blockId, required this.inspectionId, required this.criteria }) {
    if (criteria != null) {
      for (var point in criteria!) {
        evaluations.add(Evaluation(
          inspectionId: inspectionId,
          blocId: blockId,
          evaluationPointId: point.id,
          score: 0,
          pieceJointe: null,
        ));
        fileNames.add(
            null); // Ajout de la valeur null pour chaque évaluation initiale
        downloadUrls.add(
            null); // Ajout de la valeur null pour chaque évaluation initiale
      }
    }
  }

  @override
  void onInit() {
    sendEvaluation = Get.put(SendEvaluation());
    super.onInit();
  }

  void updateScore(int index, double score) {
    Evaluation updatedEvaluation = Evaluation(
      inspectionId: inspectionId,
      blocId: blockId,
      evaluationPointId: evaluations[index].evaluationPointId,
      score: (score.toDouble() * 2).toInt(),
      pieceJointe: evaluations[index].pieceJointe,
    );
    evaluations[index] = updatedEvaluation;
    print("+++++++++++++++++++ score +++++++++++++++++++");
    print(evaluations[index].score);
  }


  Future<void> selectFile(int index) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.single;
      fileNames[index] =
          file.path; // Utilisez le chemin d'accès complet du fichier
    }
  }

  Future<void> uploadFiles() async {
    for (var i = 0; i < fileNames.length; i++) {
      final fileName = fileNames[i];
      if (fileName != null) {
        final file = File(fileName);
        final destination = 'files/${file.path
            .split('/')
            .last}'; // Utilisez le chemin d'accès complet du fichier
        print("********************************************************");
        print(destination);
        final task = FirebaseApi.uploadFile(destination, file);
        if (task != null) {
          final snapshot = await task.whenComplete(() {});
          final urlDownload = await snapshot.ref.getDownloadURL();
          print('Download-Link: $urlDownload');
          downloadUrls[i] = urlDownload;
        }
      }
    }
  }

  Future<void> saveEvaluation() async {
    final token = myServices.sharedPreferences.getString('token');
    for (var i = 0; i < evaluations.length; i++) {
      evaluations[i].pieceJointe = downloadUrls[i];
    }
    print(" ************************** ******************************");
    statusRequest.value = await sendEvaluation.sendEvaluation(evaluations, token!);

    if (statusRequest.value == StatusRequest.success) {
      // Ajout de l'ID du bloc à la liste des blocs évalués dans SharedPreferences
      List<int> evaluatedBlocks = await myServices.getEvaluatedBlocks();
      evaluatedBlocks.add(blockId);
      await myServices.setEvaluatedBlocks(evaluatedBlocks);
      Get.back();
    }
  }
}
