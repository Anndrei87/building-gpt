import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../constants/constants.dart';
import 'drop_down.dart';
import 'text_custom.dart';

Future<dynamic> showModal(BuildContext _) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    backgroundColor: scaffoldbackground,
    context: _,
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: TextWidget(
                label: AppLocalizations.of(_)!.chooseModel,
                fontSize: 15,
              ),
            ),
            const Flexible(
              flex: 2,
              child: DropDownModelsWidget(),
            )
          ],
        ),
      );
    },
  );
}
