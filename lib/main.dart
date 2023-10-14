import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Providers/AuthProvider.dart';
import 'package:todo/ui/Login/LoginScreen.dart';
import 'package:todo/ui/home/HomeScreen.dart';
import 'package:todo/ui/register/RegisterScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo/ui/splash/SplashScreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (buildContext) =>AuthProvider() ,

      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Theme.of(context).primaryColor
        ),

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue,
         primary: Colors.blue,
        ),
        scaffoldBackgroundColor: Color(0xFFDFECDB),
        useMaterial3: false,
      ),
      routes: {
    RegisterScreen.routeName:(buildContext)=>RegisterScreen(),
    LoginScreen.routeName:(buildContext)=>LoginScreen(),
    HomeScreen.routeName:(buildContext)=>HomeScreen(),
    SplashScreen.routeName:(buildContext)=>SplashScreen(),
      },
      initialRoute: SplashScreen.routeName,
    );

  }
}

