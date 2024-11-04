import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/controllers/auth_controller.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';
import 'package:task_manager_app/ui/widgets/tm_appbar.dart';
import '../../widgets/custom_text_form_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setUserData;
  }

  void _setUserData() {
    _emailTEController.text = AuthController.userData?.email ?? '';
    _firstNameTEController.text = AuthController.userData?.firstName ?? '';
    _lastNameTEController.text = AuthController.userData?.lastName ?? '';
    _mobileTEController.text = AuthController.userData?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const TMAppBar(
        isProfileScreenOpen: true,
      ),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),

                // update profile headline
                Row(
                  children: [
                    const SizedBox(
                      width: 24,
                    ),
                    Text(
                      'Update Profile',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),

                // photo picker
                buildPhotoPicker(),

                const SizedBox(
                  height: 10,
                ),

                // form field
                Form(
                  child: Column(
                    children: [
                      CustomTextFormField(
                        enabled: false,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailTEController,
                        obscureText: false,
                        hintText: 'Email',
                      ),
                  
                      const SizedBox(height: 10),
                  
                      // pass form field
                      CustomTextFormField(
                        controller: _firstNameTEController,
                        obscureText: true,
                        hintText: 'First Name',
                      ),
                  
                      const SizedBox(height: 10),
                  
                      // pass form field
                      CustomTextFormField(
                        controller: _lastNameTEController,
                        obscureText: true,
                        hintText: 'Last Name',
                      ),
                  
                      const SizedBox(height: 10),
                  
                      // pass form field
                      CustomTextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _mobileTEController,
                        obscureText: true,
                        hintText: 'Mobile',
                      ),
                  
                      const SizedBox(height: 10),
                  
                      // pass form field
                      CustomTextFormField(
                        controller: _passwordTEController,
                        obscureText: false,
                        hintText: 'Password',
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                // the button
                Padding(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPhotoPicker() => Row(
        children: [
          const SizedBox(
            width: 24,
          ),
          Container(
            height: 52,
            width: 265,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Row(
              children: <Widget>[
                Container(
                  height: 52,
                  width: 100,
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5))),
                  alignment: Alignment.center,
                  child: const Text(
                    'Photos',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text('Selected Photo')
              ],
            ),
          ),
        ],
      );

  void _onTapNextButton() {}
}
