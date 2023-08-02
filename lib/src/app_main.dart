import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants/constants.dart';
import 'core/providers/models.provider.dart';
import 'presentation/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: scaffoldbackground,
          appBarTheme: const AppBarTheme(
            color: cardColor,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
