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
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //const SizedBox(height: 100,),

            // the top scrollable row that has vanished
            //buildSummarySection(),
            Row(
              children: [
                Expanded(
                  child: TaskSummaryCard(
                    taskStatus: 'New',
                    taskCount: 09,
                  ),
                ),
                Expanded(
                  child: TaskSummaryCard(
                    taskStatus: 'Completed',
                    taskCount: 09,
                  ),
                ),
                Expanded(
                  child: TaskSummaryCard(
                    taskStatus: 'In Progress',
                    taskCount: 09,
                  ),
                ),
                Expanded(
                  child: TaskSummaryCard(
                    taskStatus: 'Cancelled',
                    taskCount: 09,
                  ),
                ),
              ],
            ),
            // all tasks list
            Expanded( flex: 3,
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

