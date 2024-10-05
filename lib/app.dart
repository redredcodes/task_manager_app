import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
        textTheme: const TextTheme(),
        inputDecorationTheme: InputDecorationTheme(
            hintStyle: const TextStyle(),
            labelStyle: const TextStyle(color: Colors.grey),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            filled: true,
            fillColor: Colors.white),
      ),
    );
  }
}
