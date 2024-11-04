import 'package:task_manager_app/data/models/task_model.dart'; // Import the TaskModel class.

class TaskListModel {
  // Properties of TaskListModel
  String? status; // The overall status of the task list (e.g., 'success', 'failed').
  List<TaskModel>? taskList; // A list of TaskModel objects representing the tasks.

  // Constructor to initialize the TaskListModel with optional values.
  TaskListModel({this.status, this.taskList});

  // Named constructor to create a TaskListModel from a JSON object.
  // This is especially useful when you get a JSON response that contains multiple tasks.
  TaskListModel.fromJson(Map<String, dynamic> json) {
    // We extract the 'status' field from the JSON.
    status = json['status'];

    // If the 'data' field in the JSON is not null, we convert it into a list of TaskModel objects.
    if (json['data'] != null) {
      taskList = <TaskModel>[]; // Initialize an empty list of TaskModel objects.

      // Loop over each item in the 'data' array from JSON.
      json['data'].forEach((v) {
        // For each item (v), create a TaskModel from JSON and add it to taskList.
        taskList!.add(new TaskModel.fromJson(v));
      });
    }
  }
// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['status'] = this.status;
//   if (this.data != null) {
//     data['data'] = this.data!.map((v) => v.toJson()).toList();
//   }
//   return data;
// }
}
