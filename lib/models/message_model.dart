class MessageModel{
  String id, ownerId, friendId, senderId;
  String text;
  DateTime createdAt;

  MessageModel(this.id,this.ownerId,this.friendId,
      this.senderId,this.text,this.createdAt);

  factory MessageModel.fromMap(map)=>MessageModel(
    map['id'],
    map['owner_id'],
    map['friend_id'],
    map['sender_id'],
    map['text'],
    DateTime.parse(map['created_at'])
  );
  Map<String, dynamic> toMap()=>
      {
        'id':id,
        'owner_id':ownerId,
        'friend_id':friendId,
        'sender_id':senderId,
        'text':text,
        'created_at':createdAt.toString()
      };
}