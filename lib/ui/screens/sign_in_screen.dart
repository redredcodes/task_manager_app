import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/account%20reovery%20screens/forgot_pass_account_recovery_screen.dart';
import 'package:task_manager_app/ui/screens/screens%20after%20signing%20in/main_bottom_nav_bar_screen.dart';
import 'package:task_manager_app/ui/screens/sign_up_screen.dart';
import 'package:task_manager_app/ui/widgets/custom_text_form_field.dart';
import 'package:task_manager_app/ui/widgets/frosted_glass.dart';
import 'package:task_manager_app/ui/widgets/green_ball.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScreenBackground(
          child: Stack(
        children: [
          // the bg green ball
          const Center(
            child: GreenBall(),
          ),

          // the glass card
          FrostedGlass(
            width: 300,
            height: 550,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 70),

                  // Welcome msg
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Get Started With',
                      style: textTheme.displaySmall
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),

                  // email & pass form field
                  buildEmailPassColumn(),
                  const SizedBox(height: 15),

                  // the next button
                  buildNextButton(),
                  const SizedBox(
                    height: 45,
                  ),

                  // password recovery + Signing Up Buttons
                  buildPassRecoverSignUp()
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }






// all builds down here 👇
  Widget buildEmailPassColumn() {
    return Column(
                  children: [
                    CustomTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: TextEditingController(),
                      obscureText: false, hintText: 'Email',
                    ),
                    const SizedBox(height: 10),

                    // pass form field
                    CustomTextFormField(
                      hintText: 'Password',
                      controller: TextEditingController(),
                      obscureText: true,
                    ),
                  ],
                );
  }
  Padding buildNextButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _onTapNextButton,
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[500],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
          child: const Icon(Icons.navigate_next_rounded),
        ),
      ),
    );
  }
  Column buildPassRecoverSignUp() {
    return Column( mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: _onTapPassWentBlackHole,
              child: Text(
                'Password went to Black hole?',
                style:
                TextStyle(color: Colors.grey[700], fontSize: 13),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Don\'t have an account?'),
            TextButton(
              onPressed: _onTapSignUp,
              child: Text(
                'Sign Up',
                style: TextStyle(
                    color: Colors.green[500], fontSize: 13),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // button functionalities
  void _onTapPassWentBlackHole () {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> const AccountRecoveryScreen()));
  }

  void _onTapSignUp () {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignUpScreen(),),);
  }

  void _onTapNextButton () {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LadingPage()));
  }


}
