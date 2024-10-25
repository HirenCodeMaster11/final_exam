import 'package:final_exam/database/dbHelper.dart';
import 'package:final_exam/modal/contactModal.dart';
import 'package:flutter/cupertino.dart';

class ContactProvider extends ChangeNotifier
{
  List contactList = [];
  var txtPhone = TextEditingController();
  var txtName = TextEditingController();
  var txtEmail = TextEditingController();
  var txtSearch = TextEditingController();
  int id = 0;

  List<ContactModal> searchListCategory = [];
  List searchList = [];
  String search = '';

  Future<void> initDatabase()
  async {
    await DbHelper.helper.initDatabase();
  }
  void getSearch(String value) {
    search = value;
    searchContact();
    notifyListeners();
  }
  Future<List<Map<String, Object?>>> searchContact() async {
    return searchList =
        await DbHelper.helper.searchContact(search);
  }

  Future<void> insertContact({required int id, required String name,required int phone,required String email})
  async {
    await DbHelper.helper.addContactToDatabase(id, name, phone, email);
    readContact();
  }

  Future<List<Map<String, Object?>>> readContact()
  async {
    return contactList = await DbHelper.helper.readAllContact();
  }

  Future<void> updateContact({required int id, required String name,required int phone,required String email})
  async {
    await DbHelper.helper.updateContact(id, name, phone, email);
    readContact();
  }
  Future<void> deleteNoteInDatabase({required int id}) async {
    await DbHelper.helper.deleteContact(id);
    readContact();
    notifyListeners();
  }

  ContactProvider()
  {
    initDatabase();
  }
}