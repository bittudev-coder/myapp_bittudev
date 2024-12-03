class UserModel {
  String uid;
  String email;
  String fullname;
  String profilepic;

  // Constructor
  UserModel({
    required this.uid,
    required this.email,
    required this.fullname,
    required this.profilepic,
  });

  // Method to convert the model to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullname': fullname,
      'profilepic': profilepic,
    };
  }

  // Method to create a UserModel from a map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      fullname: map['fullname'] ?? '',
      profilepic: map['profilepic'] ?? '',
    );
  }
}
