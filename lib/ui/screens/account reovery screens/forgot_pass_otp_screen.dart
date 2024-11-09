import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/screens/account%20reovery%20screens/set_new_pass_screen.dart';
import 'package:task_manager_app/ui/screens/sign_in_screen.dart';
import 'package:task_manager_app/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/frosted_glass.dart';
import 'package:task_manager_app/ui/widgets/green_ball.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';

class ForgotPassOtpScreen extends StatefulWidget {
  const ForgotPassOtpScreen({super.key, required this.verifyEmail});

  final String verifyEmail;

  @override
  State<ForgotPassOtpScreen> createState() => _ForgotPassOtpScreenState();
}

class _ForgotPassOtpScreenState extends State<ForgotPassOtpScreen> {
  bool _verifyButtonInProgressIndicator = false;
  final TextEditingController _pinCodeTEController = TextEditingController();

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
                      style: textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w400, color: Colors.grey[800]),
                    ),
                  ),

                  // email & pass form field
                  Center(
                    child: PinCodeTextField(
                      controller: _pinCodeTEController,
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
        child: Visibility(
          visible: !_verifyButtonInProgressIndicator,
          replacement: const CenteredCircularProgressIndicator(),
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

  // button functionalities 👇
  Future<void> _onTapVerifyButton() async {
    setState(() {
      _verifyButtonInProgressIndicator = true;
    });

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.recoverVerifyOtp(widget.verifyEmail, _pinCodeTEController.text),
    );
    setState(() {
      _verifyButtonInProgressIndicator = false;
    });

    if (response.isSuccess) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SetNewPassScreen(
            email: widget.verifyEmail,
            otp: _pinCodeTEController.text,
          ),
        ),
      );
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  // Future<void> _onTapVerifyButton() async {
  //   setState(() {
  //     _verifyButtonInProgressIndicator = true;
  //   });
  //
  //   final NetworkResponse response = await NetworkCaller.getRequest(
  //     url: Urls.recoverVerifyOtp(_pinCodeTEController.text),
  //   );
  //   setState(() {
  //     _verifyButtonInProgressIndicator = false;
  //   });
  //
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const SetNewPassScreen(),
  //       ),
  //     );
  // }

  void _onTapSignIn() {
    // this will remove all the previous screens until the one we choose and take us there
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
      (_) => false,
    );
  }
}
