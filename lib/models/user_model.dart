class UserModel{
  String phoneNumber;
  String name;
  String uid;
  String email;
  String bio;
  String profilePic;

  UserModel({
  required this.phoneNumber,
  required this.name,
  required this.uid,
  required this.email,
  required this.bio,
  required this.profilePic
  });

//from map
  factory UserModel.fromMap(Map<String,dynamic> map){
    return UserModel( 
      phoneNumber: map['phoneNumber'] ?? ' ', 
      name: map['name'] ?? ' ', 
      uid: map['uid'] ?? ' ',
      email: map['email'] ?? ' ',
      bio: map['bio'] ?? ' ',
      profilePic: map['profilePic'] ?? ' '
    );
  }

//to map
  Map<String,dynamic> toMap(){
    return {
      "phoneNumber" : phoneNumber,
      "name" : name,
      "uid" : uid,
      "email" : email,
      "bio" : bio,
      "profilePic" : profilePic,
    };
  }
}