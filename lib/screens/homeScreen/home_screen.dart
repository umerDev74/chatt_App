import 'package:chatt_app/models/user_model.dart';
import 'package:chatt_app/screens/authScreens/login_screen.dart';
import 'package:chatt_app/screens/chatts/chatt_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  // User Delete karne ka function
  deleteUser(String userId) async {
    try {
      await db.collection('users').doc(userId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User deleted successfully')),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  // Confirmation Dialog
  showDeleteDialog(UserModel user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete User'),
        content: Text('Kya aap ${user.name} ko delete karna chahte hain?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Nahi'),
          ),
          TextButton(
            onPressed: () {
              deleteUser(user.id!);
              Navigator.pop(context);
            },
            child: const Text('Haan, Delete karein', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          PopupMenuButton(itemBuilder: (context) => [
            PopupMenuItem(
              onTap: () async {
                await auth.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (value) => false,
                );
              },
              child: const Text('logout'),
            )
          ])
        ],
      ),
      body: StreamBuilder(
          stream: db.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('Empty'));
            }
            List<UserModel> users = snapshot.data!.docs
                .map((e) => UserModel.fromMap(e.data()))
                .toList();
            return ListView(
              children: [
                for (var user in users)
                  if (user.id != auth.currentUser?.uid)
                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChattScreen(user: user),
                          ),
                        );
                      },
                      onLongPress: () {
                        // Long press par dialog show hoga
                        showDeleteDialog(user);
                      },
                      title: Text(user.name),
                      subtitle: Text(user.email),
                      leading: const CircleAvatar(),
                    ),
              ],
            );
          }),
    );
  }
}


// import 'package:chatt_app/models/user_model.dart';
// import 'package:chatt_app/screens/authScreens/login_screen.dart';
// import 'package:chatt_app/screens/chatts/chatt_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   FirebaseAuth auth=FirebaseAuth.instance;
//   FirebaseFirestore db=FirebaseFirestore.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//         centerTitle: true,
//         actions: [
//           PopupMenuButton(itemBuilder: (context)=>[
//             PopupMenuItem(
//                 onTap: () async{
//                   await auth.signOut();
//                   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
//                     builder: (context)=>LoginScreen()
//                   ), (value)=>false);
//                 },
//                 child: Text('logout'))
//           ])
//         ],
//       ),
//       body: StreamBuilder(
//         stream: db.collection('users').snapshots(),
//         builder: (context, snapshot) {
//           if(snapshot.connectionState == ConnectionState.waiting)
//             {
//               return Center(child: CircularProgressIndicator(),);
//             }
//           if(!snapshot.hasData || snapshot.data == null)
//             {
//               return Center(child: Text('Empty'));
//             }
//           List<UserModel> users =snapshot.data!.docs.map((e)=>UserModel.fromMap(e.data())).toList();
//           return ListView(
//             children: [
//               for(var user in users)
//                 if(user.id != auth.currentUser?.uid)
//                   ListTile(
//                     onTap: (){
//                       Navigator.push(context, MaterialPageRoute(
//                           builder: (context)=>ChattScreen(user: user,)));
//                     },
//                     title: Text(user.name),
//                     subtitle: Text(user.email),
//                     leading: CircleAvatar(),
//                   ),
//             ],
//           );
//         }
//       ),
//     );
//   }
// }
