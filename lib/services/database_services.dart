import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseMethods {
  String name = "";
  addStudentIntoDatabase(
    String username,
    String rollNumber,
    String email,
  ) async {
    FirebaseFirestore.instance.collection('students').add(<String, dynamic>{
      'name': username,
      'email': email,
      'rollNumber': rollNumber,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  addManagerIntoDatabase(
    String username,
    String email,
  ) async {
    FirebaseFirestore.instance.collection('managers').add(<String, dynamic>{
      'name': username,
      'email': email,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  incrementCountOfMeal(String mealType) async {
    String _dateString = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String _fieldName = mealType + _dateString;
    try {
      await FirebaseFirestore.instance
          .collection('counts')
          .doc(_fieldName)
          .update({'count': FieldValue.increment(1)});
    } on FirebaseException catch (e) {
      // print(e.message);
      await FirebaseFirestore.instance
          .collection('counts')
          .doc(_fieldName)
          .set({'count': 1});
    }

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('previousUpdate' + mealType, _dateString);
  }
}
