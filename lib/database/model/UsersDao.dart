import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/database/model/User.dart';

class UsersDao{

  static CollectionReference<User> getUsersCollection(){
    var db = FirebaseFirestore.instance;
    var userCollection = db.collection(User.collectionname)
        .withConverter(
      fromFirestore: (snapshot, options) => User.fromFireStore(snapshot.data()),
      toFirestore: (object, options) => object.toFireStore(),
    );
    return userCollection;
  }
   static Future<void>createUser(User user){
   var userCollection = getUsersCollection();
   var doc =  userCollection.doc(user.id); // create doc with uid (authentication)
    return doc.set(user);
  }
  static Future<User?> getUser (String uid)async{

    var doc =getUsersCollection().doc(uid);
    var docSnapshot = await doc.get();
    return docSnapshot.data();

  }
}