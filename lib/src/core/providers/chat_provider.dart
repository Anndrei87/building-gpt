import 'package:flutter/material.dart';

import '../models/chat_model.dart';
import '../services/api_service.dart';

class ChatProvider with ChangeNotifier {
  final apiService = ApiService();
  var listChat = <ChatModel>[];
  List<ChatModel> get getListChat {
    return listChat;
  }

  void addUserMessage({required String msg}) {
    listChat.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers({
    required String msg,
    required String chosenModelId,
  }) async {
    if (chosenModelId.toLowerCase().startsWith('gpt')) {
      listChat.addAll(
        await apiService.sendMessageGPT(
          msg: msg,
          modelId: chosenModelId,
        ),
      );
    } else {
      listChat.addAll(
        await apiService.sendMessage(
          msg: msg,
          modelId: chosenModelId,
        ),
      );
    }
    notifyListeners();
  }
}
