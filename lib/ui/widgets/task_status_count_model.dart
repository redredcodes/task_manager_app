import 'package:task_manager_app/ui/widgets/task_status_model.dart';

class TaskStatusCountModel {
  String? status;
  List<TaskStatusModel>? taskStatusCountList;

  TaskStatusCountModel({this.status, this.taskStatusCountList});

  TaskStatusCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskStatusCountList = <TaskStatusModel>[];
      json['data'].forEach((v) {
        taskStatusCountList!.add(TaskStatusModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (taskStatusCountList != null) {
      data['data'] = taskStatusCountList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


