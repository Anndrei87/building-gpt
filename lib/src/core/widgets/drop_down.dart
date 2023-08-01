import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/constants.dart';
import '../models/modelsmodel.dart';
import '../services/api_service.dart';
import 'text_custom.dart';

class DropDownModelsWidget extends StatefulWidget {
  const DropDownModelsWidget({super.key});

  @override
  State<DropDownModelsWidget> createState() => _DropDownModelsWidgetState();
}

class _DropDownModelsWidgetState extends State<DropDownModelsWidget> {
  final apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    var currentModel = 'text-davinci-edit-001';
    return FutureBuilder<List<ModelsModel>>(
      future: apiService.getModels(),
      builder: (_, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: TextWidget(label: snapshot.error.toString()),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return snapshot.data == null || snapshot.data!.isEmpty
              ? const SizedBox.shrink()
              : FittedBox(
                  child: DropdownButton(
                    dropdownColor: scaffoldbackground,
                    iconEnabledColor: Colors.white,
                    items: List<DropdownMenuItem<String>>.generate(
                      snapshot.data!.length,
                      (index) => DropdownMenuItem(
                        value: snapshot.data![index].id,
                        child: TextWidget(
                          label: snapshot.data![index].id,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    value: currentModel,
                    onChanged: (value) {
                      setState(() {
                        currentModel = value.toString();
                      });
                    },
                  ),
                );
        }
        return const FittedBox(
          child: SpinKitFadingCircle(
            color: Colors.lightBlue,
            size: 30,
          ),
        );
      },
    );
  }
}

// DropdownButton(
//       dropdownColor: scaffoldbackground,
//       iconEnabledColor: Colors.white,
//       items: getModelsItem,
//       value: currentModel,
//       onChanged: (value) {
//         setState(() {
//           currentModel = value.toString();
//         });
//       },
//     );