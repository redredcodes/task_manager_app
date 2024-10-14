import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/custom_text_form_field.dart';
import 'package:task_manager_app/ui/widgets/frosted_glass.dart';
import 'package:task_manager_app/ui/widgets/green_ball.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';

import '../../data/utils/urls.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // the scroll controller
  final ScrollController _scrollController = ScrollController();

  // the global key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // the Text Editing controllers
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  bool _inProgress = false;

  // the scroll down arrow function...
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

                    // signup text form fields
                    buildSignUpForm(),
                    const SizedBox(height: 15),

                    // the next button
                    buildNextButton(),

                    const SizedBox(height: 5),

                    buildScrollDownButton(),

                    // password recovery + Signing Up Buttons
                    buildPassRecoverSignUp(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// all builds down here 👇

  // sign up form
  Widget buildSignUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // email form field
          CustomTextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _emailTEController,
            obscureText: false,
            hintText: 'Email',
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter a valid Email';
              }
              return null; // If the if condition is false (i.e., the input is not null and not empty), the validator function returns null. And returning null from a validator function means that the input is considered valid, and no error message should be displayed.
            },
          ),

          const SizedBox(height: 10),

          // first name form field
          CustomTextFormField(
            controller: _firstNameTEController,
            obscureText: false,
            hintText: 'First Name',
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter Your First Name';
              }
              return null; // If the if condition is false (i.e., the input is not null and not empty), the validator function returns null. And returning null from a validator function means that the input is considered valid, and no error message should be displayed.
            },
          ),

          const SizedBox(height: 10),

          // last name form field
          CustomTextFormField(
            controller: _lastNameTEController,
            obscureText: false,
            hintText: 'Last Name',
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter Your Last Name';
              }
              return null; // If the if condition is false (i.e., the input is not null and not empty), the validator function returns null. And returning null from a validator function means that the input is considered valid, and no error message should be displayed.
            },
          ),

          const SizedBox(height: 10),

          // mobile form field
          CustomTextFormField(
            keyboardType: TextInputType.phone,
            controller: _mobileTEController,
            obscureText: false,
            hintText: 'Mobile',
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter a valid Mobile Number';
              }
              return null; // If the if condition is false (i.e., the input is not null and not empty), the validator function returns null. And returning null from a validator function means that the input is considered valid, and no error message should be displayed.
            },
          ),

          const SizedBox(height: 10),

          // pass form field
          CustomTextFormField(
            controller: _passwordTEController,
            obscureText: false,
            hintText: 'Password',
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Create a strong password to proceed';
              } else if (value!.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              return null; // If the if condition is false (i.e., the input is not null and not empty), the validator function returns null. And returning null from a validator function means that the input is considered valid, and no error message should be displayed.
            },
          ),
        ],
      ),
    );
  }

  // the next button
  Widget buildNextButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        width: double.infinity,
        child: Visibility(
          visible: !_inProgress,
          replacement: const CenteredCircularProgressIndicator(),
          child: ElevatedButton(
            onPressed: _onTapNextButton,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[500],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),),),
            child: const Icon(Icons.navigate_next_rounded),
          ),
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
            colorFilter: const ColorFilter.mode(Colors.green, BlendMode.srcIn),
            child: Image.asset(
              'assets/images/arrow.png',
              height: 20,
              width: 20,
            ),
          ),
          //assets/images/scroll-down.png
        ),
      ),
    );
  }

  /// button functionalities 👇

  // next button function
  void _onTapNextButton() {
    if (_formKey.currentState!.validate()) {
      _signUp();
    }
  }

  Future<void> _signUp() async {
    setState(() {
      _inProgress = true;
    });

    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
      "password": _passwordTEController.text
    };

    NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.registration,
        body: requestBody
    );
    setState(() {
      _inProgress = false;
    });
    if (response.isSuccess) {
      showSnackBarMessage(context, 'Registration successful, you\'re in!',);
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  // sign in button function
  void _onTapSignInButton() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
