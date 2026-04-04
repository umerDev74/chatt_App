import 'package:chatt_app/models/user_model.dart';
import 'package:chatt_app/screens/authScreens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../homeScreen/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final name=TextEditingController();
  final email=TextEditingController();
  final password=TextEditingController();
  final formkey=GlobalKey<FormState>();

  FirebaseAuth auth= FirebaseAuth.instance;
  FirebaseFirestore db=FirebaseFirestore.instance;
  bool isloading=false;


  register() async{
    setState(() {
      isloading=true;
    });
    try{
     UserCredential result=
     await auth.createUserWithEmailAndPassword(email: email.text,
          password: password.text);
     UserModel user= UserModel(
         result.user?.uid, name.text, email.text);
     await db.collection('users').doc(result.user?.uid).set(user.toMap());
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
        title: Text('Register Screen'),
      ),
      body: Form(
          key: formkey,
          child: ListView(
            padding: EdgeInsets.all(15),
            children: [
              TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                      hintText: 'Name'
                  ),
                  validator: (value)
                  {
                    if(value==null || value.isEmpty)
                    {
                      return 'please enter your name';
                    }
                    return null;
                  }
              ),
              SizedBox(height: 15,),
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
                  register();
                  // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
                  // (context)=>HomeScreen()
                  // ), (value) => false);
                }
              },
                  child: Text('Register')),
              SizedBox(height: 20,),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)
                => LoginScreen()));
              }, child: Text('Already hane an account? Login')),
            ],
          ) ),
    );
  }

}
