import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
  });

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
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
              ),),

            // description of the task
            const Text('Do 100 push ups, while holding your breath',),

            // due date
            const Text('Date: 12/12/2002'),

            const SizedBox(height: 5,),

            // buttons
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildTaskStatusChip(),
                ButtonBar(
                  children: [
                    IconButton(onPressed: (){}, icon: const Icon(Iconsax.edit),),
                    IconButton(onPressed: (){}, icon: const Icon(Iconsax.trash),),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Chip buildTaskStatusChip() {
    return Chip(
                label: const Text('New', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                ),
                side: BorderSide(
                    color: Colors.green.shade500
                ),
                backgroundColor: Colors.lightGreen.shade50,
              );
  }
}