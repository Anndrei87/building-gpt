import 'package:flutter/material.dart';

import '../models/models_model.dart';
import '../services/api_service.dart';

class ModelsProvider with ChangeNotifier {
  final apiService = ApiService();
  List<ModelsModel> modelsList = [];
  String currentModel = 'gpt-3.5-turbo';
  List<ModelsModel> get getModelsList {
    return modelsList;
  }

  String get getCurrentModel => currentModel;

  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }

  Future<List<ModelsModel>> getAllModels() async {
    return modelsList = await apiService.getModels();
  }
}
