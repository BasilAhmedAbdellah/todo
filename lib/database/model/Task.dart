import 'package:cloud_firestore/cloud_firestore.dart';

class Task{
  static const String collectionName = "tasks";
  String? id;
  String? title;
  String? description;
  Timestamp? dateTime;
  bool isDone;
  Task({
    this.id,
    this.title,
    this.dateTime,
    this.description,
    this.isDone=false
  });
  Task.fromFireStore(Map<String,dynamic>? data):
      this(
        id: data?['id'],
        title: data?['title'],
        dateTime: data?['dateTime'],
        description: data?['description'],
        isDone: data?['isDone'],
      );
  Map<String,dynamic> toFirestore(){
   return{
     'id':id,
     'title':title,
     'dateTime':dateTime,
     'description':description,
     'isDone':isDone
   };
  }

}