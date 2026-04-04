class UserModel{
  String? id;
  String name,email;

  UserModel (this.id,this.name,this.email);

  factory UserModel.fromMap(map) =>UserModel(
      map['id'],
      map['name'],
      map['email']
  );

  Map<String,dynamic> toMap()=>{
    'id':id,
    'name':name,
    'email':email,
  };
}