class UserModel{
  String email;
  String name;
  String uid;

  UserModel({
  required this.email,
  required this.name,
  required this.uid,
  });

//from map
  factory UserModel.fromMap(Map<String,dynamic> map){
    return UserModel( 
      email: map['email'] ?? ' ', 
      name: map['name'] ?? ' ', 
      uid: map['uid'] ?? ' ',
    );
  }

//to map
  Map<String,dynamic> toMap(){
    return {
      "email" : email,
      "name" : name,
      "uid" : uid,
    };
  }
}