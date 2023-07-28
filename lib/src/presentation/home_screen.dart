import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../core/constants/constants.dart';
import '../core/widgets/chat_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _isTyping = true;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
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
                    message: ConstantsAplication.chatMessages[index]['msg']
                        .toString(),
                    chatIndex: int.parse(
                      ConstantsAplication.chatMessages[index]['chatIndex']
                          .toString(),
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
              const SizedBox(height: 15),
              Material(
                color: ConstantsAplication.cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                        onPressed: () {},
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
