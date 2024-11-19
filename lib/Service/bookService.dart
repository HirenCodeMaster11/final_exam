import 'package:cloud_firestore/cloud_firestore.dart';

import 'auth.dart';

class BookServices {
  BookServices._();

  static BookServices services = BookServices._();
  final _firestore = FirebaseFirestore.instance;

  Future<void> addDataInStore({
    required int id,
    required String title,
    required String author,
    required String status,
  }) async {
    await _firestore
        .collection("users")
        .doc(AuthService.authService.getCurrentUser()!.email)
        .collection("books")
        .doc(id.toString())
        .set({
      'id': id,
      'title': title,
      'author': author,
      'status': status,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readDataFromStore() {
    return _firestore
        .collection("users")
        .doc(AuthService.authService.getCurrentUser()!.email)
        .collection("books")
        .snapshots();
  }
}