import 'package:get/get.dart';
import 'package:task_manager_app/ui/widgets/task_status_model.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/task_status_count_model.dart';

class TaskStatusCountController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  List<TaskStatusModel> _taskStatusCountList = [];
  List<TaskStatusModel> get taskStatusCountList => _taskStatusCountList;

  Future<bool> getTaskStatusCount() async {
    bool isSuccess = false;
    _taskStatusCountList.clear();
    _inProgress = true;
    update();

    // the api call
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.taskStatusCountList);
    if (response.isSuccess) {
      final TaskStatusCountModel taskStatusCountModel =
      TaskStatusCountModel.fromJson(response.responseData);
      _taskStatusCountList = taskStatusCountModel.taskStatusCountList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    //_scrollToBottom;
    update();

    return isSuccess;
  }
}