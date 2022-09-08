import 'package:firebase_auth/firebase_auth.dart';

class AuthManager {
  final auth = FirebaseAuth.instance;

  bool isAuthorized() {
    return auth.currentUser != null;
  }

  User? getCurrentUser() {
    return auth.currentUser;
  }

  Future<void> signUp(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw 'Please fill email and password.';
    }
    if (password.length < 6) {
      throw 'Password should contains at least 6 symbols.';
    }
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      if (e is FirebaseAuthException) {
        print(e);
        throw e.message!;
      }
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      if (e is FirebaseAuthException) {
        print(e);
        throw e.message!;
      }
    }
  }
}
