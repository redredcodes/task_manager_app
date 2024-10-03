import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/screens%20after%20signing%20in/add_new_task_screen.dart';
import 'package:task_manager_app/ui/screens/screens%20after%20signing%20in/cancelled_task_scree.dart';
import 'package:task_manager_app/ui/screens/screens%20after%20signing%20in/completed_task_scree.dart';
import 'package:task_manager_app/ui/screens/screens%20after%20signing%20in/new_task_scree.dart';
import 'package:task_manager_app/ui/screens/screens%20after%20signing%20in/progress_task_scree.dart';
import 'package:task_manager_app/ui/widgets/frosted_glass.dart';
import '../../widgets/tm_appbar.dart';

class LadingPage extends StatefulWidget {
  const LadingPage({super.key});

  @override
  State<LadingPage> createState() => _LadingPageState();
}

class _LadingPageState extends State<LadingPage> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const NewTaskScreen(),
    const CompletedTaskScreen(),
    const CancelledTaskScreen(),
    const ProgressTaskScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const TMAppBar(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.green[200],
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.green,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _navigateBottomBar,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.new_label),
            label: 'New',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_circle,),
            label: 'Completed',
          ),
          NavigationDestination(icon: Icon(Icons.cancel,), label: 'Cancelled'),
          NavigationDestination(
              icon: Icon(Icons.stairs_rounded, ), label: 'Progress'),
        ],
      ),
    );
  }

}
