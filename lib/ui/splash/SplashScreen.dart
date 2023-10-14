import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Providers/AuthProvider.dart';
import 'package:todo/ui/Login/LoginScreen.dart';
import 'package:todo/ui/home/HomeScreen.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = "Splash";
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2),(){
      navigate(context);
     }
    );
    return Scaffold(
      body: Image.asset('assets/images/splash.png'),
    );
  }

  void navigate(BuildContext context) async {
    var authProvider = Provider.of<AuthProvider>(context,listen:false);
    if(authProvider.isUserLoggedInBefore()){
     await authProvider.retreiveUserFromDataBase();
      Navigator.pushReplacementNamed(context,HomeScreen.routeName);
    }else{
      Navigator.pushReplacementNamed(context,LoginScreen.routeName);
    }
  }
}
