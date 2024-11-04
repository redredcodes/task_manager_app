import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_app/ui/controllers/auth_controller.dart';
import 'package:task_manager_app/ui/screens/screens%20after%20signing%20in/main_bottom_nav_bar_screen.dart';
import 'package:task_manager_app/ui/screens/sign_in_screen.dart';
import 'package:task_manager_app/ui/utils/assets_path.dart';
import '../widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }
  // the future function
  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    // checking if the user is logged in or not
    await AuthController.getAccessToken();
    if (AuthController.isLoggedIn()){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const MainBottomNavBarScreen()));
    } else {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const SignInScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetsPath.logoSvg,
                width: 125,
              ),
            ],
          ),
        ),
      )
    );
  }
}


