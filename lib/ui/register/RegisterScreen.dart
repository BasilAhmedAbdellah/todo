import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/FireBaseErrorCodes.dart';
import 'package:todo/Providers/AuthProvider.dart';
import 'package:todo/ValidationUtils.dart';
import 'package:todo/database/model/User.dart' as MyUser;
import 'package:todo/database/model/UsersDao.dart';
import 'package:todo/ui/DialogUtils.dart';
import 'package:todo/ui/Login/LoginScreen.dart';
import 'package:todo/ui/common/CustomFormField.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController FullName = TextEditingController();

  TextEditingController UserName = TextEditingController();

  TextEditingController Email = TextEditingController();

  TextEditingController Password = TextEditingController();

  TextEditingController PasswordConfimation = TextEditingController();

  var formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/SIGN UP - PERSONAL.png'),
        fit: BoxFit.fill,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.all(14),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomFormField(
                  hint: 'Full Name',
                  keyboardtype: TextInputType.name,
                  validator: (text){
                    if(text==null||text.trim().isEmpty){
                      return 'Please Enter Full Name';
                    }
                    return null;
                  },
                  controller:FullName
                ),
                CustomFormField(
                  hint: 'User Name',
                  keyboardtype: TextInputType.name,
                  validator: (text){
                    if(text==null||text.trim().isEmpty){
                      return 'Please Enter Full Name';
                    }
                    return null;
                  },
                  controller: UserName,
                ),
                CustomFormField(
                  hint: 'Email',
                  keyboardtype: TextInputType.emailAddress,
                  validator: (text){
                    if(text==null||text.trim().isEmpty){
                      return 'Please Enter Full Name';
                    }
                    if (!isValidEmail(text)){
                      return'Email Bad Format';
                    }
                    return null;
                  },
                  controller: Email,
                ),
                CustomFormField(
                  hint: 'Password',
                  keyboardtype: TextInputType.text,
                  passwordtext: true,
                  validator: (text){
                    if(text==null||text.trim().isEmpty){
                      return 'Please Enter Password';
                    }
                    if(text.length<6){
                      return'Password Should be at least 6 chars';
                    }

                    return null;
                  },
                  controller: Password,
                ),
                CustomFormField(
                  hint: 'Password Confirmation',
                  keyboardtype: TextInputType.text,
                  passwordtext: true,
                  validator: (text){
                    if(text==null||text.trim().isEmpty){
                      return 'Please Enter Password Confirmation';
                    }
                    if(Password.text!=text){
                      return'Password does not Match';
                    }
                    return null;
                  },
                  controller: PasswordConfimation,
                ),
                SizedBox(height: 24,),
                ElevatedButton(onPressed: () {
                  createAccount();
                }, child: Text('Create Account')),
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, LoginScreen.routeName);
                }, child: Text(
                  "Already Have an account ? "
                ) )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createAccount() async{
    if(formkey.currentState?.validate()==false){
      return ;
    }
    // if valid -> call register from firebase

    var authProvider = Provider.of<AuthProvider>(context,listen: false);
   try {
      DialogUtils.showLoading(context, 'Loading...' ,);
     await authProvider.register(Email.text, Password.text,
         UserName.text, FullName.text);
      DialogUtils.hideMessage(context);
      DialogUtils.showMessage(context, 'Registered Successfully',
          PosActionTitle: 'ok'
          ,posAction: (){
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          });

   } on FirebaseAuthException catch (e) {
     if (e.code == FireBaseErrorCodes.weakPassword) {
       DialogUtils.showMessage(context,'The password provided is too weak.');
     } else if (e.code == FireBaseErrorCodes.emailinuse) {
       DialogUtils.showMessage(context,'The  already exists for that email.');
     }
   } catch (e) {
     DialogUtils.showMessage(context,'Something went wrong.');
   }
  }
}


