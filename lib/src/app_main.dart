import 'package:flutter/material.dart';

import 'core/constants/constants.dart';
import 'presentation/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: ConstantColor.scaffoldbackground,
        appBarTheme: const AppBarTheme(
          color: ConstantColor.cardColor,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
