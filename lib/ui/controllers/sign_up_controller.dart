import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class SignUpController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  String? _errorMessage;
  String? get errorMessage =>  _errorMessage;

  Future<bool> signUp(String email, String firstName, String lastName, String mobile, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
    };

    NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.registration,
        body: requestBody
    );
    _inProgress = false;
    update();

    if (response.isSuccess) {
      return true;
    } else {
      _errorMessage = response.errorMessage;
      // return false;
    }
    return isSuccess;
  }
}