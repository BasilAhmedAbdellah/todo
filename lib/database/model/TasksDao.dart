import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/database/model/Task.dart';
import 'package:todo/database/model/UsersDao.dart';

class TasksDao{

 static CollectionReference<Task> getTasksCollection(String uid){
   return UsersDao.getUsersCollection()
        .doc(uid)
        .collection(Task.collectionName)
        .withConverter(
        fromFirestore: (snapshot, options) => Task.fromFireStore(snapshot.data()),
        toFirestore: (task, options) =>task.toFirestore(),);
  }
  static Future<void> createTask(Task task,String uid){
       var docRef=getTasksCollection(uid).doc();
       task.id = docRef.id;
       return docRef.set(task);
  }

  static Future<List<Task>> getAllTasks(String uid)async{
   var tasksSnapshot = await getTasksCollection(uid)
       .get();
   var tasksList=tasksSnapshot.docs.map((snapshot) => snapshot.data())
   .toList();
   return tasksList;
  }
  static Stream<List<Task>> ListenForTasks(String uid)async*{
   var stream = getTasksCollection(uid).snapshots();
   yield* stream.map((querySnapShot) => querySnapShot.docs.map((doc) => doc.data()).toList());
  }

 static Future<void> removeTask (String taskId , String uid){
    return getTasksCollection(uid)
         .doc(taskId)
         .delete();
  }

}