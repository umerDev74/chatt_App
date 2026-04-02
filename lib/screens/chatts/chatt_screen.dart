import 'package:chatt_app/screens/widget/item_message.dart';
import 'package:flutter/material.dart';

class ChattScreen extends StatefulWidget {
  const ChattScreen({super.key});

  @override
  State<ChattScreen> createState() => _ChattScreenState();
}

class _ChattScreenState extends State<ChattScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('user name'),
      ),
     body: ListView(
       children: [
        ItemMessage(issender: false,),
        ItemMessage(issender: true,),
         ItemMessage(issender: false,),
         ItemMessage(issender: true,),
         ItemMessage(issender: false,),
         ItemMessage(issender: true,),
         ItemMessage(issender: false,),
         ItemMessage(issender: true,),
         ItemMessage(issender: false,),
         ItemMessage(issender: true,),
       ],
     ),
     bottomSheet: Padding(padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
     child: Row(
         children: [
           Expanded(child: TextField(
             decoration: InputDecoration(
               hintText: 'Type your message....',
             ),
           )),
           IconButton(onPressed: (){

           },
               icon: Icon(Icons.send,color: Colors.blue,)),
       ],
     ),),

    );
  }
}
