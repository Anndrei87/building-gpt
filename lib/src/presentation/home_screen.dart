import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../core/constants/constants.dart';
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
  TextEditingController? textEditController;

  @override
  void initState() {
    textEditController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditController!.dispose();
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
                itemCount: 6,
                itemBuilder: (_, index) {
                  return ChatWidget(
                    message: chatMessages[index]['msg'].toString(),
                    chatIndex: int.parse(
                      chatMessages[index]['chatIndex'].toString(),
                    ),
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
                        controller: textEditController,
                        onSubmitted: (value) {},
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Como posso te ajudar',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        setState(() {
                          _isTyping = true;
                        });
                        try {
                          final list = await ApiService().sendMessage(
                            msg: textEditController!.text,
                            modelId: modelsProvider.currentModel,
                          );
                          debugPrint(list[0].msg);
                        } catch (e) {
                          // print(e.toString());
                        } finally {
                          setState(() {
                            _isTyping = false;
                          });
                        }
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
}
