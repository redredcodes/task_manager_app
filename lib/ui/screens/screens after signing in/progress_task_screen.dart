import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/controllers/progress_task_list_controller.dart';
import 'package:task_manager_app/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';
import '../../utils/assets_path.dart';
import '../../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  void initState() {
    super.initState();
    _getProgressTaskList();
  }

  // bool _getProgressTaskInProgress = false;
  // List<TaskModel> _progressTaskList = [];
  final ProgressTaskListController _progressTaskListController = Get.find<ProgressTaskListController>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.green,
      onRefresh: () async {
        _getProgressTaskList();
      },
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8,),
            Expanded(
              child: GetBuilder<ProgressTaskListController>(
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
                        return TaskCard(
                            taskModel: controller.taskList[index],
                            onRefreshList: _getProgressTaskList);
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

  Future<void> _getProgressTaskList() async {
    final bool result = await _progressTaskListController.getProgressTaskList();

    if (result == false) {
      showSnackBarMessage(context, _progressTaskListController.errorMessage!, true);
    }
  }
}
