class UserModel{
  String phoneNumber;
  String name;
  String uid;

  UserModel({
  required this.phoneNumber,
  required this.name,
  required this.uid,
  });

//from map
  factory UserModel.fromMap(Map<String,dynamic> map){
    return UserModel( 
      phoneNumber: map['phoneNumber'] ?? ' ', 
      name: map['name'] ?? ' ', 
      uid: map['uid'] ?? ' ',
    );
  }

//to map
  Map<String,dynamic> toMap(){
    return {
      "phoneNumber" : phoneNumber,
      "name" : name,
      "uid" : uid,
    };
  }
}