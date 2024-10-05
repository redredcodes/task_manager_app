import 'package:flutter/material.dart';
import '../../widgets/task_summary_card.dart';
import 'add_new_task_screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildSummarySection(),
          ],
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

  SingleChildScrollView buildSummarySection() {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          TaskSummaryCard(
            taskStatus: 'New',
            taskCount: 09,
          ),
          TaskSummaryCard(
            taskStatus: 'Completed',
            taskCount: 09,
          ),
          TaskSummaryCard(
            taskStatus: 'In Progress',
            taskCount: 09,
          ),
          TaskSummaryCard(
            taskStatus: 'Cancelled',
            taskCount: 09,
          ),
        ],
      ),
    );
  }

  void onTapFAB() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AddNewTaskScreen()));
  }
}
