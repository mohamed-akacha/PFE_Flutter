import 'dart:io';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pfe_flutter/core/class/statusrequest.dart';
import 'package:pfe_flutter/core/services/services.dart';
import 'package:pfe_flutter/data/datasource/remote/firebase_api.dart';
import 'package:pfe_flutter/data/datasource/remote/sendevaluation.dart';
import 'package:pfe_flutter/data/model/evaluation.dart';
import 'package:pfe_flutter/data/model/evaluationpoint.dart';


class EvaluationBlocController extends GetxController {
  final int blockId;
  final int inspectionId;
  List<Evaluation> evaluations = [];
  List<EvaluationPoint>? criteria = [];
  List<String?> fileNames = [
  ]; // Liste pour stocker les noms des fichiers sélectionnés
  List<String?> downloadUrls = [
  ]; // Liste pour stocker les liens de téléchargement après l'upload
  final MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  late final SendEvaluation sendEvaluation;
  EvaluationBlocController(
      {required this.blockId, required this.inspectionId, required this.criteria}) {
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
    evaluations[index].score = (score.toInt());
    print("+++++++++++++++++++ score +++++++++++++++++++");
    print(evaluations[index].score);
    update();
  }

  Future<void> selectFile(int index) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.single;
      fileNames[index] =
          file.path; // Utilisez le chemin d'accès complet du fichier

      update();
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

  update();

  }

  Future<void> saveEvaluation() async {
    final token = myServices.sharedPreferences.getString('token');
      for (var i = 0; i < evaluations.length; i++) {
        evaluations[i].pieceJointe = downloadUrls[i];
     //   print("liste de evaluation : ${evaluations[i]}");
      }
      print(" ************************** ******************************");
      statusRequest = await sendEvaluation.sendEvaluation(evaluations, token!);

    if (statusRequest == StatusRequest.success) {
      Get.back();
    }
  }
}
