import 'package:flutter/material.dart';
import 'package:todo/database/model/User.dart' as MyUser;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/database/model/UsersDao.dart';

class AuthProvider extends ChangeNotifier{
  User? firebaseAuthuser;
  MyUser.User? databaseuser;


  Future<void> register(String Email , String Password , String UserName,String FullName )async{
    var result = await FirebaseAuth.instance.createUserWithEmailAndPassword
      (email: Email,
        password: Password);
    await UsersDao.createUser(
        MyUser.User(
            id:result.user?.uid,
            username: UserName,
            fullname: FullName,
            email: Email
        )
    );
  }
  Future<void> login(String Email , String Password)async{
    final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: Email,
        password: Password
    );
    var user = await UsersDao.getUser(result.user!.uid);
    databaseuser = user as MyUser.User?;
    firebaseAuthuser = result.user;
    return;
  }

  void logout() {
    databaseuser=null;
    FirebaseAuth.instance.signOut();
  }

  bool isUserLoggedInBefore() {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<void> retreiveUserFromDataBase() async{
    firebaseAuthuser = FirebaseAuth.instance.currentUser;
    databaseuser = await UsersDao.getUser(firebaseAuthuser!.uid);
  }
}