import 'package:flutter/material.dart';

class TaskSummaryCard extends StatelessWidget {
  const TaskSummaryCard({
    super.key, required this.taskStatus, required this.taskCount,
  });

  final String taskStatus;
  final int taskCount;


  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Text(
                '$taskCount',
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22
                ),
              ),
              Text(
                taskStatus,
                style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
