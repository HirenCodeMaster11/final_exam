import 'package:cloud_firestore/cloud_firestore.dart';

class TodoService {
  TodoService._();

  static TodoService services = TodoService._();
  final _firestore = FirebaseFirestore.instance;

  Future<void> addDataInStore({
    required int id,
    required String title,
    required String description,
    required DateTime date,
    required String status,
  }) async {
    await _firestore
        .collection("todo")
        .doc(id.toString())
        .set({
      'id': id,
      'title' : title,
      'description' : description,
      'date' : date,
      'status' : status,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readDataFromStore() {
    return _firestore
        .collection("todo")
        .snapshots();
  }
}