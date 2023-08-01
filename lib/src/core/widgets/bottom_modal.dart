import 'package:flutter/material.dart';

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
      return const Padding(
        padding: EdgeInsets.all(18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: TextWidget(
                label: 'Chosen model:',
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
