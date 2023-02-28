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

  Future<User?> createUser(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
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
