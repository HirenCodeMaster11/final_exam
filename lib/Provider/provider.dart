import 'package:final_exam/DatabaseHelper/dbHelper.dart';
import 'package:final_exam/modal/modal.dart';
import 'package:flutter/material.dart';

import '../Services/attendanceService.dart';

class AttendanceProvider extends ChangeNotifier {
  var txtName = TextEditingController();
  var txtRoom = TextEditingController();
  var txtDate = TextEditingController();
  var txtStatus = TextEditingController();
  var txtEmail = TextEditingController();
  var txtPass = TextEditingController();
  var txtSearch = TextEditingController();
  List attendanceList = [];
  int id = 0;

  List searchList = [];
  String search = '';
  List searchName = [];

  void initDatabase() {
    DbHelper.helper.initDatabase();
  }

  Future<void> insertDatabase(
      {required int id,
      required String name,
      required String room,
      required String date,
      required String status}) async {
    await DbHelper.helper
        .insertData(id: id, name: name, room: room, date: date, status: status);
  }

  Future<void> cloudToLocally() async {
    final details = await Attendanceservice.services.readDataFromStore().first;
    final attendanceDetails = details.docs.map(
      (e) {
        final data = e.data();
        return AttendanceModal(
          id: id,
          name: data['name'],
          room: data['room'],
          date: data['date'],
          status: data['status'],
        );
      },
    ).toList();

    for (var attendance in attendanceDetails) {
      final sync = await DbHelper.helper.DataExist(id);
      if (sync) {
        await updateData(
            id: attendance.id,
            name: attendance.name,
            room: attendance.room,
            date: attendance.date,
            status: attendance.status);
      } else {
        await insertDatabase(
            id: attendance.id,
            name: attendance.name,
            room: attendance.room,
            date: attendance.date,
            status: attendance.status);
      }
    }
  }

  Future<void> updateData(
      {required int id,
      required String name,
      required String room,
      required String date,
      required String status}) async {
    await DbHelper.helper.updateData(id, name, room, date, status);
  }

  Future<List<Map<String, Object?>>> getName() async {
    return searchList = await DbHelper.helper.getSearchByName(search);
  }

  void searchByName(String value) {
    search = value;
    getName();
    notifyListeners();
  }

  Future<void> deleteData({required int id}) async {
    await DbHelper.helper.deleteData(id);
  }

  Future<List> readData() async {
    attendanceList = await DbHelper.helper.readAllData();
    notifyListeners();
    return attendanceList;
  }

  Future<void> attendanceAddInStore(
      {required int id,
      required String name,
      required String room,
      required String date,
      required String status}) async {
    await Attendanceservice.services.addDataInStore(
        id: id, name: name, room: room, date: date, status: status);
  }

  void clearAll() {
    txtName.clear();
    txtRoom.clear();
    txtDate.clear();
    txtStatus.clear();
    notifyListeners();
  }

  AttendanceProvider() {
    initDatabase();
  }
}
