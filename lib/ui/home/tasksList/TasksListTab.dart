import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Providers/AuthProvider.dart';
import 'package:todo/database/model/TasksDao.dart';
import 'package:todo/ui/home/tasksList/TaskWidget.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    return Column(
      children: [
        Expanded(child:
    StreamBuilder(
      stream:TasksDao.ListenForTasks(authProvider.databaseuser?.id??"") ,
        builder:(context, snapshot) {
           if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                   }
           if(snapshot.hasError){
             return Center(
               child:Column(
                 children: [
                   Text("Something went wrong . please try again"),
                 ElevatedButton(onPressed: (){}, child: Text("Try Again"))
                 ],
               ) ,
             );
           }
           var tasksList=snapshot.data;
           return ListView.builder(itemBuilder: (context, index) {
             return TasksWidget(tasksList![index]);
           },itemCount: tasksList?.length??0,
           );
        }, )
    )
      ],
    );
  }
}
