import 'package:chatt_app/screens/authScreens/login_screen.dart';
import 'package:chatt_app/screens/homeScreen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  FirebaseAuth auth=FirebaseAuth.instance;

  @override
  void initState() {
    nextscreen();
    super.initState();
  }

  nextscreen()
  async{
    await Future.delayed(Duration(seconds: 3));
    if(!mounted){
      return;
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder:
    (context)=> auth.currentUser == null? LoginScreen():HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(size: 100,),
      ),
    );
  }
}
