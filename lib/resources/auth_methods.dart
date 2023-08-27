import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:student_attendance/models/user_model.dart';
import 'package:student_attendance/utils/utils.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> SignUp({
    required String name,
    required String regno,
    required String email,
    required String password,
  }) async {
    String res = 'some error occured';
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          name.isNotEmpty &&
          regno.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        Map<String, dynamic> userModel = UserModel(
                uid: _auth.currentUser!.uid,
                name: name,
                regno: regno,
                email: email,
                password: password)
            .makeJson();
        await _firestore
            .collection('students')
            .doc(cred.user?.uid)
            .set(userModel);
        res = 'success';
        await _firestore
            .collection('students')
            .doc(cred.user?.uid)
            .collection('history')
            .doc(DateTime.now().toString())
            .set({
          'Math': '',
          'Physics': '',
          'Chemistry': '',
          'Biology': '',
          'Hindi': '',
          'English': '',
        });
        res = 'success';
      }
    } catch (e) {
      print(e.toString());
    }
    return res;
  }

  Future<String> LogIn(
      {required String email,
      required String password,
      required context}) async {
    String res = 'some error occured';
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      showSnackbar(context, 'Successfull');
      res = 'success';
    } catch (e) {
      print(e.toString());
    }
    return res;
  }
}
