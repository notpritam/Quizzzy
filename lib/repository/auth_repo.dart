import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  const AuthRepository(this._auth);

  final FirebaseAuth _auth;

  Stream<User?> get authChanges => _auth.idTokenChanges();

  signInWithEmailAndPassword(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Login Successful";
    } on FirebaseAuthException catch (e) {
      print("notworking");
      if (e.code == 'user-not-found') {
        return "User not found";
      } else if (e.code == 'wrong-password') {
        return "Wrong password";
      }
    }
    return "Something Wrong";
  }

  updateData(int wrong, int correct) async {
    var collection = FirebaseFirestore.instance.collection('users');
    try {
      var docSnapshot = await collection.doc(_auth.currentUser?.uid).get();
      Map<String, dynamic>? data = docSnapshot.data();
      print(data);
      int prevwrong = int.parse(data!['wrong']);
      int prevcorrect = int.parse(data!['correctquestion']);
      print(prevwrong);

      print(prevcorrect);
      final newData = <String, dynamic>{
        "correctquestion": "${correct + prevcorrect}",
        "wrong": "${wrong + prevwrong}",
      };
      try {
        await collection.doc(_auth.currentUser?.uid).update(newData);

        return "Updated Successfully";
      } on FirebaseAuthException catch (e) {
        return "Failed with error code: ${e.code}";
      }
    } on FirebaseAuthException catch (e) {
      return "Failed with error code: ${e.code}";
    }
  }

  createUser(String email, String password, String name) async {
    try {
      final result = await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        final data = <String, String>{
          "name": name,
          "correctquestion": "0",
          "wrong": "0",
          "totalquestion": "0"
        };
        final db = FirebaseFirestore.instance;
        db
            .collection("users")
            .doc(_auth.currentUser?.uid)
            .set(data)
            .onError((e, _) {
          return ("Adding Data Failed");
        });
      });

      return "User created successfully";
    } on FirebaseAuthException catch (e) {
      return "Failed with error code: ${e.code}";
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
