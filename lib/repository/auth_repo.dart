import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  const AuthRepository(this._auth);

  final FirebaseAuth _auth;

  Stream<User?> get authChanges => _auth.idTokenChanges();

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print("working");
      return result.user;
    } on FirebaseAuthException catch (e) {
      print("notworking");
      if (e.code == 'user-not-found') {
        throw AuthExecption('User not found');
      } else if (e.code == 'wrong-password') {
        throw AuthExecption('Wrong Credentials');
      }
    }
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
        await collection
            .doc(_auth
                .currentUser?.uid) // <-- Doc ID where data should be updated.
            .update(newData);
        print(newData);
      } on Exception catch (e) {
        print("failerd");
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<User?> createUser(String email, String password, String name) async {
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
      });

      return result.user;
    } on FirebaseAuthException catch (e) {
      throw AuthExecption(e.code);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

class AuthExecption implements Exception {
  String error;

  AuthExecption(this.error);

  @override
  String toString() {
    print(error);
    return error;
  }
}
