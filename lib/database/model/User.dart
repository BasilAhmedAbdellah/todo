class User{
  static const String collectionname ='users';
  String? fullname;
  String? username;
  String? email;
  String? id;
  User({this.email,this.username,this.fullname,this.id});
  User.fromFireStore(Map<String,dynamic>? data) {
    id= data? ['id'];
    username=data?['username'];
    fullname=data?['fullname'];
    email=data?['email'];
  }

  Map<String,dynamic> toFireStore(){

    return{
      'email':email,
      'username':username,
      'fullname':fullname,
      'id':id
    };
  }


}