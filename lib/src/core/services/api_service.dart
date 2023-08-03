import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import '../models/chat_model.dart';
import '../models/models_model.dart';

class ApiService {
  final dio = Dio();
  Future<List<ModelsModel>> getModels() async {
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

  Future<List<ChatModel>> sendMessage({
    required String msg,
    required String modelId,
  }) async {
    final options = Options(
      validateStatus: (status) => true,
      contentType: Headers.jsonContentType,
      headers: {'Authorization': 'Bearer $apiKey'},
    );

    try {
      final response = await dio.post<Map<String, dynamic>>(
        '$baseUrl/completions',
        data: jsonEncode(
          {
            'model': modelId,
            'prompt': msg,
            'max_tokens': 100,
          },
        ),
        options: options,
      );
      var list = <ChatModel>[];

      final responseChat = response.data!['choices'] as List;
      if (response.statusCode == 200) {
        if (responseChat.isNotEmpty) {
          list = ChatModel.createListChat(responseChat, isRealGPT: false);
        }
      }

      return list;
    } catch (e) {
      HttpException(e.toString());
      rethrow;
    }
  }

  Future<List<ChatModel>> sendMessageGPT({
    required String msg,
    required String modelId,
  }) async {
    final options = Options(
      validateStatus: (status) => true,
      contentType: Headers.jsonContentType,
      headers: {'Authorization': 'Bearer $apiKey'},
    );

    try {
      final response = await dio.post<Map<String, dynamic>>(
        '$baseUrl/chat/completions',
        data: jsonEncode(
          {
            'model': modelId,
            'messages': [
              {
                'role': 'user',
                'content': msg,
              }
            ]
          },
        ),
        options: options,
      );
      var list = <ChatModel>[];
      final responseChat = response.data!['choices'] as List;
      if (response.statusCode == 200) {
        if (responseChat.isNotEmpty) {
          list = ChatModel.createListChat(responseChat, isRealGPT: true);
        }
      }

      return list;
    } catch (e) {
      HttpException(e.toString());
      rethrow;
    }
  }
}
