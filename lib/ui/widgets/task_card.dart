import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
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
            const Text(
              'Title of the Task',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),

            // description of the task
            const Text(
              'Do 100 push ups, while holding your breath',
            ),

            // due date
            const Text('Date: 12/12/2002'),

            const SizedBox(
              height: 5,
            ),

            // buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTaskStatusChip(),
                ButtonBar(
                  children: [
                    IconButton(
                      onPressed: _onTapEditButton,
                      icon: const Icon(Iconsax.edit),
                    ),
                    IconButton(
                      onPressed: _onTapDeleteButton,
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

  void _onTapEditButton(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text('Edit Status'),
        content: Column( mainAxisSize: MainAxisSize.min,
          children: [
                'New',
                'Completed',
                'In Progress',
                'Cancelled',
              ].map((e) {
                return ListTile(
                  onTap: (){},
                  title: Text(e)
                );
          }).toList(),
            ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('Cancel', style: TextStyle(color: Colors.green.shade500),)),
          TextButton(onPressed: (){

          }, child: Text('Okay', style: TextStyle(color: Colors.green.shade500),)),
        ],
      );
    });
  }

  void _onTapDeleteButton(){}

  Widget _buildTaskStatusChip() {
    return Chip(
      label: const Text(
        'New',
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      side: BorderSide(color: Colors.green.shade500),
      backgroundColor: Colors.lightGreen.shade50,
    );
  }
}
