import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';
import '../../data/models/task_model.dart';
import '../../data/utils/urls.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskModel, required this.onRefreshList,
  });

  final TaskModel taskModel;
  final VoidCallback onRefreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  String _selectedStatus = '';
  bool _changeStatusInProgress = false;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.taskModel.status!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // task name
            Text(
              widget.taskModel.title ?? '',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),

            // description of the task
            Text(
              widget.taskModel.description ?? '',
            ),

            // due date
            Text('Date: ${widget.taskModel.createdDate ?? ''}'),

            const SizedBox(
              height: 5,
            ),

            // buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTaskStatusChip(),
                OverflowBar(
                  children: [
                    IconButton(
                      onPressed: _onTapTaskStatusChip,
                      icon: const Icon(Iconsax.edit),
                    ),
                    IconButton(
                      onPressed: _deleteTask,
                      icon: const Icon(Iconsax.trash),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onTapTaskStatusChip() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Edit Status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                'New',
                'Completed',
                'Progress',
                'Cancelled',
              ].map((e) {
                return ListTile(
                  onTap: () {
                    _changeStatus(e);
                    Navigator.pop(context);
                  },
                  title: _selectedStatus == e
                      ? Text(
                          e,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        )
                      : Text(e),
                  selected: _selectedStatus == e,
                  selectedColor: Colors.green,
                  selectedTileColor: Colors.green[100],
                  trailing:
                      _selectedStatus == e ? const Icon(Icons.check) : null,
                );
              }).toList(),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.green.shade500),
                ),
              ),
            ],
          );
        });
  }

  Widget _buildTaskStatusChip() {
    return GestureDetector(
      onTap: _onTapTaskStatusChip,
      child: Chip(
        label: Text(
          widget.taskModel.status!,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        side: BorderSide(color: _getBorderColor()!),
        backgroundColor: _getBackgroundColor(),
      ),
    );
  }

  Color? _getBackgroundColor() {
    if (widget.taskModel.status == 'New') {
      return Colors.blue.shade50;
    } else if (widget.taskModel.status == 'Completed') {
      return Colors.green.shade50;
    } else if (widget.taskModel.status == 'Cancelled') {
      return Colors.red.shade50;
    } else if (widget.taskModel.status == 'Progress') {
      return Colors.yellow.shade50;
    } else {
      return null;
    }
  }

  Color? _getBorderColor() {
    if (widget.taskModel.status == 'New') {
      return Colors.blue.shade500;
    } else if (widget.taskModel.status == 'Completed') {
      return Colors.green.shade500;
    } else if (widget.taskModel.status == 'Cancelled') {
      return Colors.red.shade500;
    } else if (widget.taskModel.status == 'Progress') {
      return Colors.yellow.shade500;
    } else {
      return null;
    }
  }

  Future<void> _changeStatus(String newStatus) async {
    _changeStatusInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.updateTaskStatus(widget.taskModel.sId!, newStatus));
    if (response.isSuccess) {
      widget.onRefreshList();
    } else {
      _changeStatusInProgress = false;
      showSnackBarMessage(context, response.errorMessage, true);
    }

  }

  Future<void> _deleteTask() async {
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.deleteTask(widget.taskModel.sId!));
    if (response.isSuccess) {
      widget.onRefreshList();
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    setState(() {});
  }
}
