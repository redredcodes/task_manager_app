import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app/ui/screens/account%20reovery%20screens/set_new_pass_screen.dart';
import 'package:task_manager_app/ui/screens/sign_in_screen.dart';
import 'package:task_manager_app/ui/screens/sign_up_screen.dart';
import 'package:task_manager_app/ui/widgets/custom_text_form_field.dart';
import 'package:task_manager_app/ui/widgets/frosted_glass.dart';
import 'package:task_manager_app/ui/widgets/green_ball.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';

class ForgotPassOtpScreen extends StatefulWidget {
  const ForgotPassOtpScreen({super.key});

  @override
  State<ForgotPassOtpScreen> createState() => _ForgotPassOtpScreenState();
}

class _ForgotPassOtpScreenState extends State<ForgotPassOtpScreen> {
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

                  // user instruction msg
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Pin \nVerification',
                      style: textTheme.displaySmall
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'A 6 digits verification code has been sent to your email address',
                      style: textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.w400, color: Colors.grey[800]),
                    ),
                  ),


                  // email & pass form field
                  Center(
                    child: PinCodeTextField(
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                        selectedColor: Colors.green,
                        inactiveColor: Colors.white,

                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      backgroundColor: Colors.transparent,
                      enableActiveFill: true,
                      appContext: context,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // the next button
                  buildVerifyButton(),
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

  Padding buildVerifyButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _onTapVerifyButton,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[500],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text(
            'Verify',
            style: TextStyle(letterSpacing: 1),
          ),
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

  // button functionalities 👇
  void _onTapVerifyButton () {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> const SetNewPassScreen()));
  }

  void _onTapSignIn () {
    // this will remove all the previous screens until the one we choose and take us there
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const SignInScreen()), (_)=> false);
  }
  




 }
