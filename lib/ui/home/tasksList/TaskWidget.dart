import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/Providers/AuthProvider.dart';
import 'package:todo/database/model/Task.dart';
import 'package:todo/database/model/TasksDao.dart';
import 'package:todo/ui/DialogUtils.dart';

class TasksWidget extends StatefulWidget {
  Task task;
  TasksWidget(this.task);

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
             SlidableAction(onPressed: (context){
               deleteTask();
             },
             icon: Icons.delete,
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(12),
                 bottomLeft: Radius.circular(12),
               ),
               label: "Delete",
               backgroundColor: Colors.red,
             )
          ]
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(vertical: 8,horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(18)
              ),
              width: 4,
              height: 64,

            ),
            Expanded(child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.task.title??"",
                  style: TextStyle(
                    color:Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),
                  ),
                  Text(widget.task.description??"",
                    style: TextStyle(

                        fontSize: 12
                    ),
                  ),
                ],
              ),
            )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(18)
              ),
              child:IconButton(onPressed: (){}, icon:Icon(Icons.check_outlined,),
                color: Colors.white, )
            ),
          ],
        ),
      ),
    );
  }

  void deleteTask() {
    DialogUtils.showMessage(context, "Are you sure you want delete ",
    PosActionTitle: "Yes",
      posAction: () {
      deleteTaskFromFireStore();
      },
      NegActionTitle: "Cancel"
    );
  }

  void deleteTaskFromFireStore()async {
    var authProvider = Provider.of<AuthProvider>(context,listen: false);
   // DialogUtils.showLoading(context, "Deleting Task",isCancelable: false);
    await TasksDao.removeTask(widget.task.id!,
    authProvider.databaseuser!.id!
    );
   // DialogUtils.hideMessage(context);
  }
}
