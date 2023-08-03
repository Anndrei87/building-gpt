import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '../providers/localization_provider.dart';

enum LocaleEnum { pt, en }

class DrawerCustom extends StatefulWidget {
  final Function setLocalePt;
  final LocaleEnum localizationProvider;
  final LocalizationProvider provider;
  final Function setLocaleEn;
  const DrawerCustom({
    required this.setLocalePt,
    required this.setLocaleEn,
    required this.localizationProvider,
    required this.provider,
    super.key,
  });

  @override
  State<DrawerCustom> createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                groupValue: widget.localizationProvider,
                onChanged: (value) {
                  setState(() {
                    widget.setLocalePt();
                    widget.provider.setLocale(value!);
                  });
                },
              ),
              RadioListTile<LocaleEnum>(
                title: const Text('Inglês'),
                value: LocaleEnum.en,
                groupValue: widget.localizationProvider,
                onChanged: (value) {
                  setState(() {
                    widget.setLocaleEn();
                    widget.provider.setLocale(value!);
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
