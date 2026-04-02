import 'package:flutter/material.dart';

class ItemMessage extends StatelessWidget {

  final bool issender;
  const ItemMessage({super.key,required this.issender});

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: issender?Alignment.centerRight:Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 250),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: issender?Colors.blue:Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text('How are you ? you are welcome ! nice to meet you',style: TextStyle(
          color: issender?Colors.white:Colors.black,
        ),),
      ),
    );
  }
}
