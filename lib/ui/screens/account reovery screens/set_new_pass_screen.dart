import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/sign_in_screen.dart';
import 'package:task_manager_app/ui/widgets/custom_text_form_field.dart';
import 'package:task_manager_app/ui/widgets/frosted_glass.dart';
import 'package:task_manager_app/ui/widgets/green_ball.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';

class SetNewPassScreen extends StatefulWidget {
  const SetNewPassScreen({super.key});

  @override
  State<SetNewPassScreen> createState() => _AccountRecoveryScreenState();
}

class _AccountRecoveryScreenState extends State<SetNewPassScreen> {
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
                  const SizedBox(height: 35),

                  // Welcome msg
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                    child: Text(
                      'Set \nPassword',
                      style: textTheme.displaySmall
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),

                  // the scribble arrow icon
                  Padding(
                    padding: const EdgeInsets.symmetric(),
                    child: Image.asset(
                      'assets/images/scribble.png',
                      height: 60,
                      width: 60,
                    ),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                    child: Text(
                      'Password should be minimum 8 characters with Letters and Numbers Combination',
                      style: textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w400, color: Colors.grey[800]),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // email & pass form field
                  buildVerifyEmailForm(),
                  const SizedBox(height: 15),

                  // the next button
                  buildConfirmButton(),
                  const SizedBox(
                    height: 5,
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
          controller: TextEditingController(),
          obscureText: true,
          hintText: 'New Password',
        ),
        const SizedBox(height: 10),
        // pass form field
        CustomTextFormField(
          controller: TextEditingController(),
          obscureText: true, hintText: 'Confirm Password',
        ),
      ],
    );
  }

  Padding buildConfirmButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _onTapConfirmButton,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[500],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text(
            'Confirm',
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
                style: TextStyle(color: Colors.green[500], fontSize: 13),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // button functionalities
  void _onTapSignIn() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
    );
  }

  void _onTapConfirmButton() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
        content: FrostedGlass(
          width: double.infinity,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/correct.png',
                height: 15,
                width: 15,
              ),
              const SizedBox(
                width: 5,
              ),
              const Text('Password reset successful!'),
            ],
          ),
        ),
      ),
    );
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const SignInScreen()));
    });
  }
}
