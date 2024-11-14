import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:task_manager_app/controller_binder.dart';
import 'package:task_manager_app/ui/screens/screens%20after%20signing%20in/main_bottom_nav_bar_screen.dart';
import 'package:task_manager_app/ui/screens/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManagerApp.navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.name,
      routes: {
        SplashScreen.name : (context) => const SplashScreen(),
        MainBottomNavBarScreen.name : (context) => const MainBottomNavBarScreen(),
      },
      initialBinding: ControllerBinder(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white
          )
        ),
        scaffoldBackgroundColor: Colors.grey[200],
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
