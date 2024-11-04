import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/my_button.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';
import 'package:task_manager_app/ui/widgets/tm_appbar.dart';

class AddNewTaskScreen extends StatefulWidget {
   AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _addNewTaskTEController = TextEditingController();

  final TextEditingController _descriptionTEController = TextEditingController();

  // FocusNode to manage focus for the text field
  final FocusNode _textFieldFocusNode = FocusNode();

  bool _isButtonEnabled = false;
  bool _addNewTaskInProgress = false;
  bool _shouldRefreshPreviousPage = false;

  void _showKeyboard() {
    FocusScope.of(context).requestFocus(_textFieldFocusNode);
  }

  void _autoHideKeyboard() {
    FocusScope.of(context).unfocus();
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showKeyboard();
    });
    _addNewTaskTEController.addListener(_checkInput);
    // _showKeyboard();
  }

  void _checkInput() {
    setState(() {
      _isButtonEnabled = _addNewTaskTEController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _descriptionTEController;
    _addNewTaskTEController;
    _textFieldFocusNode;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        Navigator.pop(context, _shouldRefreshPreviousPage);
      },

      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const TMAppBar(),
        body: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 42,
                ),
                Column( crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Add New Task',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      focusNode: _textFieldFocusNode,
                      decoration: InputDecoration(
                        hintText: 'Add new task',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green.shade500)),
                      ),
                      controller: _addNewTaskTEController,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green.shade500)),
                      ),
                      controller: _descriptionTEController,
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                Visibility(
                  visible: !_addNewTaskInProgress,
                  replacement: const CenteredCircularProgressIndicator(),
                  child: MyButton(
                    onPressed: _isButtonEnabled ? _onTapSendButton : null,
                    child: const Icon(
                      Icons.send,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSendButton() {
    _addNewTask();
  }

  // add_new_task post request function
  Future<void> _addNewTask() async {
    setState(() {
      _addNewTaskInProgress = true;
    });
    Map <String, dynamic> requestBody = {
      'title': _addNewTaskTEController.text.trim(),
      'description': _descriptionTEController.text.trim(),
      'status': 'New'
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.addNewTask, body: requestBody);
    setState(() {
      _addNewTaskInProgress = false;
    });
    if (response.isSuccess) {
      _autoHideKeyboard();
      _clearTextFields();
      _shouldRefreshPreviousPage = true;
      showSnackBarMessage(context, 'New Task Added');
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  void _clearTextFields() {
    _descriptionTEController.clear();
    _addNewTaskTEController.clear();
  }
}
