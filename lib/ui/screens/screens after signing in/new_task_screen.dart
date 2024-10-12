import 'package:flutter/material.dart';
import '../../widgets/task_card.dart';
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
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8,),
            // the top scrollable row which shows total task statuses
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: buildSummarySection(),
            ),

            const SizedBox(height: 8,),

            // all tasks list
            Expanded(
              child: ListView.separated(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return  const TaskCard();
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 8);
                },
              ),
            ),
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

  Widget buildSummarySection() {
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

