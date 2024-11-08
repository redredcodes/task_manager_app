import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/models/task_list_model.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';

import '../../../data/models/task_model.dart';
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

  bool _getCompletedTaskInProgress = false;
  List<TaskModel> _completedTaskList = [];
  
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
              child: Visibility(
                visible: !_getCompletedTaskInProgress,
                replacement: const CenteredCircularProgressIndicator(),
                child: _completedTaskList.isEmpty ?
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
                                itemCount: _completedTaskList.length,
                                itemBuilder: (context, index) {
                    return Column(
                      children: [
                        TaskCard(
                          taskModel: _completedTaskList[index],
                          onRefreshList: _getCompletedTaskList,
                        ),
                      ],
                    );
                                },
                                separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 8);
                                },
                              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Future<void> _getCompletedTaskList() async {
    _completedTaskList.clear();
    _getCompletedTaskInProgress = true;
    setState(() {});
    
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.completedTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);
      _completedTaskList = taskListModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getCompletedTaskInProgress = false;
    setState(() {});
  }
}
