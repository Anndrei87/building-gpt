import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'text_custom.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    required this.message,
    required this.chatIndex,
    super.key,
  });

  final String message;
  final int chatIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex == 0
              ? ConstantsAplication.scaffoldbackground
              : ConstantsAplication.cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  chatIndex == 0 ? 'assets/person.png' : 'assets/chat_logo.png',
                  width: 30,
                  height: 30,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextWidget(label: message),
                ),
                // ignore: prefer_if_elements_to_conditional_expressions
                chatIndex == 0
                    ? const SizedBox.shrink()
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.thumb_up_alt_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.thumb_down_alt_outlined,
                            color: Colors.white,
                          )
                        ],
                      ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
