import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/database/model/Task.dart';
import 'package:todo/database/model/UsersDao.dart';

class TasksDao{

 static CollectionReference<Task> getTasksCollection(String uid){
   return UsersDao.getUsersCollection()
        .doc()
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
}