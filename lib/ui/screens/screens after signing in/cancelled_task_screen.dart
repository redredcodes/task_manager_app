import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager_app/data/models/task_list_model.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/ui/controllers/cancelled_task_list_controller.dart';
import 'package:task_manager_app/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';
import '../../utils/assets_path.dart';
import '../../widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  void initState() {
    super.initState();
    _getCancelledTaskList();
  }

  // bool _getCancelledTaskInProgress = false;
  // List<TaskModel> _cancelledTaskList = [];
  final CancelledTaskListController _cancelledTaskListController = Get.find<CancelledTaskListController>();
  
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.green,
      onRefresh: () async {
        _getCancelledTaskList();
      },
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8,),
            Expanded(
              child: GetBuilder<CancelledTaskListController>(
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
                            onRefreshList: _getCancelledTaskList);
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

  Future<void> _getCancelledTaskList() async {
    final bool result = await _cancelledTaskListController.getCancelledTaskList();
    if (result == false) {
      showSnackBarMessage(context, _cancelledTaskListController.errorMessage!, true);
    }
  }
}
