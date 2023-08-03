class ChatModel {
  final String msg;
  final int chatIndex;

  ChatModel({required this.msg, required this.chatIndex});

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        msg: json['msg'] as String,
        chatIndex: json['chatIndex'] as int,
      );

  static List<ChatModel> createListChat(
    List<dynamic> getList, {
    required bool isRealGPT,
  }) {
    return isRealGPT
        ? List<ChatModel>.generate(
            getList.length,
            (index) {
              return ChatModel(
                msg: ((getList[index] as Map)['message'] as Map)['content']
                    .toString(),
                chatIndex: 1,
              );
            },
          )
        : List.generate(
            getList.length,
            (index) => ChatModel(
              msg: (getList[index] as Map)['text'].toString(),
              chatIndex: 1,
            ),
          );
  }
}
