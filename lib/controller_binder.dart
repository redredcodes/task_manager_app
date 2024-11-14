import 'package:get/get.dart';
import 'package:task_manager_app/ui/controllers/cancelled_task_list_controller.dart';
import 'package:task_manager_app/ui/controllers/completed_task_list_controller.dart';
import 'package:task_manager_app/ui/controllers/new_task_list_controller.dart';
import 'package:task_manager_app/ui/controllers/progress_task_list_controller.dart';
import 'package:task_manager_app/ui/controllers/sign_in-controller.dart';
import 'package:task_manager_app/ui/controllers/task_status_count_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(NewTaskListController());
    Get.put(TaskStatusCountController());
    Get.put(ProgressTaskListController());
    Get.put(CompletedTaskListController());
    Get.put(CancelledTaskListController());
  }

}