import 'package:flutter/material.dart';

import '../constants/constants.dart';

class DropDownModelsWidget extends StatefulWidget {
  const DropDownModelsWidget({super.key});

  @override
  State<DropDownModelsWidget> createState() => _DropDownModelsWidgetState();
}

class _DropDownModelsWidgetState extends State<DropDownModelsWidget> {
  @override
  Widget build(BuildContext context) {
    var currentModel = 'Model1';
    return DropdownButton(
      dropdownColor: scaffoldbackground,
      iconEnabledColor: Colors.white,
      items: getModelsItem,
      value: currentModel,
      onChanged: (value) {
        setState(() {
          currentModel = value.toString();
        });
      },
    );
  }
}
