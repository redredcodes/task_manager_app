import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/controllers/completed_task_list_controller.dart';
import 'package:task_manager_app/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';

import '../../utils/assets_path.dart';
import '../../widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {

  @override
  void initState() {
    super.initState();
    _getCompletedTaskList();
  }

  // bool _getCompletedTaskInProgress = false;
  // List<TaskModel> _completedTaskList = [];
  final CompletedTaskListController _completedTaskListController = Get.find<CompletedTaskListController>();
  
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.green,
      onRefresh: () async {
        _getCompletedTaskList();
      },
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8,),
            Expanded(
              child: GetBuilder<CompletedTaskListController>(
                builder: (controller) {
                  return Visibility(
                    visible: !controller.inProgress,
                    replacement: const CenteredCircularProgressIndicator(),
                    child: controller.taskList.isEmpty ?
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AssetsPath.emptyTask2, width: 150,),
                        const Center(
                          child: Text('No tasks to show!', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
                        ),
                      ],
                    )
                        : ListView.separated(
                                    itemCount: controller.taskList.length,
                                    itemBuilder: (context, index) {
                        return Column(
                          children: [
                            TaskCard(
                              taskModel: controller.taskList[index],
                              onRefreshList: _getCompletedTaskList,
                            ),
                          ],
                        );
                                    },
                                    separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 8);
                                    },
                                  ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Future<void> _getCompletedTaskList() async {
    final bool result = await _completedTaskListController.getCompletedTaskList();

    if (result == false) {
      showSnackBarMessage(context, _completedTaskListController.errorMessage!, true);
    }
  }
}
