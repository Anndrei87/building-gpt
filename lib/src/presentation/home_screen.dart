import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../core/constants/constants.dart';
import '../core/providers/chat_provider.dart';
import '../core/providers/localization_provider.dart';
import '../core/providers/models_provider.dart';
import '../core/widgets/bottom_modal.dart';
import '../core/widgets/chat_widget.dart';
import '../core/widgets/text_custom.dart';

enum LocaleEnum { pt, en }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isTyping = false;
  late TextEditingController textEditController;
  late FocusNode _focusNode;
  late ScrollController _scrollController;
  LocaleEnum? _character = LocaleEnum.pt;

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

  void setLocale(Locale value, LocalizationProvider provider) {
    setState(() {
      provider.changeLocale(value);
    });
  }

  @override
  Widget build(BuildContext _) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    final localizationProvider = Provider.of<LocalizationProvider>(context);

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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: scaffoldbackground,
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/openai_logo.jpg',
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.chooseLanguage,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                RadioListTile<LocaleEnum>(
                  title: const Text('Portugues-BR'),
                  value: LocaleEnum.pt,
                  groupValue: _character,
                  onChanged: (value) {
                    setState(() {
                      setLocale(
                        const Locale.fromSubtags(languageCode: 'pt'),
                        localizationProvider,
                      );
                      _character = value;
                    });
                  },
                ),
                RadioListTile<LocaleEnum>(
                  title: const Text('Inglês'),
                  value: LocaleEnum.en,
                  groupValue: _character,
                  onChanged: (value) {
                    setState(() {
                      setLocale(
                        const Locale.fromSubtags(languageCode: 'en'),
                        localizationProvider,
                      );
                      _character = value;
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: chatProvider.getListChat.length,
                itemBuilder: (_, index) {
                  return ChatWidget(
                    message: chatProvider.getListChat[index].msg,
                    chatIndex: chatProvider.getListChat[index].chatIndex,
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
                          await sendMessage(
                            modelsProvider: modelsProvider,
                            chatProvider: chatProvider,
                          );
                        },
                        decoration: InputDecoration.collapsed(
                          hintText: AppLocalizations.of(context)!.howHelpYou,
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await sendMessage(
                          modelsProvider: modelsProvider,
                          chatProvider: chatProvider,
                        );
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

  Future<void> sendMessage({
    required ModelsProvider modelsProvider,
    required ChatProvider chatProvider,
  }) async {
    final msg = textEditController.text;
    if (msg.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextWidget(
            label: AppLocalizations.of(context)!.pleaseTypeMessage,
          ),
          backgroundColor: Colors.red,
        ),
      );
      _focusNode.unfocus();
      return;
    }
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextWidget(
            label: AppLocalizations.of(context)!.multipleMessage,
          ),
          backgroundColor: Colors.red,
        ),
      );
      _focusNode.unfocus();
      return;
    }

    try {
      setState(() {
        _isTyping = true;
        chatProvider.addUserMessage(msg: msg);
        _focusNode.unfocus();
      });
      await chatProvider.sendMessageAndGetAnswers(
        msg: textEditController.text,
        chosenModelId: modelsProvider.currentModel,
      );
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextWidget(
            label: e.toString(),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        textEditController.clear();
        scrollListToEnd();
        _isTyping = false;
      });
    }
  }
}
