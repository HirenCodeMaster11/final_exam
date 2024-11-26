import 'package:cloud_firestore/cloud_firestore.dart';

import 'auth.dart';

class Attendanceservice {
  Attendanceservice._();

  static Attendanceservice services = Attendanceservice._();
  final _firestore = FirebaseFirestore.instance;

  Future<void> addDataInStore({
    required int id,
    required String name,
    required String room,
    required String date,
    required String status,
  }) async {
    await _firestore
        .collection("attendance")
        .doc(id.toString())
        .set({
      'id': id,
      'name' : name,
      'room' : room,
      'date' : date,
      'status': status,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readDataFromStore() {
    return _firestore
        .collection("attendance")
        .snapshots();
  }
}
