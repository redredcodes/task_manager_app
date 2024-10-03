import 'package:flutter/material.dart';

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
      body: const Column( mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Card(
                child: Column(
                  children: [
                    Text('09', style: TextStyle(fontSize: 20),),
                    Text('New Task', style: TextStyle(fontSize: 10),)
                  ],
                ),
              ),
              Card(
                child: Text(''),
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[500],
        foregroundColor: Colors.white,
        onPressed: onTapFAB,
        child: const Icon(Icons.add),
      ),
    );
  }
  void onTapFAB() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AddNewTaskScreen()));

  }

}

