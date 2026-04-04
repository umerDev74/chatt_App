import 'package:chatt_app/screens/authScreens/login_screen.dart';
import 'package:chatt_app/screens/chatts/chatt_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  FirebaseAuth auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          PopupMenuButton(itemBuilder: (context)=>[
            PopupMenuItem(
                onTap: () async{
                  await auth.signOut();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (context)=>LoginScreen()
                  ), (value)=>false);
                },
                child: Text('logout'))
          ])
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>ChattScreen()));
            },
            title: Text('user 1'),
            subtitle: Text('user1@gmail.com'),
            leading: CircleAvatar(),
          ),
          ListTile(
            title: Text('user 2'),
            subtitle: Text('user2@gmail.com'),
            leading: CircleAvatar(),
          ),
          ListTile(
            title: Text('user 3'),
            subtitle: Text('user3@gmail.com'),
            leading: CircleAvatar(),
          ),
          ListTile(
            title: Text('user 4'),
            subtitle: Text('user4@gmail.com'),
            leading: CircleAvatar(),
          ),
          ListTile(
            title: Text('user 5'),
            subtitle: Text('user5@gmail.com'),
            leading: CircleAvatar(),
          ),
          ListTile(
            title: Text('user 6'),
            subtitle: Text('user6@gmail.com'),
            leading: CircleAvatar(),
          ),
        ],
      ),
    );
  }
}
