import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Providers/AuthProvider.dart';
import 'package:todo/database/model/Task.dart';
import 'package:todo/database/model/TasksDao.dart';
import 'package:todo/ui/DialogUtils.dart';
import 'package:todo/ui/common/CustomFormField.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
  var desciptionController = TextEditingController();
  var titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add New Task',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            CustomFormField(
              hint: 'Title',
              controller: titleController,
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return "please enter task title";
                }
              },
            ),
            CustomFormField(
              hint: 'Description',
              lines: 4,
              controller: desciptionController,
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return "please enter task description";
                }
              },
            ),
            InkWell(
              onTap: () {
                showTaskDatePicker();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 18),
                decoration:
                    BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
                child: Text(selectedDate == null
                    ? 'Date'
                    : "${selectedDate?.day} / ${selectedDate?.month} / ${selectedDate?.year}"),
              ),
            ),
            Visibility(
              visible: showDateError,
              child: Text(
                'Please select task date',
                style: TextStyle(
                    fontSize: 12, color: Theme.of(context).colorScheme.error),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            ElevatedButton(
                onPressed: () {
                  addTask();
                },
                child: Text("Add Task")),
          ],
        ),
      ),
    );
  }

  bool showDateError = false;
  bool isValidForm() {
    bool isValid = true;
    if (formKey.currentState?.validate() == false) {
      isValid = false;
    }
    if (selectedDate == null) {
      setState(() {
        showDateError = true;
      });
      isValid = false;
    }
    return isValid;
  }

  void addTask() async {
    if(!isValidForm())return;
    var authProvider = Provider.of<AuthProvider>(context,listen:false);
   Task task = Task(
     title: titleController.text,
     description: desciptionController.text,
     dateTime: Timestamp.fromMillisecondsSinceEpoch(selectedDate!.millisecondsSinceEpoch)
   );
   DialogUtils.showLoading(context, 'Creating Task...');
   await TasksDao.createTask(task, authProvider.databaseuser!.id!);
   DialogUtils.hideMessage(context);
   DialogUtils.showMessage(context, 'Task Created Successfully',
   PosActionTitle: 'Ok',
     posAction: () {
       Navigator.pop(context);
     },
     isCancelable: false
   );
  }
  DateTime? selectedDate;
  void showTaskDatePicker() async {
    var date = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

    setState(() {
      selectedDate = date;
      if (selectedDate != null) {
        showDateError = false;
      }
    });
  }
}
