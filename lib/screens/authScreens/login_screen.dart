import 'package:chatt_app/screens/authScreens/register_screen.dart';
import 'package:chatt_app/screens/homeScreen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final email=TextEditingController();
  final password=TextEditingController();
  final formkey=GlobalKey<FormState>();

  FirebaseAuth auth= FirebaseAuth.instance;
  bool isloading=false;

  login() async{
    setState(() {
      isloading=true;
    });
    try{
     await auth.signInWithEmailAndPassword(email: email.text,
          password: password.text);
     if(!mounted)return;
     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
         builder: (context)=>HomeScreen()),
         (value)=>false);
    }catch(e){
     print(e.toString());
    } finally{
      setState(() {
        isloading=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Form(
          key: formkey,
          child: ListView(
            padding: EdgeInsets.all(15),
            children: [
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  hintText: 'Email'
                ),
                validator: (value)
                {
                  if(value==null || value.isEmpty)
                    {
                      return 'please enter your email';
                    }
                  return null;
                  }
              ),
              SizedBox(height: 15,),
              TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                      hintText: 'Password'
                  ),
                  validator: (value)
                  {
                    if(value==null || value.isEmpty)
                    {
                      return 'please enter your password';
                    }
                    return null;
                  }
              ),
              SizedBox(height: 25,),
              isloading?Center(child: CircularProgressIndicator(),):
              ElevatedButton(onPressed: (){
                if(formkey.currentState!.validate())
                {
                  login();
                  // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
                  // (context)=>HomeScreen()
                  // ), (value) => false);
                }
              },
                child: Text('Login')),
              SizedBox(height: 20,),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)
                => RegisterScreen()));
              }, child: Text('Do not hane an account? Register')),
            ],
          ) ),
    );
  }
}
