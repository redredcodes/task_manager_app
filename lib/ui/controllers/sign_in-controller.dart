import 'package:get/get.dart';

import '../../data/models/login_model.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import 'auth_controller.dart';

// So in this class, we are gonna separate all the business logics including api callings from the Sign In Screen here. So the SignIn screen only has to deal with the ui part.
// One responsibility to take as per in 'S' from SOLID. Single Responsibility Principle
// [these comments are only here for my understanding and note taking purpose, it's not done as a practice]
class SignInController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;


  Future<bool> signIn(String email, String password) async {
    bool isSuccess = false;
      _inProgress = true;
      update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
    };

    final NetworkResponse response =
    await NetworkCaller.postRequest(url: Urls.signIn, body: requestBody);

    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.saveAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.data!);
      isSuccess = true;
    } else {
      // showSnackBarMessage(context, response.errorMessage, true); // showing snackBar is actually part of the ui. So we are gonna give this task to the ui screen instead.
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

}