import 'dart:io';

import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import '../models/modelsmodel.dart';

class ApiService {
  Future<List<ModelsModel>> getModels() async {
    final dio = Dio();
    final options = Options(
      validateStatus: (status) => true,
      headers: {'Authorization': 'Bearer $apiKey'},
    );

    try {
      final response = await dio.get<Map<String, dynamic>>(
        '$baseUrl/models',
        options: options,
      );
      var list = <ModelsModel>[];
      if (response.statusCode == 200) {
        final data = response.data!['data'] as List;
        list = data
            .map((e) => ModelsModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw HttpException(response.statusMessage.toString());
      }

      return list;
    } catch (e) {
      HttpException(e.toString());
      rethrow;
    }
  }
}
