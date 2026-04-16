import 'package:chatt_app/models/message_model.dart';
import 'package:chatt_app/models/user_model.dart';
import 'package:chatt_app/screens/widget/item_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChattScreen extends StatefulWidget {
  final UserModel user;
  const ChattScreen({super.key, required this.user});

  @override
  State<ChattScreen> createState() => _ChattScreenState();
}

class _ChattScreenState extends State<ChattScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final msg = TextEditingController();

  // --- DELETE MESSAGE FUNCTION ---
  deleteMessage(String msgId) async {
    // Kyunke aapne send karte waqt reverse ID ke sath duplicate banaya tha
    String msgIdDuplicate = msgId.split('').reversed.join();

    try {
      await db.collection('message').doc(msgId).delete();
      await db.collection('message').doc(msgIdDuplicate).delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message deleted')),
      );
    } catch (e) {
      print("Error deleting message: $e");
    }
  }

  sendmessage() async {
    if (msg.text.isEmpty) return;
    DateTime now = DateTime.now();
    String msgId = now.millisecondsSinceEpoch.toString();
    MessageModel message = MessageModel(msgId, auth.currentUser!.uid,
        widget.user.id!, auth.currentUser!.uid, msg.text, now);

    String msgIdduplicate = msgId.split('').reversed.join();
    MessageModel messageDuplicate = MessageModel(msgIdduplicate, widget.user.id!,
        auth.currentUser!.uid, auth.currentUser!.uid, msg.text, now);

    try {
      await db.collection('message').doc(msgId).set(message.toMap());
      await db.collection('message').doc(msgIdduplicate).set(messageDuplicate.toMap());
      msg.clear();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.name),
      ),
      body: StreamBuilder(
          stream: db
              .collection('message')
              .where('owner_id', isEqualTo: auth.currentUser?.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null || !snapshot.hasData) {
              return const SizedBox();
            }
            List<MessageModel> messages = snapshot.data!.docs
                .map((e) => MessageModel.fromMap(e.data()))
                .toList();

            // Messages ko time ke hisab se sort karna behtar hai
            messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));

            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 70), // TextField ke liye space
              itemCount: messages.length,
              itemBuilder: (context, index) {
                var message = messages[index];
                return GestureDetector(
                  onLongPress: () {
                    // Delete Confirmation Dialog
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Message?'),
                        content: const Text('Kya aap ye message delete karna chahte hain?'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Nahi')),
                          TextButton(
                              onPressed: () {
                                deleteMessage(message.id);
                                Navigator.pop(context);
                              },
                              child: const Text('Haan', style: TextStyle(color: Colors.red))),
                        ],
                      ),
                    );
                  },
                  child: ItemMessage(message: message),
                );
              },
            );
          }),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            Expanded(
                child: TextField(
                  controller: msg,
                  decoration: const InputDecoration(
                    hintText: 'Type your message....',
                  ),
                )),
            IconButton(
                onPressed: () {
                  if (msg.text.isNotEmpty) {
                    sendmessage();
                  }
                },
                icon: const Icon(Icons.send, color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}


// import 'package:chatt_app/models/message_model.dart';
// import 'package:chatt_app/models/user_model.dart';
// import 'package:chatt_app/screens/widget/item_message.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class ChattScreen extends StatefulWidget {
//   final UserModel user;
//   const ChattScreen({super.key,required this.user});
//
//   @override
//   State<ChattScreen> createState() => _ChattScreenState();
// }
//
// class _ChattScreenState extends State<ChattScreen> {
//   FirebaseAuth auth=FirebaseAuth.instance;
//   FirebaseFirestore db=FirebaseFirestore.instance;
//   final msg=TextEditingController();
//
//   sendmessage()async{
//     DateTime now=DateTime.now();
//     String msgId=now.millisecondsSinceEpoch.toString();
//     MessageModel message=MessageModel(
//         msgId,
//         auth.currentUser!.uid,
//         widget.user.id!,
//         auth.currentUser!.uid,
//         msg.text,
//         now
//     );
//     String msgIdduplicate=  msgId.split('').reversed.join();
//     MessageModel messageDuplicate=MessageModel(
//         msgIdduplicate,
//         widget.user.id!,
//         auth.currentUser!.uid,
//         auth.currentUser!.uid,
//         msg.text,
//         now
//     );
//     try{
//       await db.collection('message').doc(msgId).set(message.toMap());
//       await db.collection('message').doc(msgIdduplicate)
//           .set(messageDuplicate.toMap());
//       msg.clear();
//     }catch(e){
//       print(e.toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.user.name),
//       ),
//      body: StreamBuilder(
//        stream: db.collection('message')
//            .where('owner_id',isEqualTo: auth.currentUser?.uid)
//            .snapshots(),
//        builder: (context, snapshot) {
//          // if(snapshot.connectionState == ConnectionState.waiting)
//          //   {
//          //     return Center(child: CircularProgressIndicator(),);
//          //   }
//          if(snapshot.data == null || !snapshot.hasData){
//            return SizedBox();
//          }
//         List<MessageModel> messages= snapshot.data!.
//         docs.map((e)=>MessageModel.fromMap(e.data())).toList();
//          return ListView(
//            children: [
//             for(var message in messages)
//               ItemMessage(message: message,)
//            ],
//          );
//        }
//      ),
//      bottomSheet: Padding(padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
//      child: Row(
//          children: [
//            Expanded(child: TextField(
//              controller: msg,
//              decoration: InputDecoration(
//                hintText: 'Type your message....',
//              ),
//            )),
//            IconButton(onPressed: (){
//              if(msg.text.isNotEmpty){
//                sendmessage();
//              }
//            },
//                icon: Icon(Icons.send,color: Colors.blue,)),
//        ],
//      ),),
//
//     );
//   }
// }
