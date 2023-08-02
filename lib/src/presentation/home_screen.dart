import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../core/constants/constants.dart';
import '../core/models/chat_model.dart';
import '../core/providers/models.provider.dart';
import '../core/services/api_service.dart';
import '../core/widgets/bottom_modal.dart';
import '../core/widgets/chat_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isTyping = false;
  late TextEditingController textEditController;
  var listChat = <ChatModel>[];
  late FocusNode _focusNode;
  late ScrollController _scrollController;

  @override
  void initState() {
    textEditController = TextEditingController();
    _focusNode = FocusNode();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    textEditController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext _) {
    final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await showModal(_);
            },
            icon: const Icon(
              Icons.more_vert_rounded,
              color: Colors.white,
            ),
          ),
        ],
        elevation: 2,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset('assets/openai_logo.jpg'),
        ),
        title: const Text('ChatGPT'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: listChat.length,
                itemBuilder: (_, index) {
                  return ChatWidget(
                    message: listChat[index].msg,
                    chatIndex: listChat[index].chatIndex,
                  );
                },
              ),
            ),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              ),
            ],
            const SizedBox(height: 15),
            Material(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: _focusNode,
                        controller: textEditController,
                        onSubmitted: (value) async {
                          await sendMessage(modelsProvider: modelsProvider);
                        },
                        onChanged: (value) => debugPrint(value),
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Como posso te ajudar',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await sendMessage(modelsProvider: modelsProvider);
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void scrollListToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
    );
  }

  Future<void> sendMessage({required ModelsProvider modelsProvider}) async {
    setState(() {
      _isTyping = true;
      listChat.add(ChatModel(msg: textEditController.text, chatIndex: 0));
      _focusNode.unfocus();
    });
    try {
      listChat.addAll(
        await ApiService().sendMessage(
          msg: textEditController.text,
          modelId: modelsProvider.currentModel,
        ),
      );
      setState(() {});
    } catch (e) {
      // print(e.toString());
    } finally {
      setState(() {
        textEditController.clear();
        scrollListToEnd();
        _isTyping = false;
      });
    }
  }
}
