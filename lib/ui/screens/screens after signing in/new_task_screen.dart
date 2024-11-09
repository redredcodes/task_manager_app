import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';
import 'package:task_manager_app/ui/widgets/task_status_count_model.dart';
import 'package:task_manager_app/ui/widgets/task_status_model.dart';
import '../../../data/models/task_list_model.dart';
import '../../utils/assets_path.dart';
import '../../widgets/task_card.dart';
import '../../widgets/task_summary_card.dart';
import 'add_new_task_screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  //final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _getNewTaskList();
    _getNewTaskStatusCount();
  }

  // void _scrollToBottom() {
  //   if (_scrollController.hasClients) {
  //     _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  //   }
  // }

  bool _getNewTasksListInProgress = false;
  bool _getTasksStatusCountListInProgress = false;
  List<TaskModel> _newTaskList = [];
  List<TaskStatusModel> _taskStatusCountList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: RefreshIndicator(
        color: Colors.green,
        onRefresh: () async {
          _getNewTaskList();
          _getNewTaskStatusCount();
        },
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              // the top scrollable row which shows total task statuses
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: buildSummarySection(),
              ),

              const SizedBox(
                height: 8,
              ),

              // all tasks list
              Expanded(
                child: Visibility(
                  visible: !_getNewTasksListInProgress,
                  replacement: const CenteredCircularProgressIndicator(),
                  child: _newTaskList.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AssetsPath.emptyTask2,
                              width: 150,
                            ),
                            const Center(
                              child: Text(
                                'No tasks to show!',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 20),
                              ),
                            ),
                          ],
                        )
                      : ListView.separated(
                          // reverse: true,
                          // controller: _scrollController,
                          itemCount: _newTaskList.length,
                          itemBuilder: (context, index) {
                            return TaskCard(
                                taskModel: _newTaskList[index],
                                onRefreshList: _getNewTaskList);
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[500],
        foregroundColor: Colors.white,
        onPressed: onTapFAB,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildSummarySection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _getTaskSummaryCardList(),
      ),
    );
  }

  List<TaskSummaryCard> _getTaskSummaryCardList() {
    List<TaskSummaryCard> taskSummaryCardList = [];
    for (TaskStatusModel t in _taskStatusCountList) {
      taskSummaryCardList
          .add(TaskSummaryCard(taskStatus: t.sId!, taskCount: t.sum!));
    }
    return taskSummaryCardList;
  }

  // Future<void> onTapFAB() async {
  //   final bool? shouldRefresh = await Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => const AddNewTaskScreen()));
  //   if (shouldRefresh == true) {
  //     _getNewTaskList();
  //   }
  // }

  Future<void> onTapFAB() async {
    final bool? shouldRefresh = await showModalBottomSheet(
      isScrollControlled: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))
        ),
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              left: 8,
              right: 8,
              top: 8,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height, // * 0.99,
                ),
                child: const AddNewTaskScreen(),
              ),
            ),
          );
        },
    );
    if (shouldRefresh == true) {
      _getNewTaskList();
      _getNewTaskStatusCount();
    }
  }

  Future<void> _getNewTaskList() async {
    _newTaskList.clear();
    _getNewTasksListInProgress = true;
    setState(() {});

    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.newTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _newTaskList = taskListModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getNewTasksListInProgress = false;
    // _scrollToBottom;
    setState(() {});
  }

  Future<void> _getNewTaskStatusCount() async {
    _taskStatusCountList.clear();
    _getTasksStatusCountListInProgress = true;
    setState(() {});
    // the api call
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.taskStatusCountList);
    if (response.isSuccess) {
      final TaskStatusCountModel taskStatusCountModel =
          TaskStatusCountModel.fromJson(response.responseData);
      _taskStatusCountList = taskStatusCountModel.taskStatusCountList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getNewTasksListInProgress = false;
    // _scrollToBottom;
    setState(() {});
  }
}
