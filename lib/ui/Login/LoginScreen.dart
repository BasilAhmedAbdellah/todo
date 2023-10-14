import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/FireBaseErrorCodes.dart';
import 'package:todo/Providers/AuthProvider.dart';
import 'package:todo/ValidationUtils.dart';
import 'package:todo/database/model/UsersDao.dart';
import 'package:todo/ui/DialogUtils.dart';
import 'package:todo/ui/common/CustomFormField.dart';
import 'package:todo/ui/home/HomeScreen.dart';
import 'package:todo/ui/register/RegisterScreen.dart';

class LoginScreen extends StatefulWidget {
 static const String routeName = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 TextEditingController Email = TextEditingController();

 TextEditingController Password = TextEditingController();

 var formkey = GlobalKey<FormState>();

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

                SizedBox(height: 24,),
                ElevatedButton(onPressed: () {
                  Login();
                }, child: Text('Login')),
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, RegisterScreen.routeName);
                }, child: Text(
                    "Don't Have an account ? "
                ) )
              ],
            ),
          ),
        ),
      ),
    );
  }

 void Login() async{
   if(formkey.currentState?.validate()==false){
     return ;
   }
   var authProvider = Provider.of<AuthProvider>(context,listen: false);
   try {
     DialogUtils.showLoading(context, 'Loading',isCancelable: false);
      await authProvider.login(Email.text, Password.text);
     DialogUtils.hideMessage(context);
     DialogUtils.showMessage(context, 'Logged in successfully '
     ,PosActionTitle: 'ok',
       posAction: (){
       Navigator.pushReplacementNamed(context, HomeScreen.routeName);
       },

     );
   } on FirebaseAuthException catch (e) {
     DialogUtils.hideMessage(context);
     print(e.code);
     if (e.code == FireBaseErrorCodes.usernotfound||
         e.code == FireBaseErrorCodes.wrongpassword||
         e.code==  FireBaseErrorCodes.InvalidCredentionals
     ) {
       DialogUtils.showMessage(context, 'Wrong Email Or Password',
       PosActionTitle: 'ok'
       );
      }
     }
   }
}

