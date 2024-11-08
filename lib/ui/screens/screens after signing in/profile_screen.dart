import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/models/user_model.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/controllers/auth_controller.dart';
import 'package:task_manager_app/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  XFile? _selectedImage;

  bool _updateProfileInProgress = false;

  @override
  void initState() {
    super.initState();
    _setUserData();
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                Center(child: buildPhotoPicker()),

                const SizedBox(
                  height: 10,
                ),

                // form field
                Form(
                  key: _formKey,
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

                      // first name form field
                      CustomTextFormField(
                        controller: _firstNameTEController,
                        obscureText: false,
                        hintText: 'First Name',
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Enter your First Name';
                          }
                        },
                      ),

                      const SizedBox(height: 10),

                      // last name form field
                      CustomTextFormField(
                        controller: _lastNameTEController,
                        obscureText: false,
                        hintText: 'Last Name',
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Enter your Last Name';
                          }
                          return null;
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
                          if (value?.trim().isEmpty ?? true) {
                            return 'Enter your Mobile No.';
                          }
                          return null;
                        },
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
                Visibility(
                  visible: _updateProfileInProgress == false,
                  replacement: const CenteredCircularProgressIndicator(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _onTapNextButton,
                        //     () {
                        //   if (_formKey.currentState!.validate()) {
                        //     _updateProfile;
                        //   }
                        // },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[500],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text('Save Updates'),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // photo picker function
  Widget buildPhotoPicker() => Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey.shade300,
            backgroundImage: _selectedImage != null
                ? FileImage(
                    File(_selectedImage!.path),
                  )
                : null,
          ),
          Positioned(
            bottom: 0, // Position it at the bottom
            right: 0, // Position it at the right
            child: GestureDetector(
              onTap: _pickImage,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      );

  String _getSelectedPhotoTitle() {
    if (_selectedImage != null) {
      return _selectedImage!.name;
    }
    return 'Selected Photo';
  }

  void _onTapNextButton() {
    if (_formKey.currentState!.validate()) {
      _updateProfile();
    }
  }

  Future<void> _updateProfile() async {
    _updateProfileInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
    };

    if (_passwordTEController.text.isNotEmpty) {
      requestBody['password'] = _passwordTEController.text;
    }

    // encoding the image file in base64 & from base64 to String
    if (_selectedImage != null) {
      List<int> imageBytes = await _selectedImage!.readAsBytes();
      String convertedImage = base64Encode(imageBytes);
      requestBody['photo'] = convertedImage;
    }

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.updateProfile,
      body: requestBody,
    );

    _updateProfileInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      UserModel userModel = UserModel.fromJson(requestBody);
      AuthController.saveUserData(userModel);
      showSnackBarMessage(context, 'Profile has been updated');
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  Future<void> _pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _selectedImage = pickedImage;
      setState(() {});
    }
  }
}
