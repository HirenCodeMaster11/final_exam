import 'package:final_exam/DbHelper/bookHelper.dart';
import 'package:final_exam/Service/bookService.dart';
import 'package:final_exam/modal/bookModal.dart';
import 'package:flutter/widgets.dart';

class BookProvider extends ChangeNotifier {

  var txtTitle = TextEditingController();
  var txtAuthor = TextEditingController();
  var txtStatus = TextEditingController();
  var txtEmail = TextEditingController();
  var txtPass = TextEditingController();
  List bookList = [];
  int id = 0;

  void initDatabase() {
    BookHelper.helper.initDatabase();
  }

  Future<void> insertDatabase(
      {required int id,
      required String title,
      required String author,
      required String status}) async {
    await BookHelper.helper.insertData(id: id, title: title, author: author, status: status);
  }

  Future<void> cloudToLocally() async {
    final details =
    await BookServices.services.readDataFromStore().first;
    final bookDetails = details.docs.map(
          (e) {
        final data = e.data();
        return BookModal(id: id, title: data['title'], author: data['author'], status: data['status']);
      },
    ).toList();

    for (var book in bookDetails) {
      final sync = await BookHelper.helper.DataExist(id);
      if (sync) {
        await updateData(id: book.id,title: book.title,status: book.status,author: book.author);
      } else {
        await insertDatabase(id: book.id,title: book.title,status: book.status,author: book.author);
      }
    }
  }
  Future<void> updateData(
      {required int id,
        required String title,
        required String author,
        required String status}) async {
    await BookHelper.helper.updateData(id, title, author, status);
  }

  Future<void> deleteData({required int id}) async {
    await BookHelper.helper.deleteData(id);
  }

  Future<List> readData() async {
    bookList = await BookHelper.helper.readAllData();
    notifyListeners();
    return bookList;
  }

  Future<void> booksAddInStore(
      {required int id,
        required String title,
        required String author,
        required String status}) async {
    await BookServices.services.addDataInStore(
        id: id, title: title, author: author, status: status);
  }

  void clearAll() {
    txtTitle.clear();
    txtAuthor.clear();
    txtStatus.clear();
    notifyListeners();
  }

  BookProvider()
  {
    initDatabase();
  }
}