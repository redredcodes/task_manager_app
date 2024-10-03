import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/account%20reovery%20screens/forgot_pass_otp_screen.dart';
import 'package:task_manager_app/ui/screens/sign_in_screen.dart';
import 'package:task_manager_app/ui/screens/sign_up_screen.dart';
import 'package:task_manager_app/ui/widgets/custom_text_form_field.dart';
import 'package:task_manager_app/ui/widgets/frosted_glass.dart';
import 'package:task_manager_app/ui/widgets/green_ball.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';

class AccountRecoveryScreen extends StatefulWidget {
  const AccountRecoveryScreen({super.key});

  @override
  State<AccountRecoveryScreen> createState() => _AccountRecoveryScreenState();
}

class _AccountRecoveryScreenState extends State<AccountRecoveryScreen> {
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
            height: 500,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 70),

                  // Welcome msg
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Your \nEmail Address',
                      style: textTheme.displaySmall
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'A 6 digits verification code will be sent to your email address',
                      style: textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.w400, color: Colors.grey[800]),
                    ),
                  ),


                  // email & pass form field
                  buildVerifyEmailForm(),
                  const SizedBox(height: 15),

                  // the next button
                  buildNextButton(),
                  const SizedBox(
                    height: 30,
                  ),

                  // password recovery + Signing Up Buttons
                  buildSignInButton()
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }






// all builds down here 👇
  Widget buildVerifyEmailForm() {
    return Column(
                  children: [
                    CustomTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: TextEditingController(),
                      obscureText: false, hintText: 'Email',
                    ),
                    const SizedBox(height: 10),
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
  Column buildSignInButton() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Have an account?'),
            TextButton(
              onPressed: _onTapSignIn,
              child: Text(
                'Sign In',
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
  void _onTapSignIn () {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignInScreen(),),);
  }
  
  void _onTapNextButton () {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> const ForgotPassOtpScreen()));
  }



 }
