import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/models/task_list_model.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';
import '../../../data/utils/urls.dart';
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

  bool _getCancelledTaskInProgress = false;
  List<TaskModel> _cancelledTaskList = [];
  
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.green,
      onRefresh: () async {
        _getCancelledTaskList();
      },
      child: SafeArea(
        child: Visibility(
          visible: !_getCancelledTaskInProgress,
          replacement: const CenteredCircularProgressIndicator(),
          child: _cancelledTaskList.isEmpty ?
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
            itemCount: _cancelledTaskList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                  taskModel: _cancelledTaskList[index],
                  onRefreshList: _getCancelledTaskList);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 8);
            },
          ),
        ),
      ),
    );
  }

  Future<void> _getCancelledTaskList() async {
    _cancelledTaskList.clear();
    _getCancelledTaskInProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.cancelledTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);
      _cancelledTaskList = taskListModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getCancelledTaskInProgress = false;
    setState(() {});
  }
}
