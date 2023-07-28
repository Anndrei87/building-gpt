import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../widgets/drop_down.dart';
import '../widgets/text_custom.dart';

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
      return const Padding(
        padding: EdgeInsets.all(18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: TextWidget(
                label: 'Escolha o modelo:',
                fontSize: 16,
              ),
            ),
            Flexible(
              child: DropDownModelsWidget(),
            )
          ],
        ),
      );
    },
  );
}
