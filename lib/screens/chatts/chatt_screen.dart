import 'package:chatt_app/models/message_model.dart';
import 'package:chatt_app/models/user_model.dart';
import 'package:chatt_app/screens/widget/item_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChattScreen extends StatefulWidget {
  final UserModel user;
  const ChattScreen({super.key,required this.user});

  @override
  State<ChattScreen> createState() => _ChattScreenState();
}

class _ChattScreenState extends State<ChattScreen> {
  FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseFirestore db=FirebaseFirestore.instance;
  final msg=TextEditingController();

  sendmessage()async{
    DateTime now=DateTime.now();
    String msgId=now.millisecondsSinceEpoch.toString();
    MessageModel message=MessageModel(
        msgId,
        auth.currentUser!.uid,
        widget.user.id!,
        auth.currentUser!.uid,
        msg.text,
        now
    );
    String msgIdduplicate=  msgId.split('').reversed.join();
    MessageModel messageDuplicate=MessageModel(
        msgIdduplicate,
        widget.user.id!,
        auth.currentUser!.uid,
        auth.currentUser!.uid,
        msg.text,
        now
    );
    try{
      await db.collection('message').doc(msgId).set(message.toMap());
      await db.collection('message').doc(msgIdduplicate)
          .set(messageDuplicate.toMap());
      msg.clear();
    }catch(e){
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
       stream: db.collection('message')
           .where('owner_id',isEqualTo: auth.currentUser?.uid)
           .snapshots(),
       builder: (context, snapshot) {
         // if(snapshot.connectionState == ConnectionState.waiting)
         //   {
         //     return Center(child: CircularProgressIndicator(),);
         //   }
         if(snapshot.data == null || !snapshot.hasData){
           return SizedBox();
         }
        List<MessageModel> messages= snapshot.data!.
        docs.map((e)=>MessageModel.fromMap(e.data())).toList();
         return ListView(
           children: [
            for(var message in messages)
              ItemMessage(message: message,)
           ],
         );
       }
     ),
     bottomSheet: Padding(padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
     child: Row(
         children: [
           Expanded(child: TextField(
             controller: msg,
             decoration: InputDecoration(
               hintText: 'Type your message....',
             ),
           )),
           IconButton(onPressed: (){
             if(msg.text.isNotEmpty){
               sendmessage();
             }
           },
               icon: Icon(Icons.send,color: Colors.blue,)),
       ],
     ),),

    );
  }
}
