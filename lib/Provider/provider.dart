import 'package:flutter/material.dart';

import '../DbHelper/helper.dart';
import '../modal/modal.dart';
import '../services/todoServices.dart';

class TodoProvider extends ChangeNotifier {
  var txtTitle = TextEditingController();
  var txtDate = TextEditingController();
  var txtStatus = TextEditingController();
  var txtDes = TextEditingController();
  var txtEmail = TextEditingController();
  var txtPass = TextEditingController();

  var txtSearch = TextEditingController();
  List todoList = []; //add data
  int id = 0;

  List searchList = [];
  String search = '';
  List searchName = [];

  DateTime selectedDate = DateTime.now();

  void initDatabase() {
    DbHelper.helper.initDatabase();
  }

  Future<void> insertDatabase(
      {required int id,
        required String title,
        required DateTime date,
        required String status,
        required String description})   async {
    await DbHelper.helper.insertData(id: id, title: title, description: description,date: date, status: status);
  }

  Future<void> cloudToLocally() async {
    final details = await TodoService.services.readDataFromStore().first;

    final myDetails = details.docs.map(
          (e) {
        final data = e.data();
        return TodoModal(
          id: data['id'],
          title: data['title'],
          date: data['date'],
          status: data['status'],
          description: data['description'],
        );
      },
    ).toList();

    for (var todo in myDetails) {
      try {
        final sync = await DbHelper.helper.DataExist(todo.id);
        if (sync) {
          await DbHelper.helper.updateData(
            todo.id,
            todo.title,
            todo.description,
            todo.date,
            todo.status,
          );
        } else {
          await DbHelper.helper.insertData(
            id: todo.id,
            title: todo.title,
            description: todo.description,
            date: todo.date,
            status: todo.status,
          );
        }
      } catch (e) {
        print('Error processing ID: ${todo.id}, Error: $e');
      }
    }
  }



  Future<void> updateData(
      {required int id,
        required String title,
        required String description,
        required DateTime date,
        required String status,
      }) async {
    await DbHelper.helper.updateData(id, title,description,date,status);
  }

  Future<List<Map<String, Object?>>> getTitle() async {
    return searchList = await DbHelper.helper.getSearchByTitle(search);
  }

  void searchByTitle(String value) {
    search = value;
    getTitle();
    notifyListeners();
  }

  Future<void> deleteData({required int id}) async {
    await DbHelper.helper.deleteData(id);
  }

  Future<List> readData() async {
    todoList = await DbHelper.helper.readAllData();
    notifyListeners();
    return todoList;
  }

  Future<void> todoAddInStore(
      {required int id,
        required String title,
        required String description,
        required DateTime date,
        required String status,
        }) async {
    await TodoService.services.addDataInStore(
        id: id, title: title,date: date,status: status,description: description);
  }

  void clearAll() {
    txtTitle.clear();
    txtDate.clear();
    txtStatus.clear();
    txtPass.clear();
    txtEmail.clear();
    notifyListeners();
  }

  MyProvider() {
    initDatabase();
  }
}