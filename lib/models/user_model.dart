import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String regno;
  final String email;
  final String password;

  UserModel({
    required this.uid,
    required this.name,
    required this.regno,
    required this.email,
    required this.password,
  });
  Map<String, dynamic> makeJson() {
    return {
      'uid':uid,
      'name': name,
      'regno': regno,
      'email': email,
      'password': password,
    };
  }

  Map<String, dynamic> jsonFromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      uid: uid,
        name: snapshot['name'],
        regno: snapshot['regno'],
        email: snapshot['email'],
        password: snapshot['password']).makeJson();
  }
}
