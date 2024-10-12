import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/sign_in_screen.dart';
import 'package:task_manager_app/ui/screens/sign_up_screen.dart';
import 'package:task_manager_app/ui/widgets/custom_text_form_field.dart';
import 'package:task_manager_app/ui/widgets/frosted_glass.dart';
import 'package:task_manager_app/ui/widgets/green_ball.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

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
              height: 520,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 0),

                    // Welcome msg
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 20),
                      child: Text(
                        'Join \nWith Us.',
                        style: textTheme.displaySmall
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),

                    // email & pass form field
                    buildSignUpForm(),
                    const SizedBox(height: 15),

                    // the next button
                    buildNextButton(),

                    const SizedBox(height: 5),

                    buildScrollDownButton(),

                    // password recovery + Signing Up Buttons
                    buildPassRecoverSignUp()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// all builds down here 👇
  Widget buildSignUpForm() {
    return Column(
      children: [
        CustomTextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: TextEditingController(),
          obscureText: false,
          hintText: 'Email',
        ),

        const SizedBox(height: 10),

        // pass form field
        CustomTextFormField(
          controller: TextEditingController(),
          obscureText: true,
          hintText: 'First Name',
        ),

        const SizedBox(height: 10),

        // pass form field
        CustomTextFormField(
          controller: TextEditingController(),
          obscureText: true,
          hintText: 'Last Name',
        ),

        const SizedBox(height: 10),

        // pass form field
        CustomTextFormField(
          keyboardType: TextInputType.phone,
          controller: TextEditingController(),
          obscureText: true,
          hintText: 'Mobile',
        ),

        const SizedBox(height: 10),

        // pass form field
        CustomTextFormField(
          controller: TextEditingController(),
          obscureText: false,
          hintText: 'Password',
        ),
      ],
    );
  }

  // the next button
  Widget buildNextButton() {
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

  Widget buildPassRecoverSignUp() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Have an account?'),
            TextButton(
              onPressed: _onTapSignInButton,
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

  GestureDetector buildScrollDownButton() {
    return GestureDetector(
      onTap: _scrollToBottom,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: ColorFiltered(
              colorFilter:
                  const ColorFilter.mode(Colors.green, BlendMode.srcIn),
              child: Image.asset(
                'assets/images/arrow.png',
                height: 20,
                width: 20,
              )),
          //assets/images/scroll-down.png
        ),
      ),
    );
  }

  // button functionalities
  void _onTapNextButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
    );
  }

  void _onTapSignInButton() {
    Navigator.pop(context);
  }
}
