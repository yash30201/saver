import 'package:firebase_auth/firebase_auth.dart';
import 'package:saver/services/database_services.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      // print('Auth_services.dart, line 11');
      // print(e.message);
      return null;
    }
  }

  Future signUpWithEmailAndPassword(
      String username, String rollNumber, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final DatabaseMethods _db = DatabaseMethods();
      await _db.addStudentIntoDatabase(username, rollNumber, email);
      return result.user;
    } on FirebaseAuthException catch (e) {
      // print('Auth_services.dart, line 25');
      // print(e.message);
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      // print('Auth_services.dart : line 35');
      // print(e.toString());
      return null;
    }
  }
}
