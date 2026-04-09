import 'package:chatt_app/models/message_model.dart';
import 'package:flutter/material.dart';

class ItemMessage extends StatelessWidget {

  final MessageModel message;
  const ItemMessage({super.key,required this.message});

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: message.ownerId == message.senderId?Alignment.centerRight:Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 250),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: message.ownerId == message.senderId?Colors.blue:Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(message.text,
          style: TextStyle(
          color: message.ownerId == message.senderId?Colors.white:Colors.black,
        ),),
      ),
    );
  }
}
