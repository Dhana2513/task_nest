import 'package:flutter/material.dart';
import 'package:task_nest/core/application.dart';
import 'package:task_nest/core/constant/text_style.dart';

import 'presentation/home_screen.dart';

void main() async {
  await Application.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: AppBarTheme(
          color: Colors.deepPurple.shade400,
          titleTextStyle: UITextStyle.title.copyWith(color: Colors.white),
        ),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
