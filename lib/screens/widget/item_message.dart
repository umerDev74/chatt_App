import 'package:chatt_app/models/message_model.dart';
import 'package:flutter/material.dart';

class ItemMessage extends StatelessWidget {
  final MessageModel message;
  const ItemMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    // Check ke message maine bheja hai ya dost ne
    bool isMe = message.ownerId == message.senderId;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey.shade300,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: Radius.circular(isMe ? 12 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 12),
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}


// import 'package:chatt_app/models/message_model.dart';
// import 'package:flutter/material.dart';
//
// class ItemMessage extends StatelessWidget {
//
//   final MessageModel message;
//   const ItemMessage({super.key,required this.message});
//
//   @override
//   Widget build(BuildContext context) {
//     return  Align(
//       alignment: message.ownerId == message.senderId?Alignment.centerRight:Alignment.centerLeft,
//       child: Container(
//         constraints: BoxConstraints(maxWidth: 250),
//         padding: EdgeInsets.all(10),
//         margin: EdgeInsets.all(15),
//         decoration: BoxDecoration(
//           color: message.ownerId == message.senderId?Colors.blue:Colors.grey.shade300,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Text(message.text,
//           style: TextStyle(
//           color: message.ownerId == message.senderId?Colors.white:Colors.black,
//         ),),
//       ),
//     );
//   }
// }
